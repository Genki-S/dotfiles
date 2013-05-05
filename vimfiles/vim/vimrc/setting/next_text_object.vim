onoremap <unique> an :<c-u>call <SID>NextTextObject('a', 'f')<cr>
xnoremap <unique> an :<c-u>call <SID>NextTextObject('a', 'f')<cr>
onoremap <unique> in :<c-u>call <SID>NextTextObject('i', 'f')<cr>
xnoremap <unique> in :<c-u>call <SID>NextTextObject('i', 'f')<cr>
onoremap <unique> al :<c-u>call <SID>NextTextObject('a', 'F')<cr>
xnoremap <unique> al :<c-u>call <SID>NextTextObject('a', 'F')<cr>
onoremap <unique> il :<c-u>call <SID>NextTextObject('i', 'F')<cr>
xnoremap <unique> il :<c-u>call <SID>NextTextObject('i', 'F')<cr>

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
