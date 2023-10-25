function! Replace()
  let isMultiLineSelection = line('v') != line('.')
  if isMultiLineSelection
    " Replace previously yanked text in selection
    return ":s/\<C-R>\"//g\<LEFT>\<LEFT>"
  endif
  " Highlight selected text, and replace all selected text
  return "y/\<C-R>\"\<CR>:%s/\<C-R>\"//g\<LEFT>\<LEFT>"
endfunction

" [CTRL + R] (visual)
vnoremap <expr> <C-R> Replace()
