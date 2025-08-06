let g:codeium_disable_bindings = 1
let g:codeium_manual = v:true

imap <S-Tab> <Cmd>call codeium#CycleOrComplete() \| call lightline#update()<CR>
imap <silent><nowait><expr> <Leader><Tab> codeium#Accept()
