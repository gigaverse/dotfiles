# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html
import dracula.draw

dracula.draw.blood(c, {
    'spacing': {
        'vertical': 6,
        'horizontal': 8
    },
    'font': {
        'family': 'Menlo, Terminus, Monaco, Monospace',
        'size': 10
    }
})

# Uncomment this to still load settings configured via autoconfig.yml
#config.load_autoconfig()

c.url.start_pages = ["file:///home/youssef/Projects/StartPage/homepage.html"]
config.set('tabs.padding', { 'top': 5, 'bottom': 5, 'left': 5, 'right': 5 })

# Default monospace fonts. Whenever "monospace" is used in a font
# setting, it's replaced with the fonts listed here.
# Type: Font
c.fonts.monospace = '"IBM Plex Mono", Terminus, Monospace, "DejaVu Sans Mono", Monaco, "Bitstream Vera Sans Mono", "Andale Mono", "Courier New", Courier, "Liberation Mono", monospace, Fixed, Consolas, Terminal'

# Font family for standard fonts.
# Type: FontFamily
c.fonts.web.family.standard =  '"Source Code Pro", "Roboto Condensed", sans-serif'
c.fonts.web.family.sans_serif =  '"Source Code Pro", "Roboto Condensed", sans-serif'
c.fonts.web.family.serif =  '"Tinos For Powerline", "Roboto Condensed", serif'

# Font used in the completion widget.
# Type: Font
c.fonts.completion.entry = '9pt xos4 Terminess Powerline'

# Font used in the completion categories.
# Type: Font
c.fonts.completion.category = 'bold 9pt xos4 Terminess Powerline'

# Font used for the debugging console.
# Type: QtFont
c.fonts.debug_console = '9pt xos4 Terminess Powerline'

# Font used for the downloadbar.
# Type: Font
c.fonts.downloads = '9pt xos4 Terminess Powerline'

# Font used for the hints.
# Type: Font
c.fonts.hints = 'bold 9pt xos4 Terminess Powerline'

# Font used in the keyhint widget.
# Type: Font
c.fonts.keyhint = '9pt xos4 Terminess Powerline'

# Font used for error messages.
# Type: Font
c.fonts.messages.error = '9pt xos4 Terminess Powerline'

# Font used for info messages.
# Type: Font
c.fonts.messages.info = '9pt xos4 Terminess Powerline'

# Font used for warning messages.
# Type: Font
c.fonts.messages.warning = '9pt xos4 Terminess Powerline'

# Font used for prompts.
# Type: Font
c.fonts.prompts = '12pt Source Code Pro'

# Font used in the statusbar.
# Type: Font
c.fonts.statusbar = '9pt Source Code Pro'

# Font used in the tab bar.
# Type: QtFont
c.fonts.tabs = '10pt "Source Code Pro"'

#SEARCH ENGINES
c.url.searchengines = {"DEFAULT": "https://duckduckgo.com/?q={}",
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
