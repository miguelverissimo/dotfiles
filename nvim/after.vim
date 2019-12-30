:set cscopequickfix=s-,c-,d-,i-,t-,e-,a-,g-

let g:lmap.c = { 'name': 'Cscope' }
let g:lmap.c.s = ['cs find s <cword>', "Cscope Symbol"]
let g:lmap.c.g = ['cs find g <cword>', "Cscope Definition"]
let g:lmap.c.c = ['cs find c <cword>', "Cscope Callers"]
let g:lmap.c.d = ['cs find d <cword>', "Cscope Callees"]
let g:lmap.c.a = ['cs find a <cword>', "Cscope Assignments"]
let g:lmap.c.z = ['!sh -xc ''starscope -e cscope -e ctags -x "*.go" -x "*.js"''', "Cscope Build Database"]
let g:lmap.c.o = ['cs add cscope.out', "Cscope Open Database"]

let g:go_list_type = "quickfix"

let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file

""" For NERDTree
nnoremap <leader>nn :NERDTreeToggle<CR>
nnoremap \ :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap \| :NERDTreeFind<CR>
let g:NERDTreeShowBookmarks=1
let g:NERDTreeChDirMode=2 " Change the NERDTree directory to the root node
let g:NERDTreeHijackNetrw=0
augroup luan_nerdtree
  autocmd!
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
augroup END

""" For sunaku/vim-dasht
" search related docsets
nnoremap <Leader>k :Dasht<Space>
" search ALL the docsets
nnoremap <Leader><Leader>k :Dasht!<Space>
" search related docsets
nnoremap <silent> <Leader>K :call Dasht([expand('<cword>'), expand('<cWORD>')])<Return>
" search ALL the docsets
nnoremap <silent> <Leader><Leader>K :call Dasht([expand('<cword>'), expand('<cWORD>')], '!')<Return>
" search related docsets
vnoremap <silent> <Leader>K y:<C-U>call Dasht(getreg(0))<Return>
" search ALL the docsets
vnoremap <silent> <Leader><Leader>K y:<C-U>call Dasht(getreg(0), '!')<Return>
" create panel at right-most edge
let g:dasht_results_window = 'botright vnew'
""" /For sunaku/vim-dasht

""" For emmet
let g:user_emmet_settings = { 'javascript.jsx' : { 'extends' : 'jsx' } }

""" For utilsnips
" Trigger configuration (Optional)
let g:UltiSnipsExpandTrigger="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<M-]>"
let g:UltiSnipsJumpBackwardTrigger="<M-[>"
""" /For utilsnips

""" Set the colorscheme
set termguicolors
set background=dark

colorscheme blayu
" colorscheme rigel
" colorscheme candid
" colorscheme lucius
" colorscheme mysticaltutor

" colorscheme spring-night
" colorscheme stellarized
" colorscheme dracula
" colorscheme onehalfdark
" let g:lightline.colorscheme='onehalfdark'
" colorscheme tender
" let g:lightline.colorscheme='tender'
" colorscheme gruvbox

" colorscheme xcodedark
" colorscheme synthwave84
" colorscheme eighties

""" TABS ARE EVIL
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd BufEnter *.js setlocal foldmethod=syntax shiftwidth=2 tabstop=2 softtabstop=2 noexpandtab
autocmd BufEnter *.jsx setlocal foldmethod=syntax shiftwidth=2 tabstop=2 softtabstop=2 noexpandtab
" autocmd BufEnter *.rb setlocal foldmethod=syntax shiftwidth=2 tabstop=2 softtabstop=2 expandtab

""" Extend GraphQL syntax to .prisma files
au BufRead,BufNewFile *.prisma set filetype=graphql

