function! g:MyOpenBrowser(...) abort
  let l:query = a:0
        \ ? a:1
        \ : join(getregion(getpos("'<"), getpos("'>"), #{ type: visualmode() }), "\n")
  let l:jira_domain = get(g:, 'my_openbrowser_jira_domain', '')

  if !empty(l:jira_domain)
    let l:jira_key = substitute(l:query, '[,:]\+$', '', '')
    if l:jira_key =~# '^[A-Z]\+-[0-9]\+$'
      call openbrowser#open(substitute(l:jira_domain, '/\+$', '', '') . '/browse/' . l:jira_key)
      return
    endif
  endif

  call openbrowser#smart_search(l:query)
endfunction
