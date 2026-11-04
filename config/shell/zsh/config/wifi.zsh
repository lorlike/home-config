# wifi control
function wifi(){
  case "$1" in
    list) nmcli device wifi rescan&&nmcli device wifi list
    ;;
    hotspot) nmcli device wifi connect "Ciallo～(∠・ω< )⌒☆" password "0d000721"
    ;;
    *) echo default
    ;;
  esac
  
}
_wifi_completion() {
    compadd list hotspot
}
compdef _wifi_completion wifi
