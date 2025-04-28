{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    arduino-cli
    arduino-language-server
    clang-tools
    docker-compose-language-service
    dockerfile-language-server-nodejs
    gopls
    lldb
    marksman
    nixd
    prettierd
    stylua
    lua-language-server
    svelte-language-server
    typescript-language-server
    vscode-langservers-extracted
    sqlfluff
    glsl_analyzer

    # python
    mypy
    isort
    black
    pylint
    python312Packages.python-lsp-server
  ];
}
