execute pathogen#infect()
syntax on
set nocompatible
" set filetype detection, plugin and indent on so FileType event works
filetype plugin indent on

" set options {{{
	set number
	set wrap
	set numberwidth=3
	set tabstop=4
	set shiftwidth=4
	set hlsearch
	set incsearch
	set foldenable
	set splitbelow
	set mouse=a
	set backspace=indent,eol,start
	set encoding=utf-8 " set unicode
	set background=dark
	set completeopt=menu,longest " for autocompletion it open menu and let's you type and select suggestion
	colorscheme lucius
" }}}

let mapleader = ","
let maplocalleader = ";"

" set common mappings {{{
	" default to very magic for searching
	nnoremap / /\v

	" vim mapping helpful to edit and source vimrc while working
	nnoremap <leader>ev :vsplit $MYVIMRC<cr>
	nnoremap <leader>sv :source $MYVIMRC<cr>

	" mapping to open terminal in vim
	nnoremap <leader>t :term<cr>

	" disable arrow keys in normal and visual mode
	noremap <up> <nop>
	noremap <down> <nop>
	noremap <left> <nop>
	noremap <right> <nop>
	inoremap jk <esc>

	" split window movement mappings
	nnoremap <silent> <S-l> :wincmd l<CR>
	nnoremap <silent> <S-h> :wincmd h<CR>
	nnoremap <silent> <S-j> :wincmd j<CR>
	nnoremap <silent> <S-k> :wincmd k<CR>

	" use tab to navigate when popup menu is visible
	inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
	inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
	inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"

	" mappings related to buffers
	nnoremap <silent> <S-n> :bnext<CR>
	nnoremap <silent> <S-p> :bprevious<CR>
" }}}

" quick fix mappings {{{
	nnoremap <leader>q :call QuickFixToggle()<cr>
	nnoremap <leader>n :cnext<cr>
	nnoremap <leader>p :cprevious<cr>

	let g:quickfix_is_open = 0

	function! QuickFixToggle()
		if g:quickfix_is_open
			cclose
			let g:quickfix_is_open = 0
			execute g:quickfix_return_to_window . "wincmd w"
		else
			let g:quickfix_return_to_window = winnr()
			copen
			let g:quickfix_is_open = 1
		endif
	endfunction
" }}}

" NERDTree settings {{{
	let NERDTreeShowBookmarks = 1   " Show the bookmarks table
	let NERDTreeShowHidden = 1      " Show hidden files
	let NERDTreeShowLineNumbers = 0 " Hide line numbers
	let NERDTreeMinimalMenu = 1     " Use the minimal menu (m)
	let NERDTreeWinPos = "left"     " Panel opens on the left side
	let NERDTreeWinSize = 31        " Set panel width to 31 columns

	augroup nerdtree
		autocmd!
		autocmd VimEnter * NERDTree     " Open NERDTree automatically when vim editor is opened
		autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
      \ && b:NERDTree.isTabTree()) | q | endif     " Close NERDTree when vim editor is closed
		autocmd VimEnter * wincmd p     " change cursor to editor console
	augroup END

	nnoremap <silent> <F2> :NERDTreeToggle<CR>    " Toggle NERDTree when F2 key is pressed
	inoremap <silent> <F2> <esc>:NERDTreeToggle<CR> " Toogle NERDTree when F2 key is pressed
" }}}

" FZF settings {{{
	nnoremap <silent> <leader>f :FZF<CR>
	nnoremap <silent> <leader>s :Rg<CR>
	nnoremap <silent> <leader>S :RG<CR>
" }}}

" Vim Airline settings {{{
	let g:airline_theme='tomorrow'

	" enable tabline
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#buffer_nr_show = 1
	let g:airline#extensions#tabline#left_sep = ' '
	let g:airline#extensions#tabline#left_alt_sep = '|'

	let g:airline_detect_whitespace = 0

	let g:airline_powerline_fonts = 1
	set t_Co=256 " force 256 color mode

	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif

	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = ''
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = ''
	let g:airline_symbols.branch = ''
	let g:airline_symbols.readonly = ''
	let g:airline_symbols.linenr = '☰'
	let g:airline_symbols.maxlinenr = ''
	let g:airline_symbols.dirty='⚡'
" }}}

" Vim Go settings {{{
	" vim cheetsheet: https://gist.github.com/krlvi/d22bdcb66566261ea8e8da36f796fa0a

	" go syntax highlighting
	let g:go_highlight_fields = 1
	let g:go_highlight_functions = 1
	let g:go_highlight_function_calls = 1
	let g:go_highlight_extra_types = 1
	let g:go_highlight_operators = 1
	let g:go_highlight_diagnostic_errors = 1
	let g:go_highlight_diagnostic_warnings = 1
	let g:go_diagnostics_level = 2

	"miscellaneous settings
	let g:go_list_height = 10
	let g:go_doc_popup_window = 1

	" autoformatting and importing
	let g:go_fmt_autosave = 1
	let g:go_fmt_command = "goimports"
	let g:go_fmt_options = {
	\ 'goimports': '-local github.com/narahari92',
	\ }

	" status line types/signatures
	let g:go_auto_type_info = 1

	augroup filetype_go
		autocmd!
		autocmd FileType go :call GolangMappings()
	augroup END

	function! GolangMappings()
		nnoremap <localleader>gd :GoDef<CR>
		nnoremap <localleader>gr :GoReferrers<CR>
		nnoremap <localleader>gi :GoImplements<CR>
		nnoremap <localleader>r :GoRename<CR>
		nnoremap <localleader>d :GoDoc<CR>

		" location list helpers for golang
		nnoremap <localleader>q :call GolangListToggle()<cr>
		nnoremap <localleader>n :lnext<cr>
		nnoremap <localleader>p :lprevious<cr>

		"autocompletion mapping
		inoremap <buffer>. .<C-x><C-o>
		" use <c-space> to trigger completion
		if has('nvim')
			inoremap <silent> <C-space> <C-x><C-o>
		else
			inoremap <silent> <C-@> <C-x><C-o>
		endif

		" debug settings
		nnoremap <localleader>ds :GoDebugStart
		nnoremap <localleader>dt :GoDebugTest
	endfunction


	let g:golanglist_is_open = 0

	function! GolangListToggle()
		if g:golanglist_is_open
			lclose
			let g:golanglist_is_open = 0
			execute g:golanglist_return_to_window . "wincmd w"
		else
			let g:golanglist_return_to_window = winnr()
			lopen
			let g:golanglist_is_open = 1
		endif
	endfunction
" }}}

" Ultisnips settings {{{
	let g:UltiSnipsExpandTrigger="<tab>"
	let g:UltiSnipsJumpForwardTrigger="<tab>"
	let g:UltiSnipsJumpBackwardTrigger="<c-p>"
" }}}

" Tagbar settings {{{
	nnoremap <localleader>t :TagbarToggle<CR>
" }}}

augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END

" helper installation {{{
	command InstallHelpers :call HelperInstallation()

	function! HelperInstallation()
		call fzf#install()
		GoInstallBinaries
	endfunction
" }}}

