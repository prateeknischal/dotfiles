function! TrimWhitespace()
  if &ft == "markdown" || &ft == "vimwiki"
    return
  endif
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfunction

augroup trim_whitespace
  autocmd!
  autocmd BufWritePre * :call TrimWhitespace()
augroup END

" Indent/tabs
augroup filetype_options
  autocmd!
  autocmd Filetype vim      setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType json     setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype c,cpp,cc setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype html     setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype yaml     setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType markdown setlocal spell

  autocmd FileType rust     setlocal colorcolumn=100 textwidth=100

  " CPP setup done using this tutorial https://xuechendi.github.io/2019/11/11/VIM-CPP-IDE-2019-111-11-VIM_CPP_IDE
  autocmd FileType c,cpp,proto AutoFormatBuffer clang-format
augroup END
