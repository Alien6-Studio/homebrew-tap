class Apizr < Formula
  include Language::Python::Virtualenv

  desc "Analyze Python repositories and prepare governed application interfaces"
  homepage "https://apizr.outerspace.sh"
  url "https://github.com/Alien6-Studio/outerspace-apizr/releases/download/v0.4.6/outerspace_apizr-0.4.6.tar.gz"
  sha256 "2016633890ba59f5768d61a9e2546f08b4a8c220118cff4bdbbb57d87151ee54"
  license "GPL-3.0-or-later"

  depends_on "pydantic"
  depends_on "python@3.15"

  resource "hatchling" do
    url "https://files.pythonhosted.org/packages/5f/80/91f51f439c05d4ec4623c22928ce16a938d6d793bf709477830823497859/hatchling-1.32.4-py3-none-any.whl", using: :nounzip
    sha256 "08ecf7548fb48205e7f213d70c71e67b8271b7242093dc3f1da578b42c734a2c"
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
    url "https://files.pythonhosted.org/packages/40/9e/2b38731e0fc536806f16490e1a12d7f0dc2a1235aa8cc07bcc75416a7daa/pluggy-1.7.0-py3-none-any.whl", using: :nounzip
    sha256 "7dd7b0d8832ba3cb632c306926ded123429211b83641b35dc5c41ad2d34f9bec"
  end

  resource "tomlkit" do
    url "https://files.pythonhosted.org/packages/13/bc/8c13eb66537dce1d2bd3a57132902f38d0e7f5bb46fa9f4daed9fe9d76ee/tomlkit-0.15.1-py3-none-any.whl", using: :nounzip
    sha256 "177a05aece5a8ca5266fd3c448abb47b8d352f09d477d3ca8332db4d89b24304"
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
    python = formula_opt_bin("python@3.15")/"python3.15"
    virtualenv_create(libexec, python, system_site_packages: false)

    ENV.keys.grep(/^PIP_/).each { |key| ENV.delete(key) }
    ENV["PIP_CONFIG_FILE"] = File::NULL
    ENV["PIP_NO_INDEX"] = "1"
    ENV["PIP_FIND_LINKS"] = wheelhouse.to_s
    ENV["PIP_CACHE_DIR"] = (buildpath/"empty-pip-cache").to_s
    ENV["PIP_DISABLE_PIP_VERSION_CHECK"] = "1"
    ENV["PYTHONDONTWRITEBYTECODE"] = "1"
    # std_pip_args supplies --no-deps. Its blanket source-only rule must be reset
    # for the six reviewed build wheels; the application is still this local sdist.
    system python, "-m", "pip", "--python=#{libexec}/bin/python", "install",
           *std_pip_args(prefix: false, build_isolation: true),
           "--no-binary=:none:", "--no-cache-dir", buildpath
    bin.install_symlink libexec/"bin/apizr"
  end

  test do
    assert_match "outerspace-apizr 0.4.6", shell_output("#{bin}/apizr --version")
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
