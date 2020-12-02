# vim: ft=sh
export _JAVA_AWT_WM_NONREPARENTING=1
hsetroot -solid "#2E3440"

if [ "$HOSTNAME" == "flaptop" ]; then
    `while true; do
        MHZ="$(
            grep MHz /proc/cpuinfo |
            awk '{print $4}' |
            sort -n |
            tail -n 1 |
            cut -d'.' -f1
        )MHz"

        TEMP="$(
            sensors -u 2> /dev/null |
            grep -o 'temp[0-9]_input: [0-9.]*' |
            cut -d' ' -f2 |
            grep -v 0.000 |
            sort -n |
            tail -n 1 |
            cut -d'.' -f1
        )c"

        BATT="$(acpi | grep -o '[0-9]*%' | head -n 1)"
        DATE="$(date '+%d/%m %H:%M')"

        xsetroot -name " $MHZ $TEMP | $BATT | $DATE "
        sleep 5
    done` &
fi

while true; do
    dwm
done
