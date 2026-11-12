# 编辑器：helix 是纯 CLI，两台机器都用。
#
# nixvim **不在**这里 —— 它依赖大量 vim 插件、LSP 和 treesitter 解析器，
# 服务器上既用不到又要下载几百个 derivation。它由 hosts/desktop.nix 单独导入。
{
  imports = [
    ./helix.nix
  ];
}
