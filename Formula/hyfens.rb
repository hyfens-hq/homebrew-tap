class Hyfens < Formula
  desc "Open-source Flutter live-update infrastructure CLI"
  homepage "https://hyfens.com"
  version "0.1.6"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.6/hyfens-0.1.6-macos-arm64.tar.gz"
      sha256 "06be7b1c36702c058f8e12bc5a92e6dbfbe8c518ca867267d6b36b21d5e0d482"
    else
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.6/hyfens-0.1.6-macos-x64.tar.gz"
      sha256 "b76f99d5fabb1f699358f3863f9091210a26f105922b61bb98188120575d83d3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.6/hyfens-0.1.6-linux-arm64.tar.gz"
      sha256 "6dada101bd45f3e0022528d480812028ca3991c8bb3a3cd8720851985b484a49"
    else
      url "https://github.com/hyfens-hq/hyfens/releases/download/v0.1.6/hyfens-0.1.6-linux-x64.tar.gz"
      sha256 "b037b5272c3415251e1140c044423abbb23f78fb89739b7b82521ed56071036a"
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
