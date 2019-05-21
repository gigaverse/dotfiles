#!/bin/bash

. $(dirname $0)/i3_lemonbar_config

if [ $(pgrep -cx $(basename $0)) -gt 1 ] ; then
    printf "%s\n" "The status bar is already running." >&2
    exit 1
fi

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

# make the fifo for each output monitor
for i in `seq ${#panel_fifo[@]}`
do
    [ -e "${panel_fifo[$i]}" ] && rm "${panel_fifo[$i]}"
    mkfifo "${panel_fifo[$i]}"
done

### EVENTS METERS

## Window title, "WIN"
xprop -spy -root _NET_ACTIVE_WINDOW | sed -un 's/.*\(0x.*\)/WIN\1/p' | tee ${panel_fifo[@]} > /dev/null &

## i3 Workspaces, "WSP"
## TODO : Restarting I3 breaks the IPC socket con. :(
for i in `seq ${#monitor_name[@]}`
do
    $(dirname $0)/i3_workspaces.pl "${monitor_name[$i]}" | tee "${panel_fifo[$i]}" > /dev/null &
done

# IRC, "IRC"
# only for init
#~/bin/irc_warn &

## Conky, "SYS"
conky -c $(dirname $0)/i3_lemonbar_conky | tee "${panel_fifo[@]}" > /dev/null &

### UPDATE INTERVAL METERS
cnt_vol=${upd_vol}
cnt_bri=${upd_bri}
cnt_mail=${upd_mail}
cnt_mmpd=${upd_mmpd}
cnt_ext_ip=${upd_ext_ip}
cnt_gpg=${upd_gpg}
cnt_tmb=${upd_tmb}
cnt_temp=${upd_temp}
cnt_net=${upd_net}
cnt_mem=${upd_mem}
cnt_time=${upd_time}
cnt_disk=${upd_disk}
cnt_rss=${upd_rss}

while :; do

    ### Volume Check, "VOL" ### {{{
    if [ $((cnt_vol++)) -ge ${upd_vol} ]; then
        ## Retired this line as amixer stopped showing >100% volume... around the same time amixer mute broke
        # amixer get Master | awk -F'[]%[]' '/%/ {STATE=$5; VOL=$2} END {if (STATE == "off") {print "VOL×\n"} else {printf "VOL%d%%\n", VOL}}' | tee "${panel_fifo[@]}" &
        pactl list sinks | awk 'BEGIN {MUTE="none";VOL="none"}/^\t*Volume|^\t*Mute/ {if($1=="Mute:"){MUTE=$2};if($1=="Volume:"){VOL=$5}} END {if(MUTE=="yes"){print "VOL×\n"} else {if(VOL!="none"){printf "VOL%d%%\n", VOL} else {print "VOLerror\n"};}}' | tee "${panel_fifo[@]}" > /dev/null &
        cnt_vol=0
    fi
    ### End Volume Check, "VOL" ### }}}

#    ### Brightness Check, "BRI" ### {{{
#   if [ $((cnt_bri++)) -ge ${upd_bri} ]; then
#       ## xbacklight doesn't work as this doesn't have xrandr access while running as the bar?
#       ## On failure, '$1/$2' becomes '0', and will result in 'none'
#       printf "%s%s\n" "BRI" "$(paste /sys/class/backlight/*/{actual_brightness,max_brightness} | awk '{BRIGHT=$1/$2*100} END {if(BRIGHT!=0){printf "%.f", BRIGHT} else {print "none"}}')" | tee "${panel_fifo[@]}"
#       cnt_bri=0
#   fi
#   ### End Brightness Check, "BRI" ### }}}

    ### Temperature Check, "TMP" ### {{{
    if [ $((cnt_temp++)) -ge ${upd_temp} ]; then
        ## Removes decimal from Celsius as it is always an integer
        printf "%s%s\n" "TMP" "$(acpi -t${temp_format} 2>/dev/null | awk 'BEGIN {} /Thermal 0/ {if($6=="C"){printf "%.0f %s",$4,$6} else {if($6=="F"){print $4,$6} else {print "none none"};}}')" | tee "${panel_fifo[@]}" > /dev/null
        cnt_temp=0
    fi
    ### End Temperature Check, "TMP" ### }}}

    ### Network Check, "NET" ### {{{
    if [ $((cnt_net++)) -ge ${upd_net} ]; then
        ## Get IP and wifi strength
        ## Now supports IPv6
        ## Now filters out virtual interfaces for docker/qemu/vpn
        printf "%s%s %s %s\n" "NET" "$(ip address show up scope global 2>/dev/null | awk 'BEGIN {Dv4=0;Dv6=0} /inet/&&!/(docker|virbr|tun|tap)[0-9]+$/ {if(Dv4==0 && $1=="inet"){sub(/\/.*/,NULL,$2); IPv4=$2; INT=$7; Dv4=1}; if(Dv6==0 && $1=="inet6" && $2!~/^fd/){sub(/\/.*/,NULL,$2); IPv6=$2; Dv6=1}} END {if(IPv4==""){IPv4="none"; INT="none"}; if(IPv6==""){IPv6="none"}; print IPv4,INT,IPv6}')" "$(iwconfig 2>/dev/null | awk '/Link/ {match($2, /\w+=([0-9]+)\/([0-9]+)/, m)} END {if(m[1]!=""&&m[2]!=""){print int((m[1] / m[2]) * 100)} else {print "none"}}')" "$(ip tuntap | awk 'BEGIN {TC=0} /tun/ {if($0!=""){TC++}} END {if(TC>=1){print "VPN"} else {print "none"}}')" | tee "${panel_fifo[@]}" > /dev/null
        cnt_net=0
    fi
    ### End Network Check, "NET" ### }}}

    ### Offlineimap, "EMA" ### {{{
    if [ $((cnt_mail++)) -ge ${upd_mail} ]; then
        printf "%s%s\n" "EMA" "$(find ${HOME}/.local/share/mail/*/INBOX/new -type f 2>/dev/null | wc -l)" | tee "${panel_fifo[@]}" > /dev/null
        cnt_mail=0
    fi
    ### End Offlineimap, "EMA" ### }}}

    ### Multi Music Player Display, "MMP" ### {{{
    if [ $((cnt_mmpd++)) -ge ${upd_mmpd} ]; then
        mmpd_check="$(grep -qxs 1 ${HOME}/.config/pianobar/isplaying && cat ${HOME}/.config/pianobar/nowplaying || echo 'none')"
        if [ "${mmpd_check}" != "none" ]; then
            printf "%s%s\n" "MMP" "${mmpd_check}" | tee "${panel_fifo[@]}" > /dev/null
          else
            ## cmus
            mmpd_check="$(cmus-remote -Q 2>/dev/null | awk 'BEGIN {STATUS=0;STREAM=0;TITLE=0;ARTIST=0} {match($0, /^(status|stream|tag title|tag artist)\s(.*)/, m); if(m[1]=="status"){STATUS=m[2]};if(m[1]=="stream"){STREAM=m[2]}; if(m[1]=="tag title"){TITLE=m[2]}; if(m[1]=="tag artist"){ARTIST=m[2]}} END {if(STATUS!=0){if(STATUS=="playing"){if(STREAM!=0){print STREAM} else if(ARTIST!=0&&TITLE!=0){print ARTIST " - " TITLE} else if(TITLE!=0){print TITLE}else {print "cmus: no meta data"}} else if(STATUS=="paused"){print "cmus: paused"} else {print "none"}} else {print "none"}}')"
            if [ "${mmpd_check}" != "none" ]; then
                printf "%s%s\n" "MMP" "${mmpd_check}" | tee "${panel_fifo[@]}" > /dev/null
              else
                ## mpd
                ## Note this is my own mpd check (not elctro7's)
                ## It will report if mpd is paused.
                mmpd_check="$(mpc status 2>/dev/null | awk 'BEGIN {STATUS=0;INFO=0} !/^volume/ {match($0, /^(\w+.*)/, p); match($0, /(\[playing\]|\[paused\])/, m); if(m[0]!=""){STATUS=m[1]}; if(p[0]!=""){INFO=p[0]}} END {if(STATUS!=0){if(STATUS=="[paused]"){print "mpd: paused"} else {print INFO}} else {print "none"}}')"
                if [ "${mmpd_check}" != "none" ]; then
                    printf "%s%s\n" "MMP" "${mmpd_check}" | tee "${panel_fifo[@]}" > /dev/null
                  else
                    ## mocp
                    mmpd_check="$(mocp --info 2>/dev/null | awk 'BEGIN {STATE=0; TITLE=0; ARTIST=0} {match($0, /^(State|Title|Artist):\s(.*)/, m); if(m[1]=="State"){STATE=m[2]}; if(m[1]=="Artist"&&m[2]!=""){ARTIST=m[2]}; if(m[1]=="Title"&&m[2]!=""){TITLE=m[2]}} END {if(STATE!=0){if(STATE=="PLAY"){if(TITLE!=0){print TITLE} else {print "mocp: no meta data"}} else if(STATE=="PAUSE"){print "mocp: paused"} else {print "none"}} else {print "none"}}')"
                    if [ "${mmpd_check}" != "none" ]; then
                        printf "%s%s\n" "MMP" "${mmpd_check}" | tee "${panel_fifo[@]}" > /dev/null
                      else
                        ## audacios
                        mmpd_check="$(audtool --playback-status --current-song 2>/dev/null | awk 'BEGIN {STATUS=0; INFO=0} {if($0=="playing"||$0=="paused"){STATUS=$0}; if(STATUS=="playing"){INFO=$0}} END {if(INFO!=0){print INFO} else if(STATUS=="paused"){print "audacios: paused"} else {print "none"}}')"
                        if [ "${mmpd_check}" != "none" ]; then
                            printf "%s%s\n" "MMP" "${mmpd_check}" | tee "${panel_fifo[@]}" > /dev/null
                          else
                            ## This makes scaling easier
                            printf "%s%s\n" "MMP" "none" | tee "${panel_fifo[@]}" > /dev/null
                        fi
                    fi
                fi
            fi
        fi
    cnt_mmpd=0
    fi
    ### End Multi Music Player Display ### }}}

    ### Thinkpad Milti Battery, "TMB" ### {{{
    ## Works for normal batteries now too.
    if [ $((cnt_tmb++)) -ge ${upd_tmb} ]; then
        ## Check for BAT0
        if [ -e /sys/class/power_supply/BAT0/uevent ]; then
            BAT0="/sys/class/power_supply/BAT0/uevent"
          else
            BAT0=""
        fi

        ## Check for BAT1
        if [ -e /sys/class/power_supply/BAT1/uevent ]; then
            BAT1="/sys/class/power_supply/BAT1/uevent"
          else
            BAT1=""
        fi

        if [ "${BAT0}" != "" ] || [ "${BAT1}" != "" ]; then
            ## Originally "/sys/class/power_supply/BAT{0..1}/uevent" but changed into variables make work for non thinkpad cases. paste fails if it can't find a passed file.
            ## "U" for unknown
            printf "%s%s %s\n" "TMB" "$(paste -d = ${BAT0} ${BAT1} 2>/dev/null | awk 'BEGIN {CHARGE="U"} /ENERGY_FULL=/||/ENERGY_NOW=/||/STATUS=/||/CHARGE_NOW=/||/CHARGE_FULL=/ {split($0,a,"="); if(a[2]~/Discharging/||a[4]~/Discharging/){CHARGE="D"} else if(a[2]~/Charging/||a[4]~/Charging/){CHARGE="C"} else if (a[2]~/Full/||a[4]~/Full/){CHARGE="F"}; if(a[1]~/FULL/){FULL=a[2]+a[4]}; if(a[1]~/NOW/){NOW=a[2]+a[4]};} END {if(NOW!=""){PERC=int((NOW/FULL)*100)} else {PERC="none"}; printf("%s %s\n", PERC, CHARGE)}')" "$(acpi -b | awk '/[0-9]+:[0-9]+:[0-9]+ (until|remaining)/ {if($5!=""){split($5,s,":");if(s[1]!="00"){HOUR=s[1]"h"};if(s[2]!="00"){MIN=s[2]"m"};TIME=HOUR MIN}} END {if(TIME!=""){print TIME} else {print "none"}}')" | tee "${panel_fifo[@]}" > /dev/null
            else
            printf "%s%s\n" "TMB" "none" | tee "${panel_fifo[@]}" > /dev/null
        fi
        cnt_tmb=0
    fi
    ### End Thinkpad Milti Battery, "TMB" ### }}}

    ### GPG Cache Check, "GPG" ### {{{
    if [ $((cnt_gpg++)) -ge ${upd_gpg} ]; then
        export DISPLAY=''
        ## Now will check if a local gpg key, or a smartcard, is cached.
        printf "%s%s\n" "GPG" "$({ gpg-connect-agent 'keyinfo --list' /bye 2>/dev/null; gpg-connect-agent 'scd getinfo card_list' /bye 2>/dev/null; } | awk 'BEGIN{CH=0} /^S/ {if($7==1){CH=1}; if($2=="SERIALNO"){CH=1}} END{if($0!=""){print CH} else {print "none"}}')" | tee "${panel_fifo[@]}" > /dev/null

        cnt_gpg=0
    fi
    ### End GPG Cache Check, "GPG" ### }}}

    ### External IP Check, "EXT" ### {{{
    if [ $((cnt_ext_ip++)) -ge ${upd_ext_ip} ]; then
        printf "%s%s\n" "EXT" "$(wget --no-proxy http://checkip.dyndns.org/ -q -O - | grep -Eo '\<[[:digit:]]{1,3}(\.[[:digit:]]{1,3}){3}\>' || echo 'err')" | tee "${panel_fifo[@]}" > /dev/null
        cnt_ext_ip=0
    fi
    ### End External IP Check, "EXT" ### }}}

    ### System Memory Usage, "MEM" ### {{{
    if [ $((cnt_mem++)) -ge ${upd_mem} ]; then
        ## Using MemAvailable and flipping the percentage with a "1-__" as MemFree gives bad results.
        printf "%s%s\n" "MEM" "$(free -m | awk '/Mem/ {USED=$3} END {printf "%.0f MB\n", USED}')" | tee "${panel_fifo[@]}" > /dev/null
        cnt_mem=0
    fi
    ### End System Memory Usage, "MEM" ### }}}

    ### Time Check, "TIM" ### {{{
    if [ $((cnt_time++)) -ge ${upd_time} ]; then
        printf "%s%s\n" "TIM" "$(date '+%a %d %b %H:%M')" | tee "${panel_fifo[@]}" > /dev/null
        printf "%s%s\n" "UTC" "$(date -u '+%F %H:%M UTC')" | tee "${panel_fifo[@]}" > /dev/null
        cnt_time=0
    fi
    ### End Time Check, "TIM" ### }}}

    ### Disk Usage Check, "DIC" ### {{{
    if [ $((cnt_disk++)) -ge ${upd_disk} ]; then
        ## Limits to root filesystem. awk cuts header line and shucks leading space
        printf "%s%s\n" "DIC" "SSD $(df --output=pcent / | awk 'END {print $1}') MEDIA $(df --output=pcent /thighland | awk 'END {print $1}') HDD $(df --output=pcent /king | awk 'END {print $1}')" | tee "${panel_fifo[@]}" > /dev/null
        cnt_disk=0
    fi
    ### End Disk Usage Check, "DIC" ### }}}

    ### RSS Unread Check, "RSS" ### {{{
    if [ $((cnt_rss++)) -ge ${upd_rss} ]; then

        ## Checks that $rss_path is set or skips commands
        if [ -n "${rss_path}" ]; then
            ## Verifies that sqlite3 is installed
            if [ -n "$(command -v sqlite3)" ]; then
                ## Polls newsboat db for unread count.
                printf "%s%s\n" "RSS" "$(sqlite3 ${rss_path} 'select sum(unread) from rss_item')" | tee "${panel_fifo[@]}" > /dev/null
            fi
        fi

        cnt_rss=0
    fi
    ### End RSS Unread Check, "RSS" ### }}}

    ## Finally, wait 1 second
    sleep 1s;

done &

# List of all the monitors/screens you have in your setup
resolutions=$(xrandr | grep -w connected | sed 's/ primary//'  | awk -F'[ ]+' '{print $3}' \
    | awk -F'[\+x]' '{height = $2/60 ; print $1"x"height"+"$3"+"$4}')
count=1
for res in $resolutions; do
    cat "${panel_fifo[$count]}" | $(dirname $0)/i3_lemonbar_parser.sh \
         | lemonbar -p  -f "${font}" -f "${iconfont}" -g "${res}" -B "${color_back}" -F "${color_fore}" &
    ((count++))
done

#### LOOP FIFO
#cat "${panel_fifo}" | $(dirname $0)/i3_lemonbar_parser.sh \
#     | lemonbar -p -f "${font}" -f "${iconfont}" -g "${geometry}" -B "${color_back}" -F "${color_fore}" &


wait

