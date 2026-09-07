class Hyfens < Formula
  desc "Open-source Flutter live-update infrastructure CLI"
  homepage "https://hyfens.com"
  version "0.1.9"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.9/hyfens-0.1.9-macos-arm64.tar.gz"
      sha256 "41037f5897ddaa0688555f6b95f7222b8079cfd20d9508b55edb3f09b78aa9dd"
    else
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.9/hyfens-0.1.9-macos-x64.tar.gz"
      sha256 "526e8c1bf0973ad7f5483dee936662b2872daa99ad20d87a54ee7698c9476554"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.9/hyfens-0.1.9-linux-arm64.tar.gz"
      sha256 "8b8046e3a8d73541bd1e702250e7c07930bde73508f9bb152f6f645b72b09b7e"
    else
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.9/hyfens-0.1.9-linux-x64.tar.gz"
      sha256 "987ba58f636332b5f5e2e9f858f0f9428cfec8c5f8d534949b0cf03cc3911b22"
    end
  end

  def install
    root_dir = if File.exist?("bin/hyfens")
      "."
    else
      Dir["hyfens-*"].find { |entry| File.exist?("#{entry}/bin/hyfens") }
    end
    raise "Hyfens archive root was not found" if root_dir.nil?

    bin_dir = "#{root_dir}/bin"
    lib_dir = "#{root_dir}/lib"
    runtime_dir = "#{root_dir}/runtime"
    raise "Hyfens runtime bundle was not found" unless Dir.exist?(runtime_dir)

    bin.install "#{bin_dir}/hyfens"
    bin.install "#{bin_dir}/tool" => "tool"
    lib.install Dir["#{lib_dir}/*"] if Dir.exist?(lib_dir)
    prefix.install runtime_dir
  end

  test do
    system bin / "hyfens", "--version"
    assert_path_exists prefix/"runtime/hyfens_flutter_integration/lib/flutter_integration.dart"
    assert_path_exists prefix/"runtime/path_provider/lib/path_provider.dart"
    assert_path_exists prefix/"runtime/objective_c/hook/build.dart"
  end
end
