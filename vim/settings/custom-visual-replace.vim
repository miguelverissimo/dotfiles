" Copy the current word or visually selected text to the clipboard:
nnoremap <F4> "+yiw
vnoremap <F4> "+y

" Replace the current word or visually selected text with the clipboard contents:
nnoremap <F5> viw"+p
vnoremap <F5> "+p

" Prepare a :substitute command using the current word or the selected text:
nnoremap <F6> yiw:%s/\<<C-r>"\>/<C-r>"/gc<Left><Left><Left>
vnoremap <F6> y:%s/\<<C-r>"\>/<C-r>"/gc<Left><Left><Left>

" One key <F7> does everything. Good for inter-window copying and pasting.
"copy
vmap <F7> "+ygv"zy`>
"paste (Shift-F7 to paste after normal cursor, Ctrl-F7 to paste over visual selection)
nmap <F7> "zgP
nmap <S-F7> "zgp
imap <F7> <C-r><C-o>z
vmap <C-F7> "zp`]
cmap <F7> <C-r><C-o>z

"copy register
autocmd FocusGained * let @z=@+
