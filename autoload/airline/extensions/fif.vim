" MIT License. Copyright (c) 2018 Santiago Herrera Cardona <santiagohecar@gmail.com>

scriptencoding utf-8


let s:spc = g:airline_symbols.space


function! airline#extensions#fif#init(ext)

  " Next up we add a funcref so that we can run some code prior to the
  " statusline getting modifed.
  call a:ext.add_statusline_func('airline#extensions#fif#apply')

  " You can also add a funcref for inactive statuslines.
  " call a:ext.add_inactive_statusline_func('airline#extensions#fif#unapply')
endfunction

" This function will be invoked just prior to the statusline getting modified.
function! airline#extensions#fif#apply(...)

  if &filetype !=# 'fif' | return | endif

  if !exists('b:fif_pattern') | let b:fif_pattern = 'pattern' | endif
    " Then we just append this extenion to it, optionally using separators.
    "let w:airline_section_b = 'Find in Files'
    "let w:airline_section_c = '%{airline#extensions#fif#get_cats()}'
    let w:airline_section_c = 'Find in Files'.s:spc.g:airline_left_alt_sep.s:spc.b:fif_pattern
    let w:airline_section_x = ''
endfunction

