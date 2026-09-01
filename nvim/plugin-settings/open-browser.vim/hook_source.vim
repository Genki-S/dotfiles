function! s:query(args) abort
  return !empty(a:args)
        \ ? a:args[0]
        \ : join(getregion(getpos("'<"), getpos("'>"), #{ type: visualmode() }), "\n")
endfunction

function! g:MyOpenBrowser(...) abort
  if openbrowser#_keymap_open(a:0 ? 'n' : 'v', 1)
    return
  endif

  let l:query = s:query(a:000)
  let l:candidate = substitute(l:query, '[,:]\+$', '', '')
  let l:jira_domain = get(g:, 'my_openbrowser_jira_domain', '')

  if !empty(l:jira_domain) && l:candidate =~# '^[A-Z]\+-[0-9]\+$'
    call openbrowser#open(substitute(l:jira_domain, '/\+$', '', '') . '/browse/' . l:candidate)
    return
  endif

  let l:github_enabled = get(g:, 'my_openbrowser_enable_github', v:false)
  let l:gitlab_domain = get(g:, 'my_openbrowser_gitlab_domain', '')
  if (l:github_enabled || !empty(l:gitlab_domain))
        \ && l:candidate =~# '^[-.[:alnum:]_]\+/[-.[:alnum:]_]\+\%(/[-.[:alnum:]_]\+\)\?$'
    if l:github_enabled && !empty(l:gitlab_domain)
      echo 'Open repository on Git[h]ub or Git[l]ab: '
      let l:choice = tolower(getcharstr())
      echo ''
    else
      let l:choice = l:github_enabled ? 'h' : 'l'
    endif

    if l:choice ==# 'h'
      call openbrowser#open('https://github.com/' . l:candidate)
    elseif l:choice ==# 'l'
      call openbrowser#open(substitute(l:gitlab_domain, '/\+$', '', '') . '/' . l:candidate)
    endif
    return
  endif

  call openbrowser#smart_search(l:query)
endfunction

function! g:MyOpenBrowserRaw(...) abort
  call openbrowser#smart_search(s:query(a:000))
endfunction
