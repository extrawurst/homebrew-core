class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org/"
  url "https://github.com/jreleaser/jreleaser/releases/download/v1.12.0/jreleaser-1.12.0.zip"
  sha256 "e72b06f31d2f9f4c00f78e12d5073725d0379506e5455dd6391de1fc514bfc48"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "1335c3299ae14f77c6099b47f55f3d80148741111408dd06af977cb5bb3717fb"
  end

  depends_on "openjdk"

  def install
    libexec.install Dir["*"]
    (bin/"jreleaser").write_env_script libexec/"bin/jreleaser", Language::Java.overridable_java_home_env
  end

  test do
    expected = <<~EOS
      [INFO]  Writing file #{testpath}/jreleaser.toml
      [INFO]  JReleaser initialized at #{testpath}
    EOS
    assert_match expected, shell_output("#{bin}/jreleaser init -f toml")
    assert_match "description = \"Awesome App\"", (testpath/"jreleaser.toml").read

    assert_match "jreleaser #{version}", shell_output("#{bin}/jreleaser --version")
  end
end
