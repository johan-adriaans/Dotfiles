if exists("b:did_ftplugin") | finish | endif

" Use HTML template ftplugins.
runtime! ftplugin/html.vim

" Append to b:match_words to match smarty tags ("{foo}..{/foo}")
if exists("loaded_matchit")
	if exists("b:match_words")
		let b:match_words .= ','
	else
		let b:match_words = ''
	endif
	let b:match_words .= '{\@<=\([^/][^ \t}]*\)[^}]*\%(}\|$\):{\@<=/\1}'
	let b:match_words .= ',{:},\[:\],(:)'
endif
