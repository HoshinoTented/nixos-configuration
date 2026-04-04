{ pkgs, ... }:
with pkgs;
(vscode-with-extensions.override {
  vscodeExtensions = with vscode-extensions; [
    k--kato.intellij-idea-keybindings
    # ms-vscode.cmake-tools
    rust-lang.rust-analyzer
    vadimcn.vscode-lldb
    jnoortheen.nix-ide
    mads-hartmann.bash-ide-vscode
    ms-vscode-remote.remote-ssh
    # anthropic.claude-code
  ] ++ vscode-utils.extensionsFromVscodeMarketplace [
    {
      publisher = "yellpika";
      name = "latex-input";
      version = "2.3.0";
      sha256 = "sha256-wWhqMbHzUW9Ar44Jur0zZPM/bTQD04sD2J2L0v4qmcs=";
    }
    # {
    #   name = "chatgpt";
    #   publisher = "openai";
    #   version = "26.325.31654";
    #   sha256 = "sha256-etLxucTfEE27LDMpJ8Bw2GlTHJRWPY1vAvufrgXVwl8=";
    # }
    # edit multiline by C-SPC and C-x r t
    # {
    #   publisher = "fsiovn";
    #   name = "ai-gateway";
    #   version = "0.1.4";
    #   sha256 = "sha256-JWWwxMMwrr7Svz2iZ6CuWrXe+SS+VRyrdHoYwDHel7c=";
    # }
  ];
})
