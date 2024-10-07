{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nixd
    docker-compose-language-service
    gopls
    vscode-langservers-extracted
    marksman
    tailwindcss
    typescript-language-server
    prettierd
    stylua
  ];
}
