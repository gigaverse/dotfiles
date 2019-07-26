## Gigaverse's i3 lemonbar ##

![my bar][pic]

### Base ###
This is a modified version of Demure's lemonbar, designed for Desktop usage with multiple monitors.

* Works with multiple music players, and has room to add more support.
* Shows if a GPG key is cached, and hides of no GPG installed.
* Shows volume.
* Shows either wired or wireless Up/Down speed in the same spot.
* VPN indicator.


### Requirements ###
* [i3wm]
* `lemonbar` (which used to be know as `bar`)
  * I use [lemonbar krypt-n] instead of [lemonbar].
   * I do *not* recommend the vanila lemonbar, as it's xft font support is... crap?
   * On debian depends on `libxcb1-dev`, `libxcb-xinerama0-dev`, `xcb-randr0-dev`, `libxft-dev`, `libx11-xcb-dev` and a few other things (I listed the less common ones).
* `gawk`, as I wrote my fancy awk using it.
* You need [conky]
  * on debian sid, I use the `conky-all` package
  * on arch, make sure the wireless support compiled in. The AUR `conky-git` might be what you want.
* A nice symbol font
  * I use font awesome, which is the best symbol font I have seen to date.


### Installation ###
* Install font awesome
  * or you can change the icon font, and set all the icons.
* Add i3 lemonbar to your `~/.i3/config`

```
bar {
    i3_bar_command ~/.i3/lemonbar/i3_lemonbar.sh
    }
```


### **Notes** ###
* Multi monitor support is a bit shaky when monitors are placed above eachother

### **Modifications** ###


### **Things I want** ###
* I am not sure if I can make this set up show i3 keybinding modes in the bar... would like this.
* Fix the network usage module

[i3 lemonbar]: https://github.com/electro7/dotfiles/tree/master/.i3/lemonbar
[lemonbar krypt-n]: https://github.com/krypt-n/bar
[lemonbar]: https://github.com/LemonBoy/bar
[i3wm]: https://i3wm.org
[conky]: https://github.com/brndnmtthws/conky
[pic]: https://i.imgur.com/iWtCvbA.png
[control-pianobar]: https://malabarba.github.io/control-pianobar/
[cmus]: https://cmus.github.io/
[mpd]: https://www.musicpd.org/
[mocp]: https://moc.daper.net/
[audacious]: http://audacious-media-player.org/
