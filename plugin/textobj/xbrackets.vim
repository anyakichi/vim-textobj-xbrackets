" Vim plugin for text-objects such as x(), x<>, x[], and x{}.

if exists("g:loaded_textobj_xbrackets")
    finish
endif
let g:loaded_textobj_xbrackets = 1

let s:save_cpo = &cpo
set cpo&vim

call textobj#user#plugin('xbrackets', {
\   '$()': {
\	'select-a': ['aV(', 'aV)', 'aVb'],
\	'select-i': ['iV(', 'iV)', 'iVb'],
\	'*select-a-function*': 's:select_variable_p_a',
\	'*select-i-function*': 's:select_variable_p_i',
\	'*sfile*': expand('<sfile>')
\   },
\   '${}': {
\	'select-a': ['aV{', 'aV}', 'aVB'],
\	'select-i': ['iV{', 'iV}', 'iVB'],
\	'*select-a-function*': 's:select_variable_b_a',
\	'*select-i-function*': 's:select_variable_b_i',
\	'*sfile*': expand('<sfile>')
\   },
\   '${}()': {
\	'select-a': 'av',
\	'select-i': 'iv',
\	'*select-a-function*': 's:select_variable_a',
\	'*select-i-function*': 's:select_variable_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'x()': {
\	'select-a': ['a9', 'a0'],
\	'select-i': ['i9', 'i0'],
\	'*select-a-function*': 's:select_xparen_a',
\	'*select-i-function*': 's:select_xparen_i',
\	'*sfile*': expand('<sfile>')
\   },
\})

function! s:getc(...)
    let off = (a:0 > 0) ? a:1 : 0
    return getline('.')[col('.') - 1 + off]
endfunction

function! s:poscmp(a, b)
    let [l1, c1] = len(a:a) == 2 ? [a:a[0], a:a[1]] : [a:a[1], a:a[2]]
    let [l2, c2] = len(a:b) == 2 ? [a:b[0], a:b[1]] : [a:b[1], a:b[2]]
    if l1 == l2
	return c1 - c2
    endif
    return l1 - l2
endfunction

function! s:save_env()
    let s:_save_pos = {}
    for m in [".", "'[", "']"]
	let s:_save_pos[m] = getpos(m)
    endfor
    let s:_save_reg = [getreg('a'), getregtype('a')]
    call setreg('a', '')
endfunction

function! s:restore_env()
    call setreg('a', s:_save_reg[0], s:_save_reg[1])
    for [key, val] in items(s:_save_pos)
	call setpos(key, val)
    endfor
endfunction

function! s:select_a(open, func)
    let c = v:count1

    call s:save_env()

    let pairs = "()<>[]{}"
    let open = a:open
    let close = pairs[stridx(pairs, open) + 1]

    let pos_save = getpos('.')

    let cpos = searchpos('\V' . close, 'cnW', line('.') + 1)
    let opos = searchpos('\V' . open,  'cnW', line('.') + 1)
    if cpos == [0, 0] || s:poscmp(opos, cpos) < 0
	call search(open, 'cW', line('.') + 1)
    endif

    while 1
	execute 'normal! "aya' . a:open . '`['

	if getreg('a') == '' || s:getc() != a:open
	    call s:restore_env()
	    return 0
	endif

	let [b, e] = a:func(getpos("'["), getpos("']"))
	if len(b) > 0 && len(e) > 0 && s:poscmp(b, pos_save) <= 0
	    let c -= 1
	    if c == 0
		break
	    endif
	endif
	call search('.', 'bW')
    endwhile

    call s:restore_env()
    return ['v', b, e]
endfunction

function! s:select_i(open, func)
    let result = s:select_a(a:open, a:func)

    if type(result) != type([])
	return 0
    endif

    let [type, oldb, olde] = result

    call s:save_env()

    call setpos('.', oldb)
    call search(a:open, 'c')
    let oldb = getpos('.')
    execute 'normal! "ayi' . a:open

    let [b, e] = [getpos("'["), getpos("']")]

    call s:restore_env()

    if !(s:poscmp(oldb, b) < 0 && s:poscmp(e, olde) < 0)
	return 0
    endif

    return [type, b, e]
endfunction

function! s:xparen_func(b, e)
    let pos = getpos('.')
    call setpos('.', a:b)

    normal! b
    let b = s:getc() =~ '\k' ? getpos('.') : []

    call setpos('.', pos)
    return [b, a:e]
endfunction

function! s:select_xparen_a()
    return s:select_a('(', function('s:xparen_func'))
endfunction

function! s:select_xparen_i()
    return s:select_i('(', function('s:xparen_func'))
endfunction

function! s:variable_func(b, e)
    let pos = getpos('.')
    call setpos('.', a:b)

    normal! h
    let b = s:getc() == '$' ? getpos('.') : []

    call setpos('.', pos)
    return [b, a:e]
endfunction

function! s:select_variable_b_a()
    return s:select_a('{', function('s:variable_func'))
endfunction

function! s:select_variable_b_i()
    return s:select_i('{', function('s:variable_func'))
endfunction

function! s:select_variable_p_a()
    return s:select_a('(', function('s:variable_func'))
endfunction

function! s:select_variable_p_i()
    return s:select_i('(', function('s:variable_func'))
endfunction

function! s:select_variable_a()
    let result = s:select_variable_b_a()
    if type(result) == type([])
	return result
    endif
    return s:select_variable_p_a()
endfunction

function! s:select_variable_i()
    let result = s:select_variable_b_i()
    if type(result) == type([])
	return result
    endif
    return s:select_variable_p_i()
endfunction

let &cpo = s:save_cpo
