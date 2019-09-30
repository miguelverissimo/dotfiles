function! SaveIfUnsaved()
  if &modified
    :w
  endif
endfunction

" Save with enter
function! Should_save_on_enter()
  return bufname('%') !=# 'swoopBuf' && empty(&buftype)
endfunction
nnoremap <silent> <expr> <CR> Should_save_on_enter() ? ':call SaveIfUnsaved()<CR>' : '<CR>'
