-- http://projects.haskell.org/xmobar/
-- you can find weather location codes here: http://weather.noaa.gov/index.html

Config { font    = "xft:mononoki:pixelsize=12:bold:antialias=true:hinting=true"
       , additionalFonts = [ "xft:OpenMoji:size=16" ]
       , bgColor = "#eee8d5"
       , fgColor = "#657b83"
       , position = Top
       , lowerOnStart = False
       , hideOnStart = False
       , allDesktops = True
       , persistent = False
       , iconRoot = "/home/gigaverse/.xmonad/xpm/"  -- default: "."
       , commands = [
	      -- battery monitor
        -- Time and date
		      Run Date "%b %d %Y (%H:%M)" "date" 30
		    , Run WeatherX "KADS"
		       [ ("clear", "🌞")
		       , ("sunny", "🌞")
		       , ("mostly clear", "🌟")
		       , ("mostly sunny", "🌞")
		       , ("partly sunny", "⛅")
		       , ("fair", "🌑")
		       , ("cloudy","☁")
		       , ("overcast","☁")
		       , ("partly cloudy", "⛅")
		       , ("mostly cloudy", "☁")
		       , ("considerable cloudiness", "⛈")]
           ["-t", "<fn=2><skyConditionS></fn> <tempC>° <rh>%  <windKmh> (<hour>)"
           , "-L","10", "-H", "25", "--normal", "black"
           , "--high", "lightgoldenrod4", "--low", "darkseagreen4"]		    	
					18000
		        -- Prints out the left side items such as workspaces, layout, etc.
		        -- The workspaces are 'clickable' in my configs.
		    , Run UnsafeStdinReader
       ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "<icon=ndwh.xpm/> %UnsafeStdinReader% }{ \
										\<fc=#6c71c4>%KTXDALLA743%</fc><fc=#666666>|</fc> \
										\<fc=#b58900>\
											\<action=`calendar` button=1>%date%</action>\
										\</fc>"
       }
-- $base03:    #002b36;
-- $base02:    #073642;
-- $base01:    #586e75;
-- $base00:    #657b83;
-- $base0:     #839496;
-- $base1:     #93a1a1;
-- $base2:     #eee8d5;
-- $base3:     #fdf6e3;
-- $yellow:    #b58900;
-- $orange:    #cb4b16;
-- $red:       #dc322f;
-- $magenta:   #d33682;
-- $violet:    #6c71c4;
-- $blue:      #268bd2;
-- $cyan:      #2aa198;
-- $green:     #859900;
