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
set background=dark
" colorscheme snow
" let g:lightline = { 'colorscheme': 'snow_dark' }
" colorscheme pink-moon
" colorscheme carbonized-dark
" colorscheme lucius
" colorscheme mysticaltutor
" colorscheme blayu
" colorscheme spring-night
" colorscheme stellarized
" colorscheme dracula
" colorscheme onehalfdark
" let g:lightline.colorscheme='onehalfdark'
" colorscheme tender
" let g:lightline.colorscheme='tender'
" colorscheme zenburn
colorscheme gruvbox

""" TWO SPACES
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
autocmd BufEnter *.js setlocal foldmethod=syntax shiftwidth=2 tabstop=2 softtabstop=2 noexpandtab
autocmd BufEnter *.jsx setlocal foldmethod=syntax shiftwidth=2 tabstop=2 softtabstop=2 noexpandtab
autocmd BufEnter *.rb setlocal foldmethod=syntax shiftwidth=2 tabstop=2 softtabstop=2 noexpandtab

""" Extend GraphQL syntax to .prisma files
au BufRead,BufNewFile *.prisma set filetype=graphql