function! myspacevim#before() abort
  call SpaceVim#logger#info('myspacevim#before called')
  call add(g:spacevim_custom_plugins, ['neoclide/coc.nvim', {'rev': 'release', 'merged': 0, 'build': './install.sh'}])
  call add(g:spacevim_custom_plugins, ['Konfekt/vim-scratchpad', {'branch': 'master', 'merged': 0}])
endfunction

function! myspacevim#after() abort
  " Split like a normal human being
  set splitbelow
  set splitright

  call SpaceVim#logger#info('myspacevim#after called')

  " Save with enter
  function! keyboard#should_save_on_enter()
    return bufname('%') !=# 'swoopBuf' && empty(&buftype)
  endfunction

  nnoremap <silent> <expr> <CR> keyboard#should_save_on_enter() ? ':call SaveIfUnsaved()<CR>' : '<CR>'

  " Escape to clear search
  nnoremap <silent> <esc> :noh<cr>

  " NERDTree
  " nnoremap <leader>nn :NERDTreeToggle<CR>
  " nnoremap \ :NERDTreeToggle<CR>
  nnoremap <leader>nf :NERDTreeFind<CR>
  nnoremap \| :NERDTreeFind<CR>

  " H L mappings
  nnoremap H 0
  nnoremap L $

  " Copy to system clipboard
  vmap <C-c> "+y
  vmap <C-x> "+c
  vmap <C-v> c<ESC>"+p
  imap <C-v> <ESC>"+pa

  " Navigate splits
  nnoremap <C-j> <C-w><C-j>
  nnoremap <C-k> <C-w><C-k>
  nnoremap <C-l> <C-w><C-l>
  nnoremap <C-h> <C-w><C-h>

  " Extra commentary mappings
  xmap <c-_>  <Plug>Commentary
  omap <c-_>  <Plug>Commentary
  nmap <c-_>  <Plug>CommentaryLine

  " W to write a file that requires sudo
  command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

  " Read ctags from .git first
  set tags=./git/tags;,./tags;,tags

  " Help ALE figure things out
  let g:ale_linters = {
  \ 'elixir':     ['elixir-ls'],
  \ 'go':         ['golangci-lint', 'gopls'],
  \ 'typescript': ['tsserver', 'typecheck'],
  \ 'javascript': ['eslint'],
  \ 'ruby':       ['rubocop', 'standardrb', 'ruby'],
  \}

  let g:ale_fixers = {
  \ 'javascript': ['importjs', 'prettier_eslint', 'prettier-eslint', 'trim_whitespace'],
  \ 'elixir':     ['mix_format'],
  \ 'ruby':       ['rubocop', 'standardrb'],
  \}

  " Ale mappings
  noremap <Leader>ad :ALEGoToDefinition<CR>
  nnoremap <leader>af :ALEFix<cr>
  noremap <Leader>ar :ALEFindReferences<CR>

  " Disable completion in ALE, we use CoC for that
  let g:ale_completion_enabled = 0

  " Show all files in nerdtree
  let g:NERDTreeShowHidden=1

  " remove trailing whitspace on save
  autocmd BufWritePre * %s/\s\+$//e

  " use markdown as the syntax and extension in vimwiki
  let g:vimwiki_list = [{'path': '~/vimwiki/',
                        \ 'syntax': 'markdown', 'ext': '.md'}]

  " CoC
  inoremap <silent><expr> <c-space> coc#refresh()

  let s:coc_extensions = [
  \ 'coc-css',
  \ 'coc-dictionary',
  \ 'coc-elixir',
  \ 'coc-ember',
  \ 'coc-emmet',
  \ 'coc-eslint',
  \ 'coc-highlight',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-python',
  \ 'coc-rls',
  \ 'coc-snippets',
  \ 'coc-solargraph',
  \ 'coc-tabnine',
  \ 'coc-tag',
  \ 'coc-tailwindcss',
  \ 'coc-tsserver',
  \ 'coc-yaml',
  \]

  for extension in s:coc_extensions
    call coc#add_extension(extension)

  " trailing whitespace
  EnableWhitespace

  " custom indents
  autocmd FileType rust set shiftwidth=4
  autocmd FileType rust set softtabstop=4
  let g:rustfmt_autosave = 1

  " vim-scratchpad
  let g:scratchpad_path = '$HOME/.scratchpads'
  nmap dsp <Plug>(ToggleScratchPad)

  " alternate file mapping
  nnoremap <space><space> <c-^>

  " alternate completion cycling
  inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
  inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

  " navigate diagnostics with [c and ]c
  nmap <silent> [c <Plug>(coc-diagnostic-prev)
  nmap <silent> ]c <Plug>(coc-diagnostic-next)

  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " rename word under cursor
  nmap <leader>rn <Plug>(coc-rename)

  " Remap for format selected region
  xmap <leader>f  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " update signature
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected

  " Remap for do codeAction of current line
  nmap <leader>ac  <Plug>(coc-codeaction)

  " Fix autofix problem of current line
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
  nmap <silent> <TAB> <Plug>(coc-range-select)
  xmap <silent> <TAB> <Plug>(coc-range-select)
  xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

  " Use `:Format` to format current buffer
  command! -nargs=0 Format :call CocAction('format')

  " Use `:Fold` to fold current buffer
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " use `:OR` for organize import of current buffer
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  let g:gruvbox_material_background = 'hard'
endfunction
