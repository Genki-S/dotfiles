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
	let c = nr2char(getchar())
	let l:flags = "n"
	if a:motion ==# "F" || a:motion ==# "T"
		let l:flags .= "b"
	endif

	if search(c, l:flags, line(".")) != 0
		" Normal motion command
	elseif g:IMState == 2
		" Search Japanese with Rome
		while get(s:rome_kana_dictionary, c, "none") ==# "none"
			let c = c.nr2char(getchar())
			if strlen(c) >= 5
				return
			endif
		endwhile
		let c = get(s:rome_kana_dictionary, c)
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
	\ "nn": "ん",
	\ "xa": "ぁ", "xi": "ぃ", "xu": "ぅ", "xe": "ぇ", "xo": "ぉ",
	\ "xtsu": "っ","xya": "ゃ", "xyu": "ゅ", "xyo": "ょ",
	\ "xwa": "ゎ",
	\
	\ "A": "ア", "I": "イ", "U": "ウ", "E": "エ","O": "オ",
	\ "KA": "カ", "KI": "キ", "KU": "ク", "KE": "ケ", "KO": "コ",
	\ "GA": "ガ", "GI": "ギ", "GU": "グ", "GE": "ゲ", "GO": "ゴ",
	\ "SA": "サ", "SI": "シ", "SU": "ス", "SE": "セ", "SO": "ソ",
	\ "ZA": "ザ", "JI": "ジ", "ZU": "ズ", "ZE": "ゼ", "ZO": "ゾ",
	\ "TA": "タ", "CHI": "チ","TSU": "ツ","TE": "テ", "TO": "ト",
	\ "DA": "ダ", "DJI": "ヂ","DZU": "ヅ","DE": "デ", "DO": "ド",
	\ "NA": "ナ", "NI": "ニ", "NU": "ヌ", "NE": "ネ", "NO": "ノ",
	\ "HA": "ハ", "HI": "ヒ", "FU": "フ", "HE": "ヘ", "HO": "ホ",
	\ "BA": "バ", "BI": "ビ", "BU": "ブ", "BE": "ベ", "BO": "ボ",
	\ "PA": "パ", "PI": "ピ", "PU": "プ", "PE": "ペ", "PO": "ポ",
	\ "MA": "マ", "MI": "ミ", "MU": "ム", "ME": "メ", "MO": "モ",
	\ "YA": "ヤ", "YU": "ユ", "YO": "ヨ",
	\ "RA": "ラ", "RI": "リ", "RU": "ル","RE": "レ","RO": "ロ",
	\ "WA": "ワ", "WI": "ヰ", "WE": "ヱ", "WO": "ヲ", "NN": "ン",
	\ "XA": "ァ", "XI": "ィ", "XU": "ゥ", "XE": "ェ", "XO": "ォ",
	\ "XTSU": "ッ","XYA": "ャ", "XYU": "ュ", "XYO": "ョ",
	\ "VU": "ヴ", "XKA": "ヵ", "XKE": "ヶ","XWA": "ヮ",
	\
	\ "-": "ー", ",": "、", ".": "。",
	\ ":": "：", "@": "＠", "(": "（" , ")": "）",
	\ "~": "〜", "$": "＄", "#": "＃", "!": "！", "%": "％", "^": "＾", "&": "＆", "*": "＊",
	\ "_": "＿", "+": "＋", "=": "＝", "?": "？", ">": "＞", "<": "＜", "/": "／",
	\ "}": "』", "{": "『", "[": "「", "]": "」",
\ }
