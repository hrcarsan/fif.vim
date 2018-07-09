
command! -complete=shellcmd -nargs=+ FindInFiles call s:Find(<q-args>)
command! -complete=shellcmd -nargs=+ FiF call s:Find(<q-args>)


function! s:Find(pattern)

  let buffer_name = 'Find '.a:pattern

  if bufexists(buffer_name)

    let bdel_command = exists(':Bdelete')? 'Bdelete': 'bdelete'

    execute bdel_command.' '.buffer_name
  endif

  " create a new buffer
  execute 'silent edit '.buffer_name

  " save the pattern in a buffer var
  let b:fif_pattern = a:pattern

  setlocal nonumber
  set buftype=nowrite
  set filetype=fif

  " make the search
  call feedkeys('/'.a:pattern."\<cr>")

  let rg_command = 'silent r ! rg --line-number --heading --context 3 --color never '.
                  \'--follow  --line-number-width 5 --no-config --encoding utf-8 -- '.shellescape(a:pattern)

  execute rg_command

  call append(0, ['Find pattern "'.a:pattern.'"'])
  normal! gg

  nnoremap <buffer> gf :call FiFGoToFile()<cr>:<c-c>
  nnoremap <buffer> <leader>z :call FiFFoldResults()<cr>:<c-c>

endfunction


function! g:FiFGoToFile()

  let current_line = getline('.')
  let line_number  = get(matchlist(current_line, '\v^\s*(\d+)'), 1)

  if !line_number | return | endif

  let file_name      = getline(search('^[^0-9 -].*', 'bnW'))
  let current_column = col('.')
  let row_start      = get(matchstrpos(current_line, '\v^\s*\d+[-:]'), 2)
  let column_number  = current_column - row_start

  execute 'edit '.file_name
  call cursor(line_number, column_number)

endfunction


function! g:FiFFoldResults()

  let in_result_line  = match(getline('.'), '\v^\s*\d+[-:]') != -1

  if !in_result_line | return | endif

  let next_file  = search('\v^[^0-9 -]', 'we')
  let end_line   = search('\v^\s*\d+', 'bwe')
  let start_line = search('\v^[^0-9 -]', 'bWe')

  execute 'normal! jV'.end_line.'Gzf'
endfunction
