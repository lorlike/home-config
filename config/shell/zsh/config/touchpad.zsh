# toucpad switch
function touchpad(){
  local id=$(xinput | grep -oP 'Touchpad.*id=\K\d+')
  if [[ -z "$id" ]]; then
    echo "未找到触摸板设备" >&2
    return 1
  fi
  if xinput list-props "$id" | grep -qi "Device Enabled.*:.*1"; then
    xinput disable "$id" && echo "触摸板 ($id) 已关闭"
  else
    xinput enable "$id" && echo "触摸板 ($id) 已开启"
  fi
}
