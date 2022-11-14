setterm -term linux -back black -fore white -clear
gsettings set org.gnome.desktop.interface cursor-blink false

https://wiki.gnome.org/Apps/Terminal/FAQ
https://github.com/srbcheema1/CheemaFy/blob/master/CheemaFy#L74-L86

RGB(0,0,0) #000000
CMYK(74,71,64,87)
HSB(263 deg,2%,0%)
Brightness - 5%
Opacity - 85%

# Preserve history across tabs
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
