
# $0 在 source 时指向本文件（FUNCTION_ARGZERO 默认开启），用绝对目录避免
# 依赖 cwd 或 PATH 查找。注意本文件会被 home-manager 软链到 Nix store，
# 所以只能用 ${0:A:h} 取目录，不能写死 ~/.config。
__cfg_dir="${0:A:h}"

[ -r "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# eval "$(starship init zsh)"
# eval "$(zoxide init zsh)"

if [ -r "$__cfg_dir/proxy.zsh" ]; then
  source "$__cfg_dir/proxy.zsh"
fi
# source "$__cfg_dir/pnpm_init.zsh"

# 可选的外设辅助函数（wifi / touchpad），由 config/desktop/peripherals 提供。
# 服务器上没这个目录，用 (N) 让通配符匹配不到时展开为空而不是报错。
for __f in "$HOME"/.config/zsh/peripherals/*.zsh(N); do
  if [ -r "$__f" ]; then
    source "$__f"
  fi
done
unset __f

# agenix 解密的密钥只有配置了 age.secrets 的机器才有
if [ -r "$XDG_RUNTIME_DIR/agenix/apikey" ]; then
  source "$XDG_RUNTIME_DIR/agenix/apikey"
fi

unset __cfg_dir
