{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    docker-compose-language-service
    dockerfile-language-server-nodejs
    gopls
    marksman
    nixd
    prettierd
    stylua
    svelte-language-server
    typescript-language-server
    vscode-langservers-extracted
  ];
}
