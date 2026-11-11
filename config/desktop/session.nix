# 桌面会话相关：tty1 登录时自动启动 X。
#
# 只在桌面机器上导入。服务器上这段脚本会在每次 tty 登录时尝试 startx，
# 没有 X 会直接失败，所以放在 desktop 层。
{lib, ...}: {
  programs.zsh.profileExtra = lib.mkAfter ''
    if [[ -z "$DISPLAY" && "$(tty)" == "/dev/tty1" ]]; then
      exec startx
    fi
  '';

  programs.fish.loginShellInit = lib.mkAfter ''
    if not set -q DISPLAY; and test (tty) = /dev/tty1
      exec startx
    end
  '';
}
