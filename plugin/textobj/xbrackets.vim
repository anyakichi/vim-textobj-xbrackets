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
\	'select-a': ['ax(', 'ax)', 'axb', 'a9', 'a0'],
\	'select-i': ['ix(', 'ix)', 'ixb', 'i9', 'i0'],
\	'*select-a-function*': 's:select_x_parens_a',
\	'*select-i-function*': 's:select_x_parens_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'x<>': {
\	'select-a': ['ax<', 'ax>'],
\	'select-i': ['ix<', 'ix>'],
\	'*select-a-function*': 's:select_x_angles_a',
\	'*select-i-function*': 's:select_x_angles_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'x[]': {
\	'select-a': ['ax[', 'ax]'],
\	'select-i': ['ix[', 'ix]'],
\	'*select-a-function*': 's:select_x_brackets_a',
\	'*select-i-function*': 's:select_x_brackets_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'x{}': {
\	'select-a': ['ax{', 'ax}', 'axB'],
\	'select-i': ['ix{', 'ix}', 'ixB'],
\	'*select-a-function*': 's:select_x_braces_a',
\	'*select-i-function*': 's:select_x_braces_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'xs()': {
\	'select-a': ['aX(', 'aX)', 'aXb'],
\	'select-i': ['iX(', 'iX)', 'iXb'],
\	'*select-a-function*': 's:select_xs_parens_a',
\	'*select-i-function*': 's:select_xs_parens_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'xs<>': {
\	'select-a': ['aX<', 'aX>'],
\	'select-i': ['iX<', 'iX>'],
\	'*select-a-function*': 's:select_xs_angles_a',
\	'*select-i-function*': 's:select_xs_angles_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'xs[]': {
\	'select-a': ['aX[', 'aX]'],
\	'select-i': ['iX[', 'iX]'],
\	'*select-a-function*': 's:select_xs_brackets_a',
\	'*select-i-function*': 's:select_xs_brackets_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'xs{}': {
\	'select-a': ['aX{', 'aX}', 'aXB'],
\	'select-i': ['iX{', 'iX}', 'iXB'],
\	'*select-a-function*': 's:select_xs_braces_a',
\	'*select-i-function*': 's:select_xs_braces_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'y()': {
\	'select-a': ['ay(', 'ay)', 'ayb'],
\	'select-i': ['iy(', 'iy)', 'iyb'],
\	'*select-a-function*': 's:select_y_parens_a',
\	'*select-i-function*': 's:select_y_parens_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'y<>': {
\	'select-a': ['ay<', 'ay>'],
\	'select-i': ['iy<', 'iy>'],
\	'*select-a-function*': 's:select_y_angles_a',
\	'*select-i-function*': 's:select_y_angles_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'y[]': {
\	'select-a': ['ay[', 'ay]'],
\	'select-i': ['iy[', 'iy]'],
\	'*select-a-function*': 's:select_y_brackets_a',
\	'*select-i-function*': 's:select_y_brackets_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'y{}': {
\	'select-a': ['ay{', 'ay}', 'ayB'],
\	'select-i': ['iy{', 'iy}', 'iyB'],
\	'*select-a-function*': 's:select_y_braces_a',
\	'*select-i-function*': 's:select_y_braces_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'ys()': {
\	'select-a': ['aY(', 'aY)', 'aYb'],
\	'select-i': ['iY(', 'iY)', 'iYb'],
\	'*select-a-function*': 's:select_ys_parens_a',
\	'*select-i-function*': 's:select_ys_parens_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'ys<>': {
\	'select-a': ['aY<', 'aY>'],
\	'select-i': ['iY<', 'iY>'],
\	'*select-a-function*': 's:select_ys_angles_a',
\	'*select-i-function*': 's:select_ys_angles_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'ys[]': {
\	'select-a': ['aY[', 'aY]'],
\	'select-i': ['iY[', 'iY]'],
\	'*select-a-function*': 's:select_ys_brackets_a',
\	'*select-i-function*': 's:select_ys_brackets_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'ys{}': {
\	'select-a': ['aY{', 'aY}', 'aYB'],
\	'select-i': ['iY{', 'iY}', 'iYB'],
\	'*select-a-function*': 's:select_ys_braces_a',
\	'*select-i-function*': 's:select_ys_braces_i',
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

function! s:x_func(b, e)
    return s:xs_func(a:b, a:e, 1)
endfunction

function! s:xs_func(b, e, ...)
    let max = a:0 > 0 ? a:1 : -1
    let isk = a:0 > 1 ? a:2 : ''

    let pos = getpos('.')
    let isk_save = &isk

    call setpos('.', a:b)
    execute 'set isk+=' . isk

    let b = []
    let c = 0
    normal! b
    while s:getc() =~ '\k' && c != max
	let b = getpos('.')
	let c += 1
	normal! b
    endwhile

    let &isk = isk_save
    call setpos('.', pos)
    return [b, a:e]
endfunction

function! s:y_func(b, e)
    return s:ys_func(a:b, a:e, 1)
endfunction

function! s:ys_func(b, e, ...)
    let max = a:0 > 0 ? a:1 : -1
    let extra_isk = exists("b:textobj_xbrackets_extra_iskeyword") ?
    \		    b:textobj_xbrackets_extra_iskeyword :
    \		    g:textobj_xbrackets_extra_iskeyword

    return s:xs_func(a:b, a:e, max, extra_isk)
endfunction

function! s:select_x_parens_a()
    return s:select_a('(', function('s:x_func'))
endfunction

function! s:select_x_parens_i()
    return s:select_i('(', function('s:x_func'))
endfunction

function! s:select_x_angles_a()
    return s:select_a('<', function('s:x_func'))
endfunction

function! s:select_x_angles_i()
    return s:select_i('<', function('s:x_func'))
endfunction

function! s:select_x_brackets_a()
    return s:select_a('[', function('s:x_func'))
endfunction

function! s:select_x_brackets_i()
    return s:select_i('[', function('s:x_func'))
endfunction

function! s:select_x_braces_a()
    return s:select_a('{', function('s:x_func'))
endfunction

function! s:select_x_braces_i()
    return s:select_i('{', function('s:x_func'))
endfunction

function! s:select_xs_parens_a()
    return s:select_a('(', function('s:xs_func'))
endfunction

function! s:select_xs_parens_i()
    return s:select_i('(', function('s:xs_func'))
endfunction

function! s:select_xs_angles_a()
    return s:select_a('<', function('s:xs_func'))
endfunction

function! s:select_xs_angles_i()
    return s:select_i('<', function('s:xs_func'))
endfunction

function! s:select_xs_brackets_a()
    return s:select_a('[', function('s:xs_func'))
endfunction

function! s:select_xs_brackets_i()
    return s:select_i('[', function('s:xs_func'))
endfunction

function! s:select_xs_braces_a()
    return s:select_a('{', function('s:xs_func'))
endfunction

function! s:select_xs_braces_i()
    return s:select_i('{', function('s:xs_func'))
endfunction

function! s:select_y_parens_a()
    return s:select_a('(', function('s:y_func'))
endfunction

function! s:select_y_parens_i()
    return s:select_i('(', function('s:y_func'))
endfunction

function! s:select_y_angles_a()
    return s:select_a('<', function('s:y_func'))
endfunction

function! s:select_y_angles_i()
    return s:select_i('<', function('s:y_func'))
endfunction

function! s:select_y_brackets_a()
    return s:select_a('[', function('s:y_func'))
endfunction

function! s:select_y_brackets_i()
    return s:select_i('[', function('s:y_func'))
endfunction

function! s:select_y_braces_a()
    return s:select_a('{', function('s:y_func'))
endfunction

function! s:select_y_braces_i()
    return s:select_i('{', function('s:y_func'))
endfunction

function! s:select_ys_parens_a()
    return s:select_a('(', function('s:ys_func'))
endfunction

function! s:select_ys_parens_i()
    return s:select_i('(', function('s:ys_func'))
endfunction

function! s:select_ys_angles_a()
    return s:select_a('<', function('s:ys_func'))
endfunction

function! s:select_ys_angles_i()
    return s:select_i('<', function('s:ys_func'))
endfunction

function! s:select_ys_brackets_a()
    return s:select_a('[', function('s:ys_func'))
endfunction

function! s:select_ys_brackets_i()
    return s:select_i('[', function('s:ys_func'))
endfunction

function! s:select_ys_braces_a()
    return s:select_a('{', function('s:ys_func'))
endfunction

function! s:select_ys_braces_i()
    return s:select_i('{', function('s:ys_func'))
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

let g:textobj_xbrackets_extra_iskeyword = "*"

let &cpo = s:save_cpo
