if !exists('b:fif_pattern') | let b:fif_pattern = 'pattern' | endif

syntax match FiFFile /^.\+/

syntax match FiFPattern /".*/ contained
syntax match FiFHeader /\v^Find pattern.+/ contains=FiFPattern

syntax match FiFContextLine /-.*/ contained
syntax match FiFMatchLine /:.*/ contained contains=FiFMatch
syntax match FiFLineNumber /^\s*[0-9]\+/

syntax match FiFResultLine /^\s*[0-9]\+.*/ contains=FiFLineNumber,FiFContextLine,FiFMatchLine

execute 'syntax match FiFMatch /\v'.b:fif_pattern.'/'

syntax match FiFSeparator /^--/

hi link FiFHeader PreProc
hi link FiFPattern String
hi link FiFFile Function
hi link FiFLineNumber LineNr
hi link FiFSeparator LineNr
hi link FiFContextLine Comment
hi link FiFMatchLine Normal
hi link FiFMatch Operator

