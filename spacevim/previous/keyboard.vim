" Save with enter
function! SaveIfUnsaved()
  if &modified
    :w
  endif
endfunction


function! keyboard#should_save_on_enter()
  return bufname('%') !=# 'swoopBuf' && empty(&buftype)
endfunction

" call with:
" nnoremap <silent> <expr> <CR> keyboard#should_save_on_enter() ? ':call SaveIfUnsaved()<CR>' : '<CR>'
