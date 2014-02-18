AlterCommand nse NeoSnippetEdit -split -vertical

let s:source = unite#sources#neosnippet#define()

" Override gather_candidates in order to match by .snip as well as .word
function! s:source.gather_candidates(args, context) "{{{
  return map(copy(a:context.source__snippets), "{
        \   'word' : v:val.word . ' ' . v:val.snip,
        \   'abbr' : printf('%-50s %s', v:val.word, v:val.menu_abbr),
        \   'kind' : 'neosnippet',
        \   'action__complete_word' : v:val.word,
        \   'action__complete_pos' : a:context.source__cur_keyword_pos,
        \   'action__path' : v:val.action__path,
        \   'action__pattern' : v:val.action__pattern,
        \   'source__menu' : v:val.menu_abbr,
        \   'source__snip' : v:val.snip,
        \   'source__snip_ref' : v:val,
        \ }")
endfunction "}}}
