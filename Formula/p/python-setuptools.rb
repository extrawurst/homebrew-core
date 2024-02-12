class PythonSetuptools < Formula
  desc "Easily download, build, install, upgrade, and uninstall Python packages"
  homepage "https://setuptools.pypa.io/"
  url "https://files.pythonhosted.org/packages/c9/3d/74c56f1c9efd7353807f8f5fa22adccdba99dc72f34311c30a69627a0fad/setuptools-69.1.0.tar.gz"
  sha256 "850894c4195f09c4ed30dba56213bf7c3f21d86ed6bdaafb5df5972593bfc401"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "7401711f1383d56eafe4ce69a9f6c80527627a63c6dbe26945eaf778cd14b836"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "618fc870d2b418f33b855bf3292e63a20217f3d46b9374213569e02469ff95d3"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "83abdbe36f879939e74437be475abab07502d6eed57924da2db723d61d3918b0"
    sha256 cellar: :any_skip_relocation, sonoma:         "de72395d2db740d32a41bba965d66d69616369104fbb02c2971ad3a36a1717fd"
    sha256 cellar: :any_skip_relocation, ventura:        "c9804924c407eb0eca15bcb7080eaa05fe192ce0cb2dd6d29d77a56e8987fcf8"
    sha256 cellar: :any_skip_relocation, monterey:       "a25631d40983d9fc23163821bbe0025d61d425666804f955f66cef9d6e2e6f67"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e7cc325af6ffb81ca8a869984ddf5ace890f841db607126a68c906024499bc05"
  end

  depends_on "python@3.12" => [:build, :test]

  def pythons
    deps.map(&:to_formula)
        .select { |f| f.name.match?(/^python@\d\.\d+$/) }
        .map { |f| f.opt_libexec/"bin/python" }
  end

  def install
    pythons.each do |python|
      system python, "-m", "pip", "install", *std_pip_args, "."
    end
  end

  test do
    pythons.each do |python|
      system python, "-c", "import setuptools"
    end
  end
end
