# proxy.fish — proxy 切换开关（对应 zsh/config/proxy.zsh）

# 一键开关全局代理：已开则关，未开则开
function pproxy --description "切换全局代理开关 (localhost:7897)"
    set -l addr "http://localhost:7897"

    if set -q https_proxy
        set -e http_proxy https_proxy HTTP_PROXY HTTPS_PROXY
        echo "proxy OFF"
    else
        set -gx http_proxy $addr
        set -gx https_proxy $addr
        set -gx HTTP_PROXY $addr
        set -gx HTTPS_PROXY $addr
        echo "proxy ON  $addr"
    end
end

# ── 只给单条命令注入代理（当前 shell 不受影响，pproxy 保持原样）──
# 换端口可临时覆盖：PROXY_ADDR=http://127.0.0.1:7890 withproxy curl ipinfo.io
set -q PROXY_ADDR; or set -g PROXY_ADDR "http://localhost:7897"
set -q PROXY_NO; or set -g PROXY_NO "localhost,127.0.0.1,::1"

function withproxy --description "仅在本次命令中启用代理"
    env \
        http_proxy=$PROXY_ADDR \
        https_proxy=$PROXY_ADDR \
        HTTP_PROXY=$PROXY_ADDR \
        HTTPS_PROXY=$PROXY_ADDR \
        no_proxy=$PROXY_NO \
        NO_PROXY=$PROXY_NO \
        $argv
end

# 反向：即使 pproxy 已经全局开着，这一条命令强制不走代理
function noproxy --description "仅在本次命令中禁用代理"
    env -u http_proxy -u https_proxy -u HTTP_PROXY -u HTTPS_PROXY \
        -u no_proxy -u NO_PROXY \
        $argv
end

# 需要「自动加代理」的命令在这里包装（env 会从 PATH 查找到外部命令，
# 不会递归回本函数）
function gtt --description "gtt 走代理"
    withproxy gtt $argv
end
