class Apizr < Formula
  include Language::Python::Virtualenv

  desc "Analyze Python repositories and prepare governed application interfaces"
  homepage "https://apizr.outerspace.sh"
  url "https://github.com/Alien6-Studio/outerspace-apizr/releases/download/v0.4.3/outerspace_apizr-0.4.3.tar.gz"
  sha256 "822316e92a313f46f99dd32fda636c377b578b141a00aa63168475ef450ed24f"
  license "GPL-3.0-or-later"

  depends_on "pydantic"
  depends_on "python@3.14"

  resource "hatchling" do
    url "https://files.pythonhosted.org/packages/0d/a5/48cb7efb8b4718b1a4c0c331e3364a3a33f614ff0d6afd2b93ee883d3c47/hatchling-1.28.0-py3-none-any.whl", using: :nounzip
    sha256 "dc48722b68b3f4bbfa3ff618ca07cdea6750e7d03481289ffa8be1521d18a961"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/63/34/ba1c580383c9eada3711951fef0795c80b829a078d72188184bcab9dd527/packaging-26.3-py3-none-any.whl", using: :nounzip
    sha256 "d7193f7c8e4e93f444fde0262bf90af30e16fa0ad0ad44cb553c87339b23cd1c"
  end

  resource "pathspec" do
    url "https://files.pythonhosted.org/packages/f1/d9/7fb5aa316bc299258e68c73ba3bddbc499654a07f151cba08f6153988714/pathspec-1.1.1-py3-none-any.whl", using: :nounzip
    sha256 "a00ce642f577bf7f473932318056212bc4f8bfdf53128c78bbd5af0b9b20b189"
  end

  resource "pluggy" do
    url "https://files.pythonhosted.org/packages/54/20/4d324d65cc6d9205fabedc306948156824eb9f0ee1633355a8f7ec5c66bf/pluggy-1.6.0-py3-none-any.whl", using: :nounzip
    sha256 "e920276dd6813095e9377c0bc5566d94c932c33b27a3e3945d8389c374dd4746"
  end

  resource "trove-classifiers" do
    url "https://files.pythonhosted.org/packages/30/81/0da8afb52a71d0a4f2bd3152357b1a441e393b286374802b9d3addab4ab5/trove_classifiers-2026.9.21.13-py3-none-any.whl", using: :nounzip
    sha256 "8b1ff4f9c191b1040b71c37f1e445ab99732911e3cd91de52838453a854d7a17"
  end

  deny_network_access! :build

  def install
    # These reviewed wheels feed PEP 517 only; never install resources into libexec.
    wheelhouse = buildpath/"build-wheelhouse"
    resources.each { |r| r.stage wheelhouse }
    python = formula_opt_bin("python@3.14")/"python3.14"
    virtualenv_create(libexec, python, system_site_packages: true)

    ENV.keys.grep(/^PIP_/).each { |key| ENV.delete(key) }
    ENV["PIP_CONFIG_FILE"] = File::NULL
    ENV["PIP_NO_INDEX"] = "1"
    ENV["PIP_FIND_LINKS"] = wheelhouse.to_s
    ENV["PIP_CACHE_DIR"] = (buildpath/"empty-pip-cache").to_s
    ENV["PIP_DISABLE_PIP_VERSION_CHECK"] = "1"
    ENV["PYTHONDONTWRITEBYTECODE"] = "1"
    # std_pip_args supplies --no-deps. Its blanket source-only rule must be reset
    # for the five reviewed build wheels; the application is still this local sdist.
    system python, "-m", "pip", "--python=#{libexec}/bin/python", "install",
           *std_pip_args(prefix: false, build_isolation: true),
           "--no-binary=:none:", "--no-cache-dir", buildpath
    bin.install_symlink libexec/"bin/apizr"
  end

  test do
    assert_match "outerspace-apizr 0.4.3", shell_output("#{bin}/apizr --version")
    (testpath/"sample.py").write <<~PYTHON
      def add(a: int, b: int = 2) -> int:
          return a + b
    PYTHON
    system bin/"apizr", "init", testpath, "--json"
    assert_path_exists testpath/"apizr.toml"
    system bin/"apizr", "doctor", "--project", testpath/"apizr.toml",
           "--operator-policy", testpath/".apizr/operator.json", "--json"
    system bin/"apizr", "ci", "check", "--project", testpath/"apizr.toml",
           "--output-dir", testpath/"evidence", "--authorize-project-analysis"
    assert_path_exists testpath/"evidence/result.json"
  end
end
