{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "lorlike";
        email = "lorlike.me@gmail.com";
      };
      snapshot.auto-update-stale = true;
    };
  };
}
