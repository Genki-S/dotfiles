" ==================================================
" Make it easy to make it easy
" ==================================================
nnoremap <SID>[edit] <Nop>
nmap <Leader>e <SID>[edit]
nnoremap <SID>[edit]v :tabnew $MYVIMRC<CR>
nnoremap <SID>[edit]s :N

nnoremap <SID>[source] <Nop>
nmap <Leader>S <SID>[source]
nnoremap <SID>[source]v :source $MYVIMRC<CR>

" ==================================================
" Next/Last text objects
" ==================================================
onoremap an :<c-u>call <SID>NextTextObject('a', 'f')<cr>
xnoremap an :<c-u>call <SID>NextTextObject('a', 'f')<cr>
onoremap in :<c-u>call <SID>NextTextObject('i', 'f')<cr>
xnoremap in :<c-u>call <SID>NextTextObject('i', 'f')<cr>
onoremap al :<c-u>call <SID>NextTextObject('a', 'F')<cr>
xnoremap al :<c-u>call <SID>NextTextObject('a', 'F')<cr>
onoremap il :<c-u>call <SID>NextTextObject('i', 'F')<cr>
xnoremap il :<c-u>call <SID>NextTextObject('i', 'F')<cr>

function! s:NextTextObject(motion, dir)
	let c = nr2char(getchar())

	if c ==# "b"
		let c = "("
	elseif c ==# "B"
		let c = "{"
	elseif c ==# "d"
		let c = "["
	endif

	exe "normal! ".a:dir.c."v".a:motion.c
endfunction

" ==================================================
" Misc.
" ==================================================
" make & trigger :&& so it preserves flags
nnoremap & :&&<Enter>
xnoremap & :&&<Enter>

" select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" ==================================================
" Insert Mode Mappings
" ==================================================
inoremap <Leader><C-u> <Esc>gUiWEa

" ==================================================
" Japanese
" ==================================================
" make ( and ) work with Japanese sentences
nnoremap <silent> ( ?[.。]<CR>:noh<CR>
nnoremap <silent> ) /[.。]<CR>:noh<CR>

nnoremap <silent> f :<C-u>call <SID>JapaneseMotion('f')<CR>
nnoremap <silent> F :<C-u>call <SID>JapaneseMotion('F')<CR>
nnoremap <silent> t :<C-u>call <SID>JapaneseMotion('t')<CR>
nnoremap <silent> T :<C-u>call <SID>JapaneseMotion('T')<CR>

function! s:JapaneseMotion(motion)
	if g:IMState == 2
		echo "Type Rome: "
		let c = nr2char(getchar())
		while get(s:rome_kana_dictionary, c, "none") ==# "none"
			let c = c.nr2char(getchar())
			if strlen(c) >= 5
				return
			endif
		endwhile
		let c = get(s:rome_kana_dictionary, c)
	else
		let c = nr2char(getchar())
	endif
	execute "normal! ".a:motion.c
endfunction

let s:rome_kana_dictionary = {
	\ "a": "あ", "i": "い", "u": "う", "e": "え","o": "お",
	\ "ka": "か", "ki": "き", "ku": "く", "ke": "け", "ko": "こ",
	\ "ga": "が", "gi": "ぎ", "gu": "ぐ", "ge": "げ", "go": "ご",
	\ "sa": "さ", "shi": "し","su": "す", "se": "せ", "so": "そ",
	\ "za": "ざ", "ji": "じ", "zu": "ず", "ze": "ぜ", "zo": "ぞ",
	\ "ta": "た", "chi": "ち","tsu": "つ","te": "て", "to": "と",
	\ "da": "だ", "dji": "ぢ","dzu": "づ","de": "で", "do": "ど",
	\ "na": "な", "ni": "に", "nu": "ぬ", "ne": "ね", "no": "の",
	\ "ha": "は", "hi": "ひ", "fu": "ふ", "he": "へ", "ho": "ほ",
	\ "ba": "ば", "bi": "び", "bu": "ぶ", "be": "べ", "bo": "ぼ",
	\ "pa": "ぱ", "pi": "ぴ", "pu": "ぷ", "pe": "ぺ", "po": "ぽ",
	\ "ma": "ま", "mi": "み", "mu": "む", "me": "め", "mo": "も",
	\ "ya": "や", "yu": "ゆ", "yo": "よ",
	\ "ra": "ら", "ri": "り", "ru": "る","re": "れ","ro": "ろ",
	\ "wa": "わ", "wi": "ゐ", "we": "ゑ", "wo": "を",
	\ "n": "ん",
	\ "xa": "ぁ", "xi": "ぃ", "xu": "ぅ", "xe": "ぇ", "xo": "ぉ",
	\ "xtsu": "っ","xya": "ゃ", "xyu": "ゅ", "xyo": "ょ",
	\ "xwa": "ゎ",
\ }
