call plug#begin('~/.config/nvim/plugged')
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
Plug 'tpope/vim-surround'
Plug 'jreybert/vimagit'
Plug 'LukeSmithxyz/vimling'
Plug 'bling/vim-airline'
Plug 'mmai/vim-markdown-wiki'
Plug 'tpope/vim-commentary'
Plug 'vifm/vifm.vim'
Plug 'honza/vim-snippets'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'urbit/hoon.vim'
Plug 'rust-lang/rust.vim'
Plug 'vim-syntastic/syntastic'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
" A Git wrapper so awesome, it should be illegal
" https://github.com/tpope/vim-fugitive/blob/master/README.markdown
Plug 'tpope/vim-fugitive'

" Distraction Free Writing in vim
Plug 'junegunn/goyo.vim'

" A tree explorer plugin for vim
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'

" An alternative indentation script for python
Plug 'vim-scripts/indentpython.vim'
" provides insert mode auto-completion for quotes, parens, brackets, etc.
" :help delimitMate
Plug 'raimondi/delimitmate'

" Asynchronous Lint Engine
" https://github.com/w0rp/ale/blob/master/README.md
Plug 'w0rp/ale'

" Vim plugin that displays tags in a window
Plug 'majutsushi/tagbar'

" Fuzzy file, buffer, mru, tag, etc finder.
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ivalkeen/vim-ctrlp-tjump'

"A Vim plugin which shows a git diff in the gutter
Plug 'airblade/vim-gitgutter'

" Icons and Glyphs for plugins
Plug 'ryanoasis/vim-devicons'

" https://github.com/junegunn/fzf.vim/blob/master/README.md
Plug 'junegunn/fzf.vim'

"Perform all your vim insert mode completions with Tab
Plug 'ervandew/supertab'

" https://github.com/xolox/vim-misc
Plug 'xolox/vim-misc'

" Extended session management for Vim
Plug 'xolox/vim-session'

"Prolog integration for Vim
Plug 'adimit/prolog.vim'

" Colemak binds for vim
Plug 'jooize/vim-colemak'
call plug#end()
set bg=light
set go=a
set mouse=a
set nohlsearch
set clipboard=unnamedplus

" Some basics:
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number
" Enable autocompletion:
	set wildmode=longest,list,full
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Goyo plugin makes text more readable when writing prose:
	map <leader>f :Goyo \| set bg=light \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

" Nerd tree
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vimling:
	nm <leader>d :call ToggleDeadKeys()<CR>
	imap <leader>d <esc>:call ToggleDeadKeys()<CR>a
	nm <leader>i :call ToggleIPA()<CR>
	imap <leader>i <esc>:call ToggleIPA()<CR>a
	nm <leader>q :call ToggleProse()<CR>

" Check file in shellcheck:
	map <leader>s :!clear && shellcheck %<CR>

" Open my bibliography file in split
	map <leader>b :vsp<space>$BIB<CR>
	map <leader>r :vsp<space>$REFER<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Rust configuration
	let g:rustfmt_autosave = 1

" Flutter Binds
nnoremap <leader>fa :FlutterRun<cr>
nnoremap <leader>fq :FlutterQuit<cr>
nnoremap <leader>fr :FlutterHotReload<cr>
nnoremap <leader>fR :FlutterHotRestart<cr>
nnoremap <leader>fD :FlutterVisualDebug<cr>

" Ensure files are read as what I want:
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
	vnoremap <C-c> "+y
	map <C-p> "+P

" Enable Goyo by default for mutt writting
	" Goyo's width will be the line limit in mutt.
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo \| set bg=light

" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and vifm configs with new material:
	autocmd BufWritePost ~/.config/bmdirs,~/.config/bmfiles !shortcuts

" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" Navigating with guides
	vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
	map <leader><leader> <Esc>/<++><Enter>"_c4l


"MARKDOWN
	autocmd Filetype markdown,rmd map <leader>w yiWi[<esc>Ea](<esc>pa)
	autocmd Filetype markdown,rmd inoremap ,n ---<Enter><Enter>
	autocmd Filetype markdown,rmd inoremap ,b ****<++><Esc>F*hi
	autocmd Filetype markdown,rmd inoremap ,s ~~~~<++><Esc>F~hi
	autocmd Filetype markdown,rmd inoremap ,e **<++><Esc>F*i
	autocmd Filetype markdown,rmd inoremap ,h ====<Space><++><Esc>F=hi
	autocmd Filetype markdown,rmd inoremap ,i ![](<++>)<++><Esc>F[a
	autocmd Filetype markdown,rmd inoremap ,a [](<++>)<++><Esc>F[a
	autocmd Filetype markdown,rmd inoremap ,1 #<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ,2 ##<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ,3 ###<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ,l --------<Enter>
	autocmd Filetype rmd inoremap ,r ```{r}<CR>```<CR><CR><esc>2kO
	autocmd Filetype rmd inoremap ,p ```{python}<CR>```<CR><CR><esc>2kO
	autocmd Filetype rmd inoremap ,c ```<cr>```<cr><cr><esc>2kO

""".xml
	autocmd FileType xml inoremap ,e <item><Enter><title><++></title><Enter><guid<space>isPermaLink="false"><++></guid><Enter><pubDate><Esc>:put<Space>=strftime('%a, %d %b %Y %H:%M:%S %z')<Enter>kJA</pubDate><Enter><link><++></link><Enter><description><![CDATA[<++>]]></description><Enter></item><Esc>?<title><enter>cit
	autocmd FileType xml inoremap ,a <a href="<++>"><++></a><++><Esc>F"ci"



" pretty code
let python_highlight_all=1
syntax on

" NerdTREE
map <C-n> :NERDTreeToggle<CR>
autocmd vimenter * NERDTree | wincmd l " open NerdTree when entering vim, then focus right window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:nerdtree_tabs_open_on_console_startup=0
let g:nerdtree_tabs_open_on_new_tab=0

let NERDTreeMinimalUI=1
let NERDTreeDirArrows=0
let NERDTreeIgnore=['\.pyc$', '\~$', '^__pycache__$'] "ignore files in NERDTree
let g:NERDTreeWinSize = 25
" find current file in NERDTree by pressing ALT+V (√ in osx)
nnoremap <A-v> :NERDTreeFind<CR>
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 0
let g:WebDevIconsUnicodeGlyphDoubleWidth = 0

" NERDTree highlight
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
" uncommon file extensions highlightling:
let g:NERDTreeLimitedSyntax = 1
" uncomment these 3 lines to disable completely:
" let g:NERDTreeDisableFileExtensionHighlight = 1
" let g:NERDTreeDisableExactMatchHighlight = 1
" let g:NERDTreeDisablePatternMatchHighlight = 1
"

nmap <C-m> :TagbarToggle<CR>

" Filetype autocmd
au FileType *.py
    \ setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=119 expandtab autoindent fileformat=unix
au FileType *.js, *.html, *.css
    \ setlocal tabstop=2
    \| setlocal softtabstop=2
    \| setlocal shiftwidth=2
au FileType *.hbs
    \ setlocal tabstop=2
    \| setlocal softtabstop=2
    \| setlocal shiftwidth=2
    \| setlocal ft=smarty


" CtrlP Search
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc
" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|public$|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }
" Use ag for ctrlp searching
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'

" python venv
let pipenv_venv_path = system('pipenv --venv')
if $PIPENV_ACTIVE == 1
  let venv_path = substitute(pipenv_venv_path, '\n', '', '')
  let g:ycm_python_binary_path = venv_path . '/bin/python'
else
  let g:ycm_python_binary_path = 'python'
endif

" CtrlP Tag Jump
" (π is ALT+P in osx)
nnoremap <M-p> :CtrlPtjump<CR>
vnoremap <M-p> :CtrlPtjumpVisual<CR>
let g:ctrlp_tjump_only_silent = 0

" Go to last active tab
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <c-t> :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <c-t> :exe "tabn ".g:lasttab<cr>
" Move between tabs with ALT-J (¶) and ALT-K (§)
nnoremap <A-n> :tabprevious<CR>
nnoremap <A-e> :tabnext<CR>
" ALT-T creates a new empty tab
nnoremap <A-t> :tabnew<CR>

" FZF fuzzy search for vim
set rtp+=~/.fzf
let g:fzf_layout = { 'down': '~50%' }
" Ctrl-K brings up file search (fzf)
nnoremap <C-K> :Files<CR>
" Ctrl-F brings up text search (uses ag)
nnoremap <C-F> :Ag<CR>
" preview window (press <?> to toggle)
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Ale
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
highlight ALEErrorSign guifg=#CC3333 ctermbg=160
highlight ALEWarningSign guifg=#FF9900 ctermbg=136
let g:ale_echo_msg_error_str = ''
let g:ale_echo_msg_warning_str = ''
let g:ale_echo_msg_format = '%severity% [%linter%] %s'
"highlight AleWarning guifg=#FF9900 gui=bold,underline
"highlight AleWarningLine guibg=NONE gui=italic
"highlight AleError guifg=#FF3333 gui=bold,underline
"highlight AleErrorLine guibg=NONE gui=italic
let g:ale_lint_delay = 1000 " 1 sec delay to run linter after text is changed
let g:ale_completion_enabled = 1

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pylint', 'flake8']
let g:syntastic_rust_checkers = ['cargo']
let g:syntastic_python_pylint_post_args="--max-line-length=120 --disable=C0111"

" SuperTab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"


" Fugitive
set diffopt+=vertical

" Do not Load rope plugin (should make jedi-vim faster)
let g:pymode_rope = 0

" use xmllint on Visual Selection by calling :XmlLint (remove '<,'> from command line first)
command XmlLint '<,'>!xmllint --format -

" remove character from VertSplit column
:set fillchars+=vert:\

" GitGutter
let g:gitgutter_sign_added = '' "    
let g:gitgutter_sign_modified = '' "      
let g:gitgutter_sign_removed = '' "    
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = ''

" Highlight all occurrences of word under cursor
autocmd CursorMoved * exe exists("HlUnderCursor")?HlUnderCursor?printf('match Pmenu /\V\<%s\>/', escape(expand('<cword>'), '/\')):'match none':""
let HlUnderCursor=1 " toggle this to 0 to disable

"autocompile for suckless:
    autocmd BufWritePost config.h,config.def.h !sudo make install

"Session
let g:session_autoload = 'no'
let g:session_autosave = 'no'

" Fix for colemak.vim keymap collision. tpope/vim-fugitive's maps y<C-G>
" and colemak.vim maps 'y' to 'w' (word). In combination this stalls 'y'
" because Vim must wait to see if the user wants to press <C-G> as well.
augroup RemoveFugitiveMappingForColemak
    autocmd!
    autocmd BufEnter * silent! execute "nunmap <buffer> <silent> y<C-G>"
augroup END

" Omnisharp
"let g:OmniSharp_server_stdio = 0
"set completeopt=longest,menuone,preview
