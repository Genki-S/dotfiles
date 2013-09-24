setlocal foldmethod=marker
setlocal foldmarker={,}

autocmd BufWritePre <buffer> %s/\v[^;,{}]$/&;/gce
