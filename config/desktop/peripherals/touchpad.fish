# touchpad.fish — 触摸板开关

function touchpad --description "切换触摸板开关（xinput）"
    set -l id (xinput | string match -r 'Touchpad.*id=(\d+)' | string replace -r '.*id=(\d+)' '$1' | head -n1)

    if test -z "$id"
        echo "未找到触摸板设备" >&2
        return 1
    end

    if xinput list-props $id | string match -qr 'Device Enabled.*:\s*1'
        xinput disable $id; and echo "触摸板 ($id) 已关闭"
    else
        xinput enable $id; and echo "触摸板 ($id) 已开启"
    end
end
