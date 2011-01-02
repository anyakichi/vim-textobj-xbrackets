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
\   '${}$()': {
\	'select-a': 'av',
\	'select-i': 'iv',
\	'*select-a-function*': 's:select_variable_a',
\	'*select-i-function*': 's:select_variable_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'x()': {
\	'select-a': ['ax(', 'ax)', 'axb', 'a9', 'a0'],
\	'select-i': ['ix(', 'ix)', 'ixb', 'i9', 'i0'],
\	'*select-a-function*': 's:select_x_r_a',
\	'*select-i-function*': 's:select_x_r_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'x<>': {
\	'select-a': 'ax<',
\	'select-i': 'ix<',
\	'*select-a-function*': 's:select_x_a_a',
\	'*select-i-function*': 's:select_x_a_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'x[]': {
\	'select-a': 'ax[',
\	'select-i': 'ix[',
\	'*select-a-function*': 's:select_x_s_a',
\	'*select-i-function*': 's:select_x_s_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'x{}': {
\	'select-a': ['ax{', 'axB'],
\	'select-i': ['ix{', 'ixB'],
\	'*select-a-function*': 's:select_x_c_a',
\	'*select-i-function*': 's:select_x_c_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'xs()': {
\	'select-a': ['axs(', 'axsb'],
\	'select-i': ['ixs(', 'ixsb'],
\	'*select-a-function*': 's:select_xs_r_a',
\	'*select-i-function*': 's:select_xs_r_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'xs<>': {
\	'select-a': 'axs<',
\	'select-i': 'ixs<',
\	'*select-a-function*': 's:select_xs_a_a',
\	'*select-i-function*': 's:select_xs_a_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'xs[]': {
\	'select-a': 'axs[',
\	'select-i': 'ixs[',
\	'*select-a-function*': 's:select_xs_s_a',
\	'*select-i-function*': 's:select_xs_s_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'xs{}': {
\	'select-a': ['axs{', 'axsB'],
\	'select-i': ['ixs{', 'ixsB'],
\	'*select-a-function*': 's:select_xs_c_a',
\	'*select-i-function*': 's:select_xs_c_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'xs(){}': {
\	'select-a': 'axs){',
\	'select-i': 'ixs){',
\	'*select-a-function*': 's:select_xs_r_c_a',
\	'*select-i-function*': 's:select_xs_r_c_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'y()': {
\	'select-a': ['ay(', 'ayb'],
\	'select-i': ['iy(', 'iyb'],
\	'*select-a-function*': 's:select_y_r_a',
\	'*select-i-function*': 's:select_y_r_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'y<>': {
\	'select-a': 'ay<',
\	'select-i': 'iy<',
\	'*select-a-function*': 's:select_y_a_a',
\	'*select-i-function*': 's:select_y_a_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'y[]': {
\	'select-a': 'ay[',
\	'select-i': 'iy[',
\	'*select-a-function*': 's:select_y_s_a',
\	'*select-i-function*': 's:select_y_s_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'y{}': {
\	'select-a': ['ay{', 'ayB'],
\	'select-i': ['iy{', 'iyB'],
\	'*select-a-function*': 's:select_y_c_a',
\	'*select-i-function*': 's:select_y_c_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'ys()': {
\	'select-a': ['ays(', 'aysb'],
\	'select-i': ['iys(', 'iysb'],
\	'*select-a-function*': 's:select_ys_r_a',
\	'*select-i-function*': 's:select_ys_r_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'ys<>': {
\	'select-a': 'ays<',
\	'select-i': 'iys<',
\	'*select-a-function*': 's:select_ys_a_a',
\	'*select-i-function*': 's:select_ys_a_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'ys[]': {
\	'select-a': 'ays[',
\	'select-i': 'iys[',
\	'*select-a-function*': 's:select_ys_s_a',
\	'*select-i-function*': 's:select_ys_s_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'ys{}': {
\	'select-a': ['ays{', 'aysB'],
\	'select-i': ['iys{', 'iysB'],
\	'*select-a-function*': 's:select_ys_c_a',
\	'*select-i-function*': 's:select_ys_c_i',
\	'*sfile*': expand('<sfile>')
\   },
\   'ys(){}': {
\	'select-a': 'ays){',
\	'select-i': 'iys){',
\	'*select-a-function*': 's:select_ys_r_c_a',
\	'*select-i-function*': 's:select_ys_r_c_i',
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

function! s:save_env(dict)
    " Remove all entries.
    call filter(a:dict, '0')

    let a:dict['pos'] = {}
    for m in [".", "'[", "']"]
	let a:dict['pos'][m] = getpos(m)
    endfor
    let a:dict['reg'] = [getreg('a'), getregtype('a')]
    call setreg('a', '')
endfunction

function! s:restore_env(dict)
    call setreg('a', a:dict['reg'][0], a:dict['reg'][1])
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


"
" Main functions to select outer and innder objects
"
function! s:select_a(open, func)
    let c = v:count1

    let env = {}
    call s:save_env(env)

    let pos_save = getpos('.')
    let pairs = "()<>[]{}"
    let open = a:open
    let close = pairs[stridx(pairs, open) + 1]

    let cpos = searchpos('\V' . close, 'cnW')
    let opos = searchpos('\V' . open,  'cnW')
    if cpos == [0, 0] || s:poscmp(opos, cpos) < 0
	call search(open, 'cW')
    endif

    while 1
	execute 'normal! "aya' . a:open . '`['

	if getreg('a') == '' || s:getc() != a:open
	    call s:restore_env(env)
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

    call s:restore_env(env)
    return ['v', b, e]
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
    execute 'normal! "ayi' . a:open

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
	let pairs = "()<>[]{}"
	let close = pairs[stridx(pairs, open) + 1]

	call search('.', 'bW')
	if s:getc() == close
	    let e = getpos('.')
	    normal! %
	endif
    endif

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
function! s:select_x_r_a()
    return s:select_a('(', function('s:x_func'))
endfunction
function! s:select_x_r_i()
    return s:select_i('(', function('s:x_func'))
endfunction

function! s:select_x_a_a()
    return s:select_a('<', function('s:x_func'))
endfunction
function! s:select_x_a_i()
    return s:select_i('<', function('s:x_func'))
endfunction

function! s:select_x_s_a()
    return s:select_a('[', function('s:x_func'))
endfunction
function! s:select_x_s_i()
    return s:select_i('[', function('s:x_func'))
endfunction

function! s:select_x_c_a()
    return s:select_a('{', function('s:x_func'))
endfunction
function! s:select_x_c_i()
    return s:select_i('{', function('s:x_func'))
endfunction

function! s:select_xs_r_a()
    return s:select_a('(', function('s:xs_func'))
endfunction
function! s:select_xs_r_i()
    return s:select_i('(', function('s:xs_func'))
endfunction

function! s:select_xs_a_a()
    return s:select_a('<', function('s:xs_func'))
endfunction
function! s:select_xs_a_i()
    return s:select_i('<', function('s:xs_func'))
endfunction

function! s:select_xs_s_a()
    return s:select_a('[', function('s:xs_func'))
endfunction
function! s:select_xs_s_i()
    return s:select_i('[', function('s:xs_func'))
endfunction

function! s:select_xs_c_a()
    return s:select_a('{', function('s:xs_func'))
endfunction
function! s:select_xs_c_i()
    return s:select_i('{', function('s:xs_func'))
endfunction

function! s:select_xs_r_c_a()
    return s:select_a('{', function('s:xs_r_func'))
endfunction
function! s:select_xs_r_c_i()
    return s:select_i('{', function('s:xs_r_func'))
endfunction

function! s:select_y_r_a()
    return s:select_a('(', function('s:y_func'))
endfunction
function! s:select_y_r_i()
    return s:select_i('(', function('s:y_func'))
endfunction

function! s:select_y_a_a()
    return s:select_a('<', function('s:y_func'))
endfunction
function! s:select_y_a_i()
    return s:select_i('<', function('s:y_func'))
endfunction

function! s:select_y_s_a()
    return s:select_a('[', function('s:y_func'))
endfunction
function! s:select_y_s_i()
    return s:select_i('[', function('s:y_func'))
endfunction

function! s:select_y_c_a()
    return s:select_a('{', function('s:y_func'))
endfunction
function! s:select_y_c_i()
    return s:select_i('{', function('s:y_func'))
endfunction

function! s:select_ys_r_a()
    return s:select_a('(', function('s:ys_func'))
endfunction
function! s:select_ys_r_i()
    return s:select_i('(', function('s:ys_func'))
endfunction

function! s:select_ys_a_a()
    return s:select_a('<', function('s:ys_func'))
endfunction
function! s:select_ys_a_i()
    return s:select_i('<', function('s:ys_func'))
endfunction

function! s:select_ys_s_a()
    return s:select_a('[', function('s:ys_func'))
endfunction
function! s:select_ys_s_i()
    return s:select_i('[', function('s:ys_func'))
endfunction

function! s:select_ys_c_a()
    return s:select_a('{', function('s:ys_func'))
endfunction
function! s:select_ys_c_i()
    return s:select_i('{', function('s:ys_func'))
endfunction

function! s:select_ys_r_c_a()
    return s:select_a('{', function('s:ys_r_func'))
endfunction
function! s:select_ys_r_c_i()
    return s:select_i('{', function('s:ys_r_func'))
endfunction


"
" Functions for $() and ${}
"
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

if !exists("g:textobj_xbrackets_extra_iskeyword")
    let g:textobj_xbrackets_extra_iskeyword = "*"
endif

let &cpo = s:save_cpo
