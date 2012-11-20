set t_Co=16
call pathogen#infect()
set nowrap

filetype plugin on
filetype indent on
" tabs and indenting
set ai
set nosi
set nu

set tabstop=2
set shiftwidth=2
set expandtab
" set tabstop=3
" set softtabstop=0
" set shiftwidth=3
" set noexpandtab
set autoindent
set copyindent
set smarttab


" use unix style line ednings
set ff=unix
set foldmethod=marker

set pastetoggle=<F2>

" let g:solarized_termcolors=256
colorscheme ir_black
se background=dark
set gfn=Droid\ Sans\ Mono\ 11
set dir=/tmp
set bdir=/tmp
set diffexpr=MyDiff()
:hi Search guibg=Yellow guifg=black
set hlsearch
set incsearch

" added extensions
au BufNewFile,BufRead *.htm7 set filetype=html
au! BufRead,BufNewFile *.vm  setfiletype velocity

" clean formatting for css
":%s/\n\+\s*//g
":%s/:[ ]*/:/g
":%s/}/}\r\r/g
":%s/;/;\r\t/g
":%s/[ ]*{/ {\r\t/g
":%s/\(\t\)\?\/\*\(.*\)\*\//\1\/\*\r\1\2\r\1\*\/\r\1/ge
":%s/\(\t\)\?\/\*/\1\/\*\r\1/ge
"
":%s/\(\n\+\)\?\(\t\)\?\*\//\r\2\*\/\r\2\1\2/ge
":%s/^\t}/}/g
":%s/\t\([^:]\+\):/\t\1: /g
":%s/[ ]*!important/ !important/ge
":%s/\t\n//ge
":%s/\n\{3,\}/\r\r/ge
":%s/\(\n^$\)\{2,\}//ge
":let err=0
":while err == 0
"try
"%s/^\([^,\t]\+\),\([^$]\)/\1,\r\2/g
"catch /^Vim\%((\a\+)\)\=:E/
"endtry
":endwhile
"gg=G

map <F9> :%s/\n\+\s*//g<CR>:%s/:[ ]*/:/g<CR>:%s/}/}\r\r/g<CR>:%s/;/;\r\t/g<CR>:%s/[ ]*{/ {\r\t/g<CR>:%s/\(\t\)\?\/\*\(.*\)\*\//\1\/\*\r\1\2\r\1\*\/\r\1/ge<CR>:%s/\(\t\)\?\/\*/\1\/\*\r\1/ge<CR>:%s/\(\n\+\)\?\(\t\)\?\*\//\r\2\*\/\r\2\1\2/ge<CR>:%s/^\t}/}/g<CR>:%s/\t\([^:]\+\):/\t\1: /g<CR>:%s/[ ]*!important/ !important/ge<CR>:%s/\t\n//ge<CR>:%s/\n\{3,\}/\r\r/ge<CR>:%s/\(\n^$\)\{2,\}//ge<CR>:let err=0<CR>:while err == 0<CR>try<CR> %s/^\([^,\t]\+\),\([^$]\)/\1,\r\2/g<CR>catch /^Vim\%((\a\+)\)\=:E/<CR>endtry<CR>:endwhile<CR>gg=G<CR>

" sort css attributes
map <A-F12> :%s/[ ]\+$//ge<CR>:let _srch=search('{','W')<CR>viB:sort<CR>:if _srch == 0<CR>:echoerr "Sort reached bottom"<CR><ESC>:endif<CR><C-C><A-F12>

vmap <F11> <Esc>:'<,'><<<<<CR>:'<,'>s/^\(.*\)$/\t$sql .= " \1 ";/<CR>/$sql<CR>
"vmap <F12> <Esc>:'<,'>s/^.*= "//<CR>:'<,'>s/".*$//<CR>:SQLUFormatStmts<CR>/SELECT\\|INSERT\\|UPDATE\\|DELETE<CR>
nmap __gf <Esc>:tabe %:p:h/<C-R><C-F><CR>
"map <F12> :%!tidy -q -i --wrap 0 -utf8 --tidy-mark 0 2>/dev/null<CR>

function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

function! Preserve(command)
  "Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  "Do the business:
  execute a:command
  "Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

function! KillWhitey()
  "Double blank lines
  "call Preserve("%s/\n\{3,}/\r\r/e %s/\\s\\+$//e")
  "Whitespace
  call Preserve("%s/\\s\\+$//e")
endfunction

function! IndentFile()
  call Preserve("normal gg=G")
endfunction

nmap __$ :call KillWhitey()<CR>
nmap __= :call IndentFile()<CR>

autocmd BufWritePre * :call KillWhitey()
