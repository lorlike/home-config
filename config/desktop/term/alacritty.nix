{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "JetBrainsMono Nerd Font";
        size = 8.0;
      };
      window.opacity = 1;
      colors.primary.background = "#2e3440";
      keyboard = {
        bindings = [
          {
            key = "Enter";
            mods = "Shift|Alt";
            chars = "\\u001b[13;4u";
          }
        ];
      };
    };
  };
}
