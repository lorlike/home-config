{pkgs,...}:
{
  programs.zed-editor = {
    enable = true;
    userSettings = {
      buffer_font_size = 12;
      ui_font_size = 12;
      # helix_mode = true;
    };
    userKeymaps = [
      {
        context = "Editor && (vim_mode == visual || vim_mode == helix_select || vim_mode == insert)";
        bindings = {
          "j k" = "vim::NormalBefore";
        };
      }
    ];
    userSettings = {
      agent={
        commit_message_model = {
          provider = "openrouter";
          model = "nvidia/nemotron-3-ultra-550b-a55b:free";
        };
        commit_message_instructions = "请使用 Conventional Commits 格式：<type>(<scope>): <description>。描述使用中文。";
      };
    };
    extraPackages = with pkgs; [
      nil
      nixd
      # rust-analyzer
      typescript-language-server
      vscode-langservers-extracted
      # nixfmt-rfc-style
      # rustfmt
      # pylsp
      # basedpyright
    ];
  };
}
