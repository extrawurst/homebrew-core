class XdgNinja < Formula
  desc "Check your $HOME for unwanted files and directories"
  homepage "https://github.com/b3nj5m1n/xdg-ninja"
  url "https://github.com/b3nj5m1n/xdg-ninja/archive/refs/tags/v0.2.0.2.tar.gz"
  sha256 "6adfe289821b6b5e3778130e0d1fd1851398e3bce51ddeed6c73e3eddcb806c6"
  license "MIT"
  head "https://github.com/b3nj5m1n/xdg-ninja.git", branch: "main"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, all: "4c895e06a666107940b90eabd7928642959380ad33079fd5430cb61aba0ff620"
  end

  depends_on "glow"
  depends_on "jq"

  def install
    pkgshare.install "programs/"
    pkgshare.install "xdg-ninja.sh" => "xdg-ninja"
    (bin/"xdg-ninja").write_env_script(pkgshare/"xdg-ninja", XN_PROGRAMS_DIR: pkgshare/"programs")
    man1.install "man/xdg-ninja.1"
  end

  test do
    system bin/"xdg-ninja"
  end
end
