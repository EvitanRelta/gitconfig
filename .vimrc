source ~/nonessentials/visual_replace.vim
source ~/nonessentials/find.vim
source ~/nonessentials/text_editor_like_selection.vim

" Turn on syntax highlighting
syntax on
" Turn on smart auto-indentation
set autoindent
set smartindent
filetype plugin indent on
" Turn on auto-backup before editing
set backup
" Use ~/.backup as the backup directory
set backupdir=~/.backup
" Replace all tab with spaces
set expandtab
" Wrap long line at reasonable places (only affect 
" display, not content)
set wrap
set linebreak
" Make vim less like vi
set nocompatible
" Make default indent at 2 spaces
set shiftwidth=2
" Set tab stop to 2
set tabstop=2

" uncomment to turn on line number
" "set number

" vim is optimized for keyboard-only, but if you insist on using mouse,
" uncomment the following
set mouse=a

" Fix mouse not working on split screens
set ttymouse=sgr

" LMB goes into insert mode
nnoremap <LeftMouse> <LeftMouse>a

" Fix MMB copy-then-paste, instead of just pasting
vnoremap <MiddleMouse> "_dPi

" Ensures normal mode when changing tabs/windows/buffers
au BufLeave * call feedkeys("\<Esc>", 't')

" uncomment the following to show ruler (line,colum position)
" set ruler 

" some advanced options requested by students.  Use them only if
" you know what you are doing (I don't know what they do!)
" set hidden 
set wildmenu 
set wildmode=longest:list,full
" set showcmd 
set hlsearch 
" set confirm 
" set visualbell 
" set ignorecase 
" set smartcase

" The following should give 16 colors on old Windows machine
"set t_AB=[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm
"set t_AF=[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm
"set t_Co=16

" The following change the backspace on old Windows machine
set t_kb=

" Highlight cursor line
set cul

" Speed boost
" set lazyredraw
set ttyfast

" Set :vert to split right
set splitright

" Set autocomplete to only search keywords in current file, '.java' files in dir
set complete=.,u

" For students who are used to using the psvm/sout/sop abbreviation, you can
" uncomment the following.
"
iab mainfn public static void main(String[] args) {<CR><Bs>
iab println System.out.println;<Left>
iab printf System.out.printf;<Left>

"" PLUGINS
" vim-rainbow
" let g:rainbow_active = 1

" For lightline
set laststatus=2
let g:lightline={ 'colorscheme': 'deus' }

" Indentation
function! InsertTabWrapper()
  let col = col('.') - 1
  if pumvisible()
    return "\<C-Y>"
  elseif !col || getline('.')[col - 1] !~ '\k'
    return "\<Tab>"
  else
    return "\<C-P>"
  endif
endfunction
nnoremap <Tab> >>
inoremap <expr> <Tab> InsertTabWrapper()
vnoremap <Tab> >gv

" Decrease indentation
nnoremap <S-Tab> <<
vnoremap <S-Tab> <gv
inoremap <S-Tab> <C-D>

" Hide compiled java files
let g:netrw_list_hide='.*\.class$,^\./$,^\.nfs[^\.]*'

" Open new split view ([V] in Netrw) on right instead of left
let g:netrw_altv=1

" Always sets current dir as working dir in Netrw
let g:netrw_keepdir=0

" [Ctrl + Backspace] deletes previous word
" Requires 'stty -ixon' in ./bash_profile 
set backspace=indent,eol,start
noremap! <C-Bs> <C-W>
noremap! <C-H> <C-W>

" Fix not selecting last character if cursor at end of line
set virtualedit=onemore

" [Ctrl + D] deletes next word
inoremap <C-D> X<Esc>ce

" [C] (visual) yank
vnoremap <silent> c y

" [V] (visual) paste
vnoremap <silent> v "_dP

" [Home] (insert) goes to first non-whitespace
inoremap <silent> <Home> <C-O>^

" [Ctrl + S] save
nnoremap <silent> <C-S> :up!<CR>
vnoremap <silent> <C-S> <C-C>:up!<CR>
inoremap <silent> <C-S> <Esc>:up!<CR>a

" [Ctrl + W] quit without saving
nnoremap <silent> <C-W> :q!<CR>
vnoremap <silent> <C-W> <C-C>:q!<CR>
inoremap <silent> <C-W> <Esc>:q!<CR>

" [Ctrl + T] new explorer tab
nnoremap <silent> <C-T> :Tex<CR>
vnoremap <silent> <C-T> <C-C>:Tex<CR>
inoremap <silent> <C-T> <Esc>:Tex<CR>

" [Ctrl + G] new explorer split
nnoremap <silent> <C-G> :Vex!<CR><C-W>=
vnoremap <silent> <C-G> <C-C>:Vex!<CR><C-W>=
inoremap <silent> <C-G> <Esc>:Vex!<CR><C-W>=

" [Ctrl + Q] return to explorer
nnoremap <silent> <C-Q> :Rex<CR>
vnoremap <silent> <C-Q> <C-C>:Rex<CR>
inoremap <silent> <C-Q> <Esc>:Rex<CR>

" [Ctrl + N] swap split windows
nnoremap <silent> <C-N> <C-W>r
vnoremap <silent> <C-N> <C-C><C-W>r
inoremap <silent> <C-N> <Esc><C-W>ra

" [Ctrl + Z] undo
nnoremap <silent> <C-Z> u
vnoremap <silent> <C-Z> <C-C>u
inoremap <silent> <C-Z> <Esc>ui

" [Ctrl + Y] redo
nnoremap <silent> <C-Y> <C-R>
vnoremap <silent> <C-Y> <C-C><C-R>
inoremap <silent> <C-Y> <Esc><C-R>a

" [Ctrl + A] visually select all
nnoremap <silent> <C-A> ggVG
vnoremap <silent> <C-A> <C-Home>oVG
inoremap <silent> <C-A> <C-Home><C-O>VG

" [Ctrl + K] compile current file
nnoremap <silent> <C-K> :!clear; javac -Xlint:unchecked,rawtypes %<CR>
vnoremap <silent> <C-K> <C-C>:!clear; javac -Xlint:unchecked,rawtypes %<CR>
inoremap <silent> <C-K> <Esc>:!clear; javac -Xlint:unchecked,rawtypes %<CR>

" [Ctrl + J] vertical terminal
nnoremap <silent> <C-J> :vert ter<CR>
vnoremap <silent> <C-J> <C-C>:vert ter<CR>
inoremap <silent> <C-J> <Esc>:vert ter<CR>

" [Ctrl + B] (normal mode) vertical split diff with current file
nnoremap <silent> <C-B> :vert diffsplit 


" [Ctrl + /] (visual) comment / uncomment selection
function! JavaVisualCommentAndUncomment()
  let isAllCommented = 1
  let [startLine, endLine] = sort([line('v'), line('.')])

  " Check if every line is commented
  while startLine <= endLine
    if getline(startLine) !~ "^\\s*//"
      let isAllCommented = 0
    endif
    let startLine += 1
  endwhile

  if isAllCommented
    return ":norm ^xx\<CR>"
  else
    return ":norm i//\<CR>"
  endif
endfunction
au FileType java vnoremap <expr> <C-_> JavaVisualCommentAndUncomment()


" [Ctrl + /] (insert) comment / uncomment line
function! JavaInsertCommentAndUncomment()
  let startingCol = col('.') - 1
  let isCommented = getline('.') =~ "^\\s*//"
  if isCommented
    return "\<Esc>I\<Del>\<Del>\<Esc>" . (startingCol - 1) . "|i"
  else
    return "\<Esc>I//\<Esc>" . (startingCol + 3) . "|i"
  endif
endfunction
au FileType java inoremap <expr> <C-_> JavaInsertCommentAndUncomment()

" VSCode-like colorscheme
colorscheme codedark

" Highlight 80 char boundary
set colorcolumn=80

" Delete selection
vnoremap <Bs> "_d
vnoremap <Del> "_d

" Disable error bell sounds
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Prevent selecting newline in visual mode
set selection=exclusive

" Auto-complete keywords from every .java file in current dir
" You'll have start vim in working directory first.
argadd ./*.java


function! LoadTemplate()
  " Use .vim/templates/template.ext file, whr .ext is the new-file extension
  silent! 0r ~/.vim/templates/template.%:e

  " Replace all [FILE_NAME] with the new-file filename
  %s/\[FILE_NAME\]/\=expand("%:t:r")/g
  call cursor(3,5)
  call feedkeys('a')
endfunction

" Use template when creating new .java files
au BufNewFile *.java call LoadTemplate()

" Start in insert mode
" au BufRead,BufNewFile * startinsert

" DelimitMate expand: function fn() {<CR>} gives
" function fn() {
"   //cursor here
" }
let g:delimitMate_expand_cr = 1
