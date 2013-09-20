" if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
" 	set fileencodings=ucs-bom,utf-8,euc-jp,latin1
" endif

set nocompatible    " Use Vim defaults (much better!)
set bs=indent,eol,start     " allow backspacing over everything in insert mode
"set ai         " always set autoindenting on
"set backup     " keep a backup file
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
" than 50 lines of registers
set history=50      " keep 50 lines of command line history
set ruler       " show the cursor position all the time

filetype off                   " Required!

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
"NeoBundle 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
" NeoBundle 'Shougo/vimproc'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neocomplcache-clang'
NeoBundle 'pekepeke/titanium-vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'tomasr/molokai'
NeoBundle 'altercation/solarized'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'petdance/vim-perl'
NeoBundle 'hotchpotch/perldoc-vim'


" Only do this part when compiled with support for autocommands
if has("autocmd")
	augroup redhat
		autocmd!
		" In text files, always limit the width of text to 78 characters
		autocmd BufRead *.txt set tw=78
		" When editing a file, always jump to the last cursor position
		autocmd BufReadPost *
					\ if line("'\"") > 0 && line ("'\"") <= line("$") |
					\   exe "normal! g'\"" |
					\ endif
		" don't write swapfile on most commonly used directories for NFS mounts or USB sticks
		autocmd BufNewFile,BufReadPre /media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
		" start with spec file template
		autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
	augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
	set csprg=/usr/bin/cscope
	set csto=0
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
		" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	set csverb
endif

"set t_Co=256
set laststatus=2

" Highlight invisible characters
set list
set lcs=tab:>-,trail:_,extends:>,precedes:<,nbsp:x
"set listchars=tab:>-,trail:-,nbsp:%

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

filetype plugin indent on

if &term=="xterm"
	set t_Co=8
	set t_Sb=^[[4%dm
	set t_Sf=^[[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

set number
set autoindent
" set expandtab
set tabstop=4
set shiftwidth=4
if has("autocmd")
	autocmd FileType *
				\ let &l:comments
				\=join(filter(split(&l:comments, ','), 'v:val =~ "^[sme]"'), ',')
endif

"行頭へ
inoremap <silent> <C-a> <C-r>=MyJumptoBol('　。、．，／！？「」')<CR>
""行末へ
inoremap <silent> <C-e> <C-r>=MyJumptoEol('　。、．，／！？「」')<CR>

if neobundle#exists_not_installed_bundles()
	echomsg 'Not installed bundles : ' .
				\ string(neobundle#get_not_installed_bundle_names())
	echomsg 'Please execute ":NeoBundleInstall" command.'
endif


function! MyJumptoBol(sep)
	if col('.') == 1
		call cursor(line('.')-1, col('$'))
		call cursor(line('.'), col('$'))
		return ''
	endif
	if matchend(strpart(getline('.'), 0, col('.')), '[[:blank:]]\+') >= col('.')-1
		silent exec 'normal! 0'
		return ''
	endif
	if a:sep != ''
		call search('[^'.a:sep.']\+', 'bW', line("."))
		if col('.') == 1
			silent exec 'normal! ^'
		endif
		return ''
	endif
	exec 'normal! ^'
	return ''
endfunction

function! MyJumptoEol(sep)
	if col('.') == col('$')
		silent exec 'normal! w'
		return ''
	endif

	if a:sep != ''
		let prevcol = col('.')
		call search('['.a:sep.']\+[^'.a:sep.']', 'eW', line("."))
		if col('.') != prevcol
			return ''
		endif
	endif
	call cursor(line('.'), col('$'))
	return ''
endfunction

" clear search when press ecs twice
"nmap <Esc><Esc> :nohlsearch<CR><Esc>

" FuzzyFinder
let g:fuf_enumeratingLimit = 40
" let g:fuf_file_exclude = '\v\.DS_Store|\.git|\.swp|\.svn|node_modules'
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp|class|png|gif|jpg|jar)$|(^|[/\\])(\.(hg|git|bzr|svn)|(bytecode|node_modules|classes|exports|gef.*|perspectives.*|gsr.*|jacf.*))($|[/\\])'
let g:fuf_coveragefile_exclude = '\v\~$|\.(class|png|gif|jpg|jar|o|exe|dll|bak|orig|swp)$|(^|[/\\])(\.(hg|git|bzr|svn)|(bytecode|classes|node_modules))($|[/\\])'
let g:fuf_dir_exclude = '\v\~$|(^|[/\\])(\.(hg|git|bzr|svn)|(bytecode|node_modules|classes|exports|gef.*|perspectives.*|gsr.*|jacf.*))($|[/\\])'
nnoremap <silent> <C-p> :<C-u>FufCoverageFile!<CR>
nnoremap <silent> <C-l> :<C-u>FufLine!<CR>

syntax enable
set background=dark
set t_Co=256
""let g:solarized_termcolors=256
"colorscheme solarized
"colorscheme molokai
colorscheme jellybeans
"call togglebg#map("<F5>")
"colorscheme Tomorrow-Night-Eighties

"colorscheme slate
"hi Pmenu ctermfg=0 ctermbg=6 guibg=#444444
"hi PmenuSel ctermfg=7 ctermbg=4 guibg=#555555 guifg=#ffffff
"set cursorline
"hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

" Plugin key-mappings.
"imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

imap <C-j> <Esc>

" For snippet_complete marker.
if has('conceal')
	set conceallevel=2 concealcursor=i
endif

let g:neocomplcache_enable_at_startup = 1

"let g:neocomplcache_clang_use_library=1
"let g:neocomplcache_clang_library_path = '/usr/lib/'
let g:neocomplcache_clang_executable_path = '/usr/bin/clang'
let g:neocomplcache_clang_auto_options = "path, .clang_complete, clang"
let g:neocomplcache_max_list=1000

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

command! Rpspace :normal :%s/\s\+$// <CR><ESC>

" hilight the end space
augroup HighlightTrailingSpaces
	autocmd!
	autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
	autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

"以下@tokuhirom さんの設定パクリ
"(http://perl-users.jp/articles/advent-calendar/2012/casual/13)
autocmd BufNewFile *.pl 0r $HOME/.vim/template/perl-script.txt
autocmd BufNewFile *.t 0r $HOME/.vim/template/perl-test.txt

function! s:pm_template()
	let path = substitute(expand('%'), '.*lib/', '', 'g')
	let path = substitute(path, '[\\/]', '::', 'g')
	let path = substitute(path, '\.pm$', '', 'g')

	call append(0, 'package ' . path . ';')
	call append(1, 'use strict;')
	call append(2, 'use warnings;')
	call append(3, 'use utf8;')
	"call append(3, '')
	call append(4, '')
	call append(5, '')
	call append(6, '')
	call append(7, '1;')
	call cursor(6, 0)
	" echomsg path
endfunction
autocmd BufNewFile *.pm call s:pm_template()

function! s:get_package_name()
	let mx = '^\s*package\s\+\([^ ;]\+\)'
	for line in getline(1, 5)
		if line =~ mx
			return substitute(matchstr(line, mx), mx, '\1', '')
		endif
	endfor
	return ""
endfunction

function! s:check_package_name()
	let path = substitute(expand('%:p'), '\\', '/', 'g')
	let name = substitute(s:get_package_name(), '::', '/', 'g') . '.pm'
	if path[-len(name):] != name
		echohl WarningMsg
		echomsg "ぱっけーじめいと、ほぞんされているぱすが、ちがうきがします！"
		echomsg "ちゃんとなおしてください＞＜"
		echohl None
	endif
endfunction

au! BufWritePost *.pm call s:check_package_name()

map ,pt <Esc>:%! perltidy -se<CR>
map ,ptv <Esc>:'<,'>! perltidy -se<CR>

"@tokuhirom さんのパクリここまで

nmap <Leader>r <plug>(quickrun)

nnoremap <C-e> :!perl -c %<Enter>


" ==========================
" 文字コード自動判定
" =========================
if &encoding !=# 'utf-8'
	set encoding=japan
	set fileencoding=japan
endif
if has('iconv')
	let s:enc_euc = 'euc-jp'
	let s:enc_jis = 'iso-2022-jp'
	if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'eucjp-ms'
		let s:enc_jis = 'iso-2022-jp-3'
	elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'euc-jisx0213'
		let s:enc_jis = 'iso-2022-jp-3'
	endif
	if &encoding ==# 'utf-8'
		let s:fileencodings_default = &fileencodings
		let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
		let &fileencodings = &fileencodings .','. s:fileencodings_default
		unlet s:fileencodings_default
	else
		let &fileencodings = &fileencodings .','. s:enc_jis
		set fileencodings+=utf-8,ucs-2le,ucs-2
		if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
			set fileencodings+=cp932
			set fileencodings-=euc-jp
			set fileencodings-=euc-jisx0213
			set fileencodings-=eucjp-ms
			let &encoding = s:enc_euc
			let &fileencoding = s:enc_euc
		else
			let &fileencodings = &fileencodings .','. s:enc_euc
		endif
	endif
	unlet s:enc_euc
	unlet s:enc_jis
endif
if has('autocmd')
	function! AU_ReCheck_FENC()
		if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
			let &fileencoding=&encoding
		endif
	endfunction
	autocmd BufReadPost * call AU_ReCheck_FENC()
endif
