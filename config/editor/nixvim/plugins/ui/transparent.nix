{
  plugins.transparent.enable = true;
  plugins.transparent.settings = {
    extra_groups = [
      "NormalFloat"
      "NvimTreeNormal"
      "TelescopeNormal"
    ];
  };
  extraConfigLua = ''
    -- Bufferline
    -- require("transparent").clear_prefix("BufferLine")
    -- require 'transparent'.clear_prefix("TabLine")
    -- require 'transparent'.clear_prefix("WildMenu") -- possibly not necessary

    -- Lualine
    -- require("transparent").clear_prefix("lualine")

    -- Neo-tree
    require("transparent").clear_prefix("NeoTree")
  '';
}
