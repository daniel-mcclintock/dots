export _JAVA_AWT_WM_NONREPARENTING=1
hsetroot -solid "#2E3440"

`while true; do xsetroot -name "$(date '+%d/%m %H:%M')"; sleep 15; done`

while true; do
    pgrep picom || picom -b
    dwm

done
