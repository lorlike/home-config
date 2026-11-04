# proxy.zsh — proxy 切换开关

pproxy() {
  local addr="http://localhost:7897"

  if [[ -n "$https_proxy" ]]; then
    unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY
    echo "proxy OFF"
  else
    export http_proxy="$addr" https_proxy="$addr"
    export HTTP_PROXY="$addr" HTTPS_PROXY="$addr"
    echo "proxy ON  $addr"
  fi
}

# ── 追加：只给单条命令注入代理（当前 shell 不受影响，pproxy 保持原样）──
# 换端口可临时覆盖：PROXY_ADDR=http://127.0.0.1:7890 withproxy curl ipinfo.io
: "${PROXY_ADDR:=http://localhost:7897}"
: "${PROXY_NO:=localhost,127.0.0.1,::1}"

withproxy() {
  ( export http_proxy="$PROXY_ADDR" https_proxy="$PROXY_ADDR"
    export HTTP_PROXY="$PROXY_ADDR" HTTPS_PROXY="$PROXY_ADDR"
    export no_proxy="$PROXY_NO"     NO_PROXY="$PROXY_NO"
    "$@" )
}

# 反向：即使 pproxy 已经全局开着，这一条命令强制不走代理
noproxy() { ( unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY; "$@" ) }

# 要「自动加代理并打开」的命令，在这里加 alias（zsh 不递归展开同名 alias，安全）
# alias gh='withproxy gh'
alias gtt='withproxy gtt'
