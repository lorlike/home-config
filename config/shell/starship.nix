{pkgs,...}:
{
  programs.starship = {
    enable = true;
    extraPackages = with pkgs;[
      jj-starship
    ];
    settings = {
      custom.jj = {
        when = "jj-starship detect";
        shell = ["jj-starship"];
        format = "$output";
      };
      git_branch.disabled = true;
      git_status.disabled = true;
      git_commit.disabled = true;
    };
  };
}
