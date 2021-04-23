function! myspacevim#before() abort
  call SpaceVim#logger#info('myspacevim#before called')

  set autochdir
  " """ leader key is <Space>
  " let g:mapleader=' '

  """ restore session
  set ssop-=options    " do not store global and local values in a session
  set ssop-=folds      " do not store folds

  function! s:cd_to_project_root(path) abort
    let dir = fnamemodify(a:path, ':p:h')
    let root = finddir('.git', dir .';')
    if !empty(root)
      execute 'lcd' fnameescape(fnamemodify(root, ':h'))
      return 1
    endif
    return 0
  endfunction

  function! RestoreSess()
    call s:cd_to_project_root(getcwd())
    if filereadable('.git/.session.vim')
      execute 'so .git/.session.vim'
      execute 'Obsession .git/.session.vim'
    endif
  endfunction

  autocmd VimEnter * nested if !argc() | call RestoreSess() | endif

endfunction

function! myspacevim#after() abort
  call SpaceVim#logger#info('myspacevim#after entered')

  """ Escape to clear search
  nnoremap <silent> <esc> :noh<cr>

  """ python paths
  let g:python3_host_prog = '/home/miguel/.asdf/shims/python3'
  let g:python_host_prog = '/home/miguel/.asdf/shims/python2'

  """ neomake config
  let g:neomake_typescript_enabled_makers = ['eslint']

  """ CoC
  let s:coc_extensions = [
        \ 'coc-dictionary',
        \ 'coc-elixir',
        \ 'coc-ember',
        \ 'coc-eslint',
        \ 'coc-html',
        \ 'coc-json',
        \ 'coc-json',
        \ 'coc-rls',
        \ 'coc-solargraph',
        \ 'coc-tabnine',
        \ 'coc-tag',
        \ 'coc-go',
        \ 'coc-tsserver',
        \ 'coc-ultisnips',
        \ 'coc-stylelint',
        \ 'coc-tailwindcss',
        \]
  for extension in s:coc_extensions
    call coc#add_extension(extension)
  endfor

  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> gy <Plug>(coc-type-definition)

  nmap <leader>rn <Plug>(coc-rename)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  """ testing
  if empty($TMUX)
    let g:test#strategy = 'neoterm'
  else
    let g:test#strategy = 'vimux'
  endif

  " Do not run tests from binstubs
  let test#ruby#use_binstubs = 0
  let test#ruby#use_spring_binstub = 0

  """ autosave
  function! SaveIfUnsaved()
    if &modified
      :w
    endif
  endfunction

  if exists('g:autosave') && g:autosave ==# 1
    autocmd CursorHold * nested call SaveIfUnsaved()
  endif

  """ save with enter
  function! ShouldSaveOnEnter()
    return bufname('%') !=# 'swoopBuf' && empty(&buftype)
  endfunction
  nnoremap <silent> <expr> <CR> ShouldSaveOnEnter() ? ':call SaveIfUnsaved()<CR>' : '<CR>'

  """ remove trailing whitespace on save
  autocmd BufWritePre * %s/\s\+$//e

  set splitright            " Vertical splits to the right
  set splitbelow            " Horizontal splits below

  """ nerdtree
  nnoremap <leader>nn :NERDTreeToggle<CR>
  nnoremap \\ :NERDTreeToggle<CR>
  nnoremap <leader>nf :NERDTreeFind<CR>
  nnoremap \| :NERDTreeFind<CR>
  let g:NERDTreeChDirMode=2
  let g:NERDTreeShowHidden=1

  """ tab navigation
  nnoremap tl :tabnext<CR>
  nnoremap th :tabprev<CR>
  nnoremap tn :tabnew<CR>
  nnoremap tc :tabclose<CR>

  """ Quicker splits
  nnoremap <silent> <leader>vv :vsplit<cr>
  nnoremap <silent> <leader>vh :split<cr>

  """ Escape to clear search
  nnoremap <silent> <esc> :noh<cr>

  """ Y to copy till end of line
  nnoremap Y y$

  """ Extra commentary mappings
  xmap <c-_>  <Plug>Commentary
  omap <c-_>  <Plug>Commentary
  nmap <c-_>  <Plug>CommentaryLine




  call SpaceVim#logger#info('myspacevim#after processed')
endfunction
