-- http://projects.haskell.org/xmobar/
-- you can find weather location codes here: http://weather.noaa.gov/index.html

Config { font    = "xft:mononoki:bold:pixelsize=11:antialias=true:hinting=true"
       , additionalFonts = [ "xft:JoyPixels:pixelsize=11" ]
       , bgColor = "#eee8d5"
       , fgColor = "#657b83"
       , position = Bottom
       , lowerOnStart = True
       , hideOnStart = False
       , allDesktops = True
       , persistent = True
       , wmClass = "xmobar-b"
       , wmName = "xmobar-b"
       , commands = [
          -- Network up and down
        Run Network "enp27s0" ["-t", "up: <rx>kb  down: <tx>kb"] 20
          -- Cpu usage in percent
        , Run Cpu ["-t", "cpu: (<total>%)","-H","50","--high","red"] 20
          -- Ram used number and percent
        , Run Memory ["-t", "mem: <used>M (<usedratio>%)"] 20
          -- Disk space free
        , Run DiskU [("/", "hdd: <free> free")] [] 60
        , Run CoreTemp ["-t", "Temp:<core0>|<core1>C",
                 "-L", "40", "-H", "60",
                 "-l", "lightblue", "-n", "gray90", "-h", "red"] 50          -- Runs custom script to check for pacman updates.
          -- This script is in my dotfiles repo in .local/bin.
          -- Runs a standard shell command 'uname -r' to get kernel version
                    , Run Com "uname" ["-r"] "" 36000
		    , Run MPD ["-t", "<statei> <lapsed>/<length> | <title> - <artist> (<album>) <track>/<plength>", "--", "-h", "0.0.0.0"] 10
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "}{ <fc=#dc322f> %coretemp% </fc><fc=#666666>|</fc>\
       									\<fc=#d33682> %enp27s0% </fc><fc=#666666>|</fc>\
       									\<fc=#6c71c4> %memory% </fc><fc=#666666>|</fc>\
       									\<fc=#859900>\
       										\<action=`mpc toggle` button=1> %mpd% </action>\
       									\</fc>"
       }
