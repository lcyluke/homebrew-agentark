class Agentark < Formula
  desc "⚡ AgentArk — Multi-Agent Operating System. One person, infinite capacity."
  homepage "https://github.com/lcyluke/agentark"
  url "https://github.com/lcyluke/agentark/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "d43f223892c2b6e52c63297f476d9c0e001fb1db7b6912b052dcf31c99ef199a"
  license "MIT"

  depends_on "python@3.12"
  depends_on "tmux"

  def install
    system Formula["python@3.12"].opt_bin/"python3.12", "-m", "venv",
           "--system-site-packages", libexec
    system libexec/"bin/pip", "install", "--retries", "3",
           "--only-binary", ":all:", "."
    bin.install_symlink libexec/"bin/agentark"
  end

  def post_install
    version_check = Utils.popen_read(libexec/"bin/agentark", "--version").strip
    if version_check.include?("0.5.1")
      ohai "✅ AgentArk v0.5.1 installed successfully!"
      puts "   #{version_check}"
    else
      opoo "Install completed but version mismatch: #{version_check}"
    end
    puts ""
    puts "Quickstart:"
    puts "  agentark tutorial              Interactive walkthrough"
    puts "  agentark fleet init            Create profiles + launch fleet"
    puts "  agentark fleet lan discover    Find other Macs on LAN"
    puts "  agentark fleet dispatch -h     Resource-aware task dispatch"
    puts "  agentark doctor                System diagnostics"
    puts ""
  end

  test do
    output = shell_output("#{bin}/agentark --version 2>&1 || true")
    assert_match "AgentArk", output
  end

  def caveats
    <<~EOS
      ⚓ AgentArk — Multi-Agent Operating System
      46 agents, 30 commands, one CLI.

      Quickstart:
        agentark tutorial              Interactive 5-step walkthrough
        agentark fleet init            Create profiles + launch fleet
        agentark fleet lan discover    Find other Macs on LAN
        agentark fleet dispatch -h     Resource-aware task dispatch
        agentark doctor                System diagnostics

      Works on macOS, Linux, and Windows (WSL).
      Docs: https://github.com/lcyluke/agentark
    EOS
  end
end
