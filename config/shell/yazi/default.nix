{pkgs,...}:
{
  programs.yazi = {
    enable = true;
    shellWrapperName = "ra"; 
    initLua = ./init.lua;
    plugins = {
      "lazygit" = pkgs.yaziPlugins.lazygit;
      "yamb" = pkgs.yaziPlugins.yamb;
    };
    keymap.mgr.prepend_keymap = [
      {
        on = [ "g" "i" ];
        run = "plugin lazygit";
        desc = "run lazygit";
      }
      {
        on = [ "u" "a" ];
        run = "plugin yamb -- save";
        desc = "Add bookmark";
      }
      {
        on = [ "u" "g" ];
        run = "plugin yamb -- jump_by_key";
        desc = "Jump bookmark by key";
      }
      {
        on = [ "u" "G" ];
        run = "plugin yamb -- jump_by_fzf";
        desc = "Jump bookmark by fzf";
      }
      {
        on = [ "u" "d" ];
        run = "plugin yamb -- delete_by_key";
        desc = "Delete bookmark by key";
      }
      {
        on = [ "u" "D" ];
        run = "plugin yamb -- delete_by_fzf";
        desc = "Delete bookmark by fzf";
      }
      {
        on = [ "u" "A" ];
        run = "plugin yamb -- delete_all";
        desc = "Delete all bookmarks";
      }
      {
        on = [ "u" "r" ];
        run = "plugin yamb -- rename_by_key";
        desc = "Rename bookmark by key";
      }
      {
        on = [ "u" "R" ];
        run = "plugin yamb -- rename_by_fzf";
        desc = "Rename bookmark by fzf";
      }
    ];
  };
}
