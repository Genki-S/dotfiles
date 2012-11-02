" 「日本語入力固定モード」切替キー
inoremap <silent> <C-\> <C-r>=IMState('FixMode')<CR>
" PythonによるIBus制御指定
let IM_CtrlIBusPython = 1

set ttimeoutlen=100

" 「日本語入力固定モード」の全バッファローカルモード
let IM_CtrlBufLocalMode = 1
