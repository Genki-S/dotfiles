call lexima#set_default_rules()

call neobundle#source('neocomplete')
if neobundle#is_sourced('neocomplete')
	" close neocomplete popup on <CR>
	call lexima#insmode#map_hook('before', '<CR>', "\<C-r>=neocomplete#close_popup()\<CR>")
end
