set nocompatible
if has('vim_starting')
	set runtimepath+=~/.vim/bundles/neobundle.vim
endif
call neobundle#rc(expand('~/vendor'))

source ~/.vim/vimrc/functions.vim

let s:vendors = Genki_yaml_load_with_cache('~/dotfiles/vendor/vendors.yml')
for vendor in s:vendors
	for [vendor_source_name, vendor_options] in items(vendor)
		execute 'NeoBundle "' . vendor_source_name . '" , ' . string(vendor_options)
	endfor
endfor

NeoBundleCheck
