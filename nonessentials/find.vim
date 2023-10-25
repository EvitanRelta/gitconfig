" [Ctrl + F]
" (normal/insert mode) clear highlights
nnoremap <C-F> :noh<CR>
inoremap <C-F> <ESC>:noh<CR>a

" (visual mode) find selected text
vnoremap <C-F> y/<C-R>"<CR>
