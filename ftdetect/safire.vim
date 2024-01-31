au BufRead,BufNewFile *.sr set filetype=safire

" TODO Move to a syntax file
" Inspired by vim-javascript: https://github.com/pangloss/vim-javascript/blob/master/syntax/javascript.vim

if exists("b:current_syntax")
  finish
endif

