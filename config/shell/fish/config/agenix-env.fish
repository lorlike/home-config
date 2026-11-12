# 把 agenix 解密的 dotenv 文件（apikey.age）导入 fish 环境变量。
# 对应 zsh 侧的 `source $XDG_RUNTIME_DIR/agenix/apikey`。

set -l __agenix_env_file "$XDG_RUNTIME_DIR/agenix/apikey"

if test -r "$__agenix_env_file"
    for __line in (cat "$__agenix_env_file")
        # 跳过空行与注释行
        string match -qr '^\s*(#|$)' -- $__line; and continue

        # 兼容 `export KEY=VALUE` 写法
        string match -rq '^\s*export\s+' -- $__line; and set __line (string replace -r '^\s*export\s+' '' -- $__line)

        set -l __kv (string split -m1 '=' -- $__line)
        set -l __key (string trim -- $__kv[1])
        set -l __val (string trim -- $__kv[2])

        # 只接受合法的环境变量名
        string match -qr '^[A-Za-z_][A-Za-z0-9_]*$' -- $__key; or continue

        # 去掉成对的引号
        if string match -qr '^".*"$' -- $__val
            set __val (string sub -s 2 -e -1 -- $__val)
        else if string match -qr "^'.*'\$" -- $__val
            set __val (string sub -s 2 -e -1 -- $__val)
        end

        set -gx $__key $__val
    end
end

set -e __agenix_env_file
