" Define mappings
augroup vimrc_denite
	autocmd!
	autocmd FileType denite call s:denite_my_settings()
	autocmd FileType denite-filter call s:denite_filter_my_settings()
augroup END

function! s:denite_my_settings() abort
	nnoremap <silent><buffer><expr> <CR>
				\ denite#do_map('do_action')
	nnoremap <silent><buffer><expr> d
				\ denite#do_map('do_action', 'delete')
	nnoremap <silent><buffer><expr> p
				\ denite#do_map('do_action', 'preview')
	nnoremap <silent><buffer><expr> q
				\ denite#do_map('quit')
	nnoremap <silent><buffer><expr> <Esc>
				\ denite#do_map('quit')
	nnoremap <silent><buffer><expr> i
				\ denite#do_map('open_filter_buffer')
	nnoremap <silent><buffer><expr> <Space>
				\ denite#do_map('toggle_select').'j'
endfunction

" concept: I don't use "Normal mode" with denite
function! s:denite_filter_my_settings() abort
	" let <Esc> in filter buffer also quit denite (note the <Esc> after `<Plug>(denite_filter_quit)`)
	imap <silent><buffer> <Esc> <Plug>(denite_filter_quit)<Esc>
	" let <CR> in filter buffer invoke the 'do_action' (note the <CR> after `<Plug>(denite_filter_update)`)
	imap <silent><buffer> <CR> <Plug>(denite_filter_update)<CR>
	" move cursor in denite buffer while in filter buffer
	setlocal complete=""
	call deoplete#custom#buffer_option('auto_complete', v:false)
	inoremap <silent><buffer> <C-n> <Esc>
				\:call denite#move_to_parent()<CR>
				\:call cursor(line('.')+1,0)<CR>
				\:call denite#move_to_filter()<CR>A
	inoremap <silent><buffer> <C-p> <Esc>
				\:call denite#move_to_parent()<CR>
				\:call cursor(line('.')-1,0)<CR>
				\:call denite#move_to_filter()<CR>A
endfunction

" Use ripgrep for file/rec
call denite#custom#var('file/rec', 'command',
			\ ['rg', '--files', '--glob', '!.git', '--color', 'never'])

" Change matchers.
" TODO: Try matcher/cpsm
call denite#custom#source(
			\ 'file_mru', 'matchers', ['matcher/fuzzy'])
call denite#custom#source(
			\ 'file/rec', 'matchers', ['matcher/fuzzy'])

" Change sorters.
call denite#custom#source(
			\ 'file/rec', 'sorters', ['sorter/sublime'])

" Use ripgrep command on grep source
call denite#custom#var('grep', {
			\ 'command': ['rg'],
			\ 'default_opts': ['-i', '--vimgrep', '--no-heading'],
			\ 'recursive_opts': [],
			\ 'pattern_opt': ['--regexp'],
			\ 'separator': ['--'],
			\ 'final_opts': [],
			\ })

" Custom action
" Note: lambda function is not supported in Vim8.
call denite#custom#action('file', 'test',
			\ {context -> execute('let g:foo = 1')})
call denite#custom#action('file', 'test2',
			\ {context -> denite#do_action(
			\  context, 'open', context['targets'])})
" Source specific action
call denite#custom#action('source/file', 'test',
			\ {context -> execute('let g:bar = 1')})
