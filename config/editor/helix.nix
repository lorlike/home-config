{pkgs, ...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "nord";
      editor = {
        line-number = "relative";
        cursorline = true;
        # color-modes = true;
        bufferline = "multiple";
        # auto-save = true;
        # auto-format = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        file-picker.hidden = false;
        lsp.display-inlay-hints = true;
      };
      keys.normal = {
        "S-h" = "goto_previous_buffer";
        "S-l" = "goto_next_buffer";
        "A-j" = ["extend_to_line_bounds" "delete_selection" "paste_after"];
        "A-k" = [
          "extend_to_line_bounds"
          "delete_selection"
          "move_line_up"
          "paste_before"
        ];
      };
      keys.insert = {
        "C-[" = "normal_mode";
        "j"."k" = "normal_mode";
      };
      keys.select = {
        "C-[" = "normal_mode";
        # "j"."k" = "normal_mode";
        "A-j" = ["extend_to_line_bounds" "delete_selection" "paste_after"];
        "A-k" = [
          "extend_to_line_bounds"
          "delete_selection"
          "move_line_up"
          "paste_before"
        ];
      };
    };
    extraPackages = with pkgs; [
      gopls
      nil
      nixd
      rust-analyzer
      typescript-language-server
      vscode-langservers-extracted
      # nixfmt-rfc-style
      # rustfmt
      # pylsp
      # basedpyright
    ];
  };
}
