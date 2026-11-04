# cargo.fish — rustup 环境（对应 zsh/config/init.zsh 的 `source "$HOME/.cargo/env"`）
#
# zsh 那份脚本只做一件事：把 ~/.cargo/bin 前插到 PATH。fish 里不需要 source
# 那个 sh 脚本，直接操作 $PATH 即可（且避免了 sh 语法在 fish 中不可执行的问题）。

set -l __cargo_bin "$HOME/.cargo/bin"

if test -d "$__cargo_bin"
    if not contains "$__cargo_bin" $PATH
        set -gx PATH "$__cargo_bin" $PATH
    end
end

set -e __cargo_bin
