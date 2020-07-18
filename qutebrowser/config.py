# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html
import dracula.draw

dracula.draw.blood(c, {
    'spacing': {
        'vertical': 6,
        'horizontal': 8
    }
})

# Uncomment this to still load settings configured via autoconfig.yml
#config.load_autoconfig()

c.url.start_pages = ["file:///home/gigaverse/proj/StartPage/homepage.html"]
config.set('tabs.padding', { 'top': 5, 'bottom': 5, 'left': 5, 'right': 5 })

c.colors.webpage.prefers_color_scheme_dark = True

# setting, it's replaced with the fonts listed here.
# Type: Font
c.fonts.default_family = ["mononoki", "IBM Plex Mono", "DejaVu Sans Mono", "Bitstream Vera Sans Mono", "Andale Mono", "Courier New", "Liberation Mono"]
# Font family for standard fonts.
# Type: FontFamily
c.fonts.web.family.standard =  '"TeX Gyre Adventor", serif'
c.fonts.web.family.sans_serif =  '"TeX Gyre Heros", "Roboto Condensed", sans-serif'
c.fonts.web.family.serif =  '"Tex Gyre Bonum", "Roboto Condensed", serif'

# Font used in the completion widget.
# Type: Font
c.fonts.completion.entry = '9pt mononoki'

# Font used in the completion categories.
# Type: Font
c.fonts.completion.category = 'bold 9pt mononoki'

# Font used for the debugging console.
# Type: QtFont
c.fonts.debug_console = '9pt mononoki'

# Font used for the downloadbar.
# Type: Font
c.fonts.downloads = '9pt mononoki'

# Font used for the hints.
# Type: Font
c.fonts.hints = 'bold 9pt mononoki'

# Font used in the keyhint widget.
# Type: Font
c.fonts.keyhint = '9pt mononoki'

# Font used for error messages.
# Type: Font
c.fonts.messages.error = '9pt mononoki'

# Font used for info messages.
# Type: Font
c.fonts.messages.info = '9pt mononoki'

# Font used for warning messages.
# Type: Font
c.fonts.messages.warning = '9pt mononoki'

# Font used for prompts.
# Type: Font
c.fonts.prompts = '12pt mononoki'

# Font used in the statusbar.
# Type: Font
c.fonts.statusbar = '9pt mononoki'

# Font used in the tab bar.
# Type: QtFont
c.fonts.tabs = '10pt "mononoki"'

#SEARCH ENGINES
c.url.searchengines = {"DEFAULT": "http://jmeserver:8888/?preferences=eJx1VFGP0zAM_jX0pRriuAee-oBAiJOQ7sTueI28xOtMk7g46Xbl1-Nu7ZaCeFg1O_YX-_MXW8jYshCmpsWIAr7yENsBWmwwbl62lWcLfjIqGDJbDr3HjE3L3HqsKGik6YVfx-YL-IRVwHxg1zw9bp-rBHtMCGIPzbsqHzBgw8mCVIJp8DkZjibiyWTYzdmOyegh-yNKw6DmW5a2OmdtUh61Es8tWXZ43DiQrnKUYOfRGYwtRe0j8E_Ezpi5nzfvP4FtEw_GHMkhJ3W0lD3sjKGsRke2g5SKY-4xCvasvj15nFy_ThBziXlkUDuxJfB1QEegTjuIYLRjGUgRCug4gppn1iZzR3k32A7zXIu1dpOPRfxeIICnneAckbkbOXM6cAfRmDAksuoeYuo9pEOBHcaAgWWss0BMXgftyrqubS8t7kGYV7T1XR1IhGW-O_Zh_rcwuuQeYCcwfebzEaLD1xIsZZDcT2IpnG5wGNcO202_dlVIS62OGNJqAILO0b8juBB85W-JurLyF3_X5oViR2D_H3kTz1n5tdI91mf6b1O4lV9fYAq4u9fCcK6tHe4pUiaOqezr7v7-w2t5nYo5UzhjTdROYgCd6pSRaJV6eWrT26inz5ywF8Q68T6fQLB2JGizymI5dcLkbkQk_B0hlKiYx8DR69sqvbNa9PXeZL3QsJA-H05F0RHrdbFL0M0zwmEtwBXTfCQsH-kiwSunV0EvZSwRi13CQd8v0q8wrhcICp9o9VYu7V2ir_um94PGp-YHhY2nDs2Bc4fjVMqjLhBz2XFGieuui26n0AllWni3exeg7Xl8U6i9bOXRJPQ6LUX8-vz8tFXIk1BGtR_iWTxokhX2U41b9HujbpYAZ1Gp71lAl4uYl-_fNFcpRFmq-2gtKlmfHx8W1D_ZXEb9&q={}",
                       "wa": "https://wiki.archlinux.org/?search={}",
                       "rym":"https://rateyourmusic.com/search?bx=00a2c8ac73aa342923683822e7a86878&searchtype=a&searchterm={}",
                       "rymr": "https://rateyourmusic.com/search?bx=d0ac6eb2977e79320ac0caafc4e5dfbf&searchtype=l&searchterm={}"
                      }
# Bindings for normal mode

# Pipe a web video to mpv
config.bind('<Ctrl-Shift-y>', 'spawn --userscript view_in_mpv')

# Autofill for passwords
config.bind('<z><l>', 'spawn --userscript qute-pass')
config.bind('<z><u><l>', 'spawn --userscript qute-pass --username-only')
config.bind('<z><p><l>', 'spawn --userscript qute-pass --password-only')
config.bind('<z><o><l>', 'spawn --userscript qute-pass --otp-only')

config.bind('<Ctrl-o>', 'spawn --userscript dmenu_qutebrowser')

config.bind('<s><d>', 'spawn --userscript open_download')
