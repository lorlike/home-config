# wifi.fish — wifi 控制（对应 wifi.zsh）

function wifi --description "wifi 控制：list / hotspot"
    switch "$argv[1]"
        case list
            nmcli device wifi rescan; and nmcli device wifi list
        case hotspot
            nmcli device wifi connect "Ciallo～(∠・ω< )⌒☆" password "0d000721"
        case '*'
            echo default
    end
end

# 补全 list / hotspot
complete -c wifi -f -n '__fish_use_subcommand' -a list -d '扫描并列出附近 wifi'
complete -c wifi -f -n '__fish_use_subcommand' -a hotspot -d '连接预设热点'
