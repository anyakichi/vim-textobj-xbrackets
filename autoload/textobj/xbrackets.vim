" Vim plugin for text-objects such as x(), x<>, x[], and x{}.
" Maintainer: INAJIMA Daisuke <inajima@sopht.jp>
" License: MIT License

let s:save_cpo = &cpo
set cpo&vim

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

function! s:save_env(dict)
    " Remove all entries.
    call filter(a:dict, '0')

    let a:dict['pos'] = {}
    for m in [".", "'[", "']"]
	let a:dict['pos'][m] = getpos(m)
    endfor

    let a:dict['topline'] = line('w0')

    let a:dict['reg'] = [getreg('a'), getregtype('a')]
    call setreg('a', '')
endfunction

function! s:restore_env(dict)
    call setreg('a', a:dict['reg'][0], a:dict['reg'][1])

    normal! H
    while line('w0') > a:dict['topline']
	normal! k
    endwhile

    for [key, val] in items(a:dict['pos'])
	call setpos(key, val)
    endfor
endfunction

function! s:get_extra_isk()
    let isk = exists("b:textobj_xbrackets_extra_iskeyword") ?
    \	      b:textobj_xbrackets_extra_iskeyword :
    \	      g:textobj_xbrackets_extra_iskeyword
    return isk
endfunction

function! s:get_pair(open)
    let pairs = "()<>[]{}"
    let i = stridx(pairs, a:open)
    if i == -1
	return ''
    endif
    return (i % 2 == 0) ? pairs[i + 1] : pairs[idx - 1]
endfunction


"
" Main functions to select outer and innder objects
"
function! s:select_a(open, func)
    let c = v:count1

    let env = {}
    call s:save_env(env)

    let pos_save = getpos('.')
    let close = s:get_pair(a:open)

    let cpos = searchpos('\V' . close, 'cnW')
    let opos = searchpos('\V' . a:open,  'cnW')
    if cpos == [0, 0] || s:poscmp(opos, cpos) < 0
	call search('\V' . a:open, 'cW')
    endif

    while 1
	execute 'silent normal! "aya' . a:open . '`['

	if getreg('a') == '' || s:getc() != a:open
	    call s:restore_env(env)
	    return 0
	endif

	let result = a:func(getpos("'["), getpos("']"))
	if len(result) > 0 && s:poscmp(result[0], pos_save) <= 0
	    let c -= 1
	    if c == 0
		break
	    endif
	endif
	call search('.', 'bW')
    endwhile

    call s:restore_env(env)
    return ['v', result[0], result[1]]
endfunction

function! s:select_i(open, func)
    let result = s:select_a(a:open, a:func)

    if type(result) != type([])
	return 0
    endif

    let [type, oldb, olde] = result

    let env = {}
    call s:save_env(env)

    call setpos('.', oldb)
    call search(a:open, 'c')
    let oldb = getpos('.')
    execute 'silent normal! "ayi' . a:open

    let [b, e] = [getpos("'["), getpos("']")]

    call s:restore_env(env)

    if !(s:poscmp(oldb, b) < 0 && s:poscmp(e, olde) < 0)
	return 0
    endif

    return [type, b, e]
endfunction


"
" Functions for x(), x<>, x[], and x{}
"
function! s:xs_func(b, e, ...) " [max [, open [, isk]]]
    let max = a:0 > 0 ? a:1 : -1
    let open = a:0 > 1 ? a:2 : ''
    let isk = a:0 > 2 ? a:3 : ''

    let pos = getpos('.')
    let isk_save = &isk

    call setpos('.', a:b)
    execute 'set isk+=' . isk

    if open != ''
	let close = s:get_pair(open)

	call search('\S', 'bW')
	if s:getc() != close
	    let &isk = isk_save
	    call setpos('.', pos)
	    return []
	endif
	let e = getpos('.')
	normal! %
    endif

    let b = getpos('.')
    let c = 0
    normal! b
    while s:getc() =~ '\k' && c != max && !(b[1] == 1 && b[2] == 1)
	let b = getpos('.')
	let c += 1
	normal! b
    endwhile

    let &isk = isk_save
    call setpos('.', pos)
    if c == 0
	return []
    endif
    return [b, a:e]
endfunction

function! s:ys_func(b, e, ...) " [max [, open]]
    let max = a:0 > 0 ? a:1 : -1
    let open = a:0 > 1 ? a:2 : ''
    let extra_isk = s:get_extra_isk()

    return s:xs_func(a:b, a:e, max, open, extra_isk)
endfunction

function! s:x_func(b, e)
    return s:xs_func(a:b, a:e, 1)
endfunction

function! s:y_func(b, e)
    return s:ys_func(a:b, a:e, 1)
endfunction

function! s:xs_r_func(b, e)
    return s:xs_func(a:b, a:e, -1, '(')
endfunction

function! s:ys_r_func(b, e)
    return s:ys_func(a:b, a:e, -1, '(')
endfunction

" Callback functions
function! textobj#xbrackets#select_x_r_a()
    return s:select_a('(', function('s:x_func'))
endfunction
function! textobj#xbrackets#select_x_r_i()
    return s:select_i('(', function('s:x_func'))
endfunction

function! textobj#xbrackets#select_x_a_a()
    return s:select_a('<', function('s:x_func'))
endfunction
function! textobj#xbrackets#select_x_a_i()
    return s:select_i('<', function('s:x_func'))
endfunction

function! textobj#xbrackets#select_x_s_a()
    return s:select_a('[', function('s:x_func'))
endfunction
function! textobj#xbrackets#select_x_s_i()
    return s:select_i('[', function('s:x_func'))
endfunction

function! textobj#xbrackets#select_x_c_a()
    return s:select_a('{', function('s:x_func'))
endfunction
function! textobj#xbrackets#select_x_c_i()
    return s:select_i('{', function('s:x_func'))
endfunction

function! textobj#xbrackets#select_xs_r_a()
    return s:select_a('(', function('s:xs_func'))
endfunction
function! textobj#xbrackets#select_xs_r_i()
    return s:select_i('(', function('s:xs_func'))
endfunction

function! textobj#xbrackets#select_xs_a_a()
    return s:select_a('<', function('s:xs_func'))
endfunction
function! textobj#xbrackets#select_xs_a_i()
    return s:select_i('<', function('s:xs_func'))
endfunction

function! textobj#xbrackets#select_xs_s_a()
    return s:select_a('[', function('s:xs_func'))
endfunction
function! textobj#xbrackets#select_xs_s_i()
    return s:select_i('[', function('s:xs_func'))
endfunction

function! textobj#xbrackets#select_xs_c_a()
    return s:select_a('{', function('s:xs_func'))
endfunction
function! textobj#xbrackets#select_xs_c_i()
    return s:select_i('{', function('s:xs_func'))
endfunction

function! textobj#xbrackets#select_xs_r_c_a()
    return s:select_a('{', function('s:xs_r_func'))
endfunction
function! textobj#xbrackets#select_xs_r_c_i()
    return s:select_i('{', function('s:xs_r_func'))
endfunction

function! textobj#xbrackets#select_y_r_a()
    return s:select_a('(', function('s:y_func'))
endfunction
function! textobj#xbrackets#select_y_r_i()
    return s:select_i('(', function('s:y_func'))
endfunction

function! textobj#xbrackets#select_y_a_a()
    return s:select_a('<', function('s:y_func'))
endfunction
function! textobj#xbrackets#select_y_a_i()
    return s:select_i('<', function('s:y_func'))
endfunction

function! textobj#xbrackets#select_y_s_a()
    return s:select_a('[', function('s:y_func'))
endfunction
function! textobj#xbrackets#select_y_s_i()
    return s:select_i('[', function('s:y_func'))
endfunction

function! textobj#xbrackets#select_y_c_a()
    return s:select_a('{', function('s:y_func'))
endfunction
function! textobj#xbrackets#select_y_c_i()
    return s:select_i('{', function('s:y_func'))
endfunction

function! textobj#xbrackets#select_ys_r_a()
    return s:select_a('(', function('s:ys_func'))
endfunction
function! textobj#xbrackets#select_ys_r_i()
    return s:select_i('(', function('s:ys_func'))
endfunction

function! textobj#xbrackets#select_ys_a_a()
    return s:select_a('<', function('s:ys_func'))
endfunction
function! textobj#xbrackets#select_ys_a_i()
    return s:select_i('<', function('s:ys_func'))
endfunction

function! textobj#xbrackets#select_ys_s_a()
    return s:select_a('[', function('s:ys_func'))
endfunction
function! textobj#xbrackets#select_ys_s_i()
    return s:select_i('[', function('s:ys_func'))
endfunction

function! textobj#xbrackets#select_ys_c_a()
    return s:select_a('{', function('s:ys_func'))
endfunction
function! textobj#xbrackets#select_ys_c_i()
    return s:select_i('{', function('s:ys_func'))
endfunction

function! textobj#xbrackets#select_ys_r_c_a()
    return s:select_a('{', function('s:ys_r_func'))
endfunction
function! textobj#xbrackets#select_ys_r_c_i()
    return s:select_i('{', function('s:ys_r_func'))
endfunction


"
" Functions for $() and ${}
"
function! s:variable_func(b, e)
    let pos = getpos('.')
    call setpos('.', a:b)

    normal! h
    let result = s:getc() == '$' ? [getpos('.'), a:e] : []

    call setpos('.', pos)
    return result
endfunction

function! textobj#xbrackets#select_variable_b_a()
    return s:select_a('{', function('s:variable_func'))
endfunction

function! textobj#xbrackets#select_variable_b_i()
    return s:select_i('{', function('s:variable_func'))
endfunction

function! textobj#xbrackets#select_variable_p_a()
    return s:select_a('(', function('s:variable_func'))
endfunction

function! textobj#xbrackets#select_variable_p_i()
    return s:select_i('(', function('s:variable_func'))
endfunction

function! textobj#xbrackets#select_variable_a()
    let result = textobj#xbrackets#select_variable_b_a()
    if type(result) == type([])
	return result
    endif
    return textobj#xbrackets#select_variable_p_a()
endfunction

function! textobj#xbrackets#select_variable_i()
    let result = textobj#xbrackets#select_variable_b_i()
    if type(result) == type([])
	return result
    endif
    return textobj#xbrackets#select_variable_p_i()
endfunction

let &cpo = s:save_cpo
