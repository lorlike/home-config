# cargo.fish — rustup 环境（前插 ~/.cargo/bin 到 PATH）
#
# 直接操作 $PATH 即可，
# 不需要 source 那个 sh 脚本（sh 语法在 fish 中也不可执行）。

set -l __cargo_bin "$HOME/.cargo/bin"

if test -d "$__cargo_bin"
    if not contains "$__cargo_bin" $PATH
        set -gx PATH "$__cargo_bin" $PATH
    end
end

set -e __cargo_bin
