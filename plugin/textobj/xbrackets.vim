" Vim plugin for text-objects such as x(), x<>, x[], and x{}.
" Maintainer: INAJIMA Daisuke <inajima@sopht.jp>
" Version: 1.0
" License: MIT License

if exists("g:loaded_textobj_xbrackets")
    finish
endif
let g:loaded_textobj_xbrackets = 1

let s:save_cpo = &cpo
set cpo&vim

call textobj#user#plugin('xbrackets', {
\   '$(_)': {
\	'select-a': ['aV(', 'aV)', 'aVb'],
\	'select-i': ['iV(', 'iV)', 'iVb'],
\	'*select-a-function*': 'textobj#xbrackets#select_variable_p_a',
\	'*select-i-function*': 'textobj#xbrackets#select_variable_p_i',
\   },
\   '${_}': {
\	'select-a': ['aV{', 'aV}', 'aVB'],
\	'select-i': ['iV{', 'iV}', 'iVB'],
\	'*select-a-function*': 'textobj#xbrackets#select_variable_b_a',
\	'*select-i-function*': 'textobj#xbrackets#select_variable_b_i',
\   },
\   '${_}$(_)': {
\	'select-a': 'av',
\	'select-i': 'iv',
\	'*select-a-function*': 'textobj#xbrackets#select_variable_a',
\	'*select-i-function*': 'textobj#xbrackets#select_variable_i',
\   },
\   'x(_)': {
\	'select-a': ['ax(', 'ax)', 'axb', 'a9', 'a0'],
\	'select-i': ['ix(', 'ix)', 'ixb', 'i9', 'i0'],
\	'*select-a-function*': 'textobj#xbrackets#select_x_r_a',
\	'*select-i-function*': 'textobj#xbrackets#select_x_r_i',
\   },
\   'x<_>': {
\	'select-a': 'ax<',
\	'select-i': 'ix<',
\	'*select-a-function*': 'textobj#xbrackets#select_x_a_a',
\	'*select-i-function*': 'textobj#xbrackets#select_x_a_i',
\   },
\   'x[_]': {
\	'select-a': 'ax[',
\	'select-i': 'ix[',
\	'*select-a-function*': 'textobj#xbrackets#select_x_s_a',
\	'*select-i-function*': 'textobj#xbrackets#select_x_s_i',
\   },
\   'x{_}': {
\	'select-a': ['ax{', 'axB'],
\	'select-i': ['ix{', 'ixB'],
\	'*select-a-function*': 'textobj#xbrackets#select_x_c_a',
\	'*select-i-function*': 'textobj#xbrackets#select_x_c_i',
\   },
\   'xs(_)': {
\	'select-a': ['axs(', 'axsb'],
\	'select-i': ['ixs(', 'ixsb'],
\	'*select-a-function*': 'textobj#xbrackets#select_xs_r_a',
\	'*select-i-function*': 'textobj#xbrackets#select_xs_r_i',
\   },
\   'xs<_>': {
\	'select-a': 'axs<',
\	'select-i': 'ixs<',
\	'*select-a-function*': 'textobj#xbrackets#select_xs_a_a',
\	'*select-i-function*': 'textobj#xbrackets#select_xs_a_i',
\   },
\   'xs[_]': {
\	'select-a': 'axs[',
\	'select-i': 'ixs[',
\	'*select-a-function*': 'textobj#xbrackets#select_xs_s_a',
\	'*select-i-function*': 'textobj#xbrackets#select_xs_s_i',
\   },
\   'xs{_}': {
\	'select-a': ['axs{', 'axsB'],
\	'select-i': ['ixs{', 'ixsB'],
\	'*select-a-function*': 'textobj#xbrackets#select_xs_c_a',
\	'*select-i-function*': 'textobj#xbrackets#select_xs_c_i',
\   },
\   'xs(){_}': {
\	'select-a': 'axs){',
\	'select-i': 'ixs){',
\	'*select-a-function*': 'textobj#xbrackets#select_xs_r_c_a',
\	'*select-i-function*': 'textobj#xbrackets#select_xs_r_c_i',
\   },
\   'y(_)': {
\	'select-a': ['ay(', 'ayb'],
\	'select-i': ['iy(', 'iyb'],
\	'*select-a-function*': 'textobj#xbrackets#select_y_r_a',
\	'*select-i-function*': 'textobj#xbrackets#select_y_r_i',
\   },
\   'y<_>': {
\	'select-a': 'ay<',
\	'select-i': 'iy<',
\	'*select-a-function*': 'textobj#xbrackets#select_y_a_a',
\	'*select-i-function*': 'textobj#xbrackets#select_y_a_i',
\   },
\   'y[_]': {
\	'select-a': 'ay[',
\	'select-i': 'iy[',
\	'*select-a-function*': 'textobj#xbrackets#select_y_s_a',
\	'*select-i-function*': 'textobj#xbrackets#select_y_s_i',
\   },
\   'y{_}': {
\	'select-a': ['ay{', 'ayB'],
\	'select-i': ['iy{', 'iyB'],
\	'*select-a-function*': 'textobj#xbrackets#select_y_c_a',
\	'*select-i-function*': 'textobj#xbrackets#select_y_c_i',
\   },
\   'ys(_)': {
\	'select-a': ['ays(', 'aysb'],
\	'select-i': ['iys(', 'iysb'],
\	'*select-a-function*': 'textobj#xbrackets#select_ys_r_a',
\	'*select-i-function*': 'textobj#xbrackets#select_ys_r_i',
\   },
\   'ys<_>': {
\	'select-a': 'ays<',
\	'select-i': 'iys<',
\	'*select-a-function*': 'textobj#xbrackets#select_ys_a_a',
\	'*select-i-function*': 'textobj#xbrackets#select_ys_a_i',
\   },
\   'ys[_]': {
\	'select-a': 'ays[',
\	'select-i': 'iys[',
\	'*select-a-function*': 'textobj#xbrackets#select_ys_s_a',
\	'*select-i-function*': 'textobj#xbrackets#select_ys_s_i',
\   },
\   'ys{_}': {
\	'select-a': ['ays{', 'aysB'],
\	'select-i': ['iys{', 'iysB'],
\	'*select-a-function*': 'textobj#xbrackets#select_ys_c_a',
\	'*select-i-function*': 'textobj#xbrackets#select_ys_c_i',
\   },
\   'ys(){_}': {
\	'select-a': 'ays){',
\	'select-i': 'iys){',
\	'*select-a-function*': 'textobj#xbrackets#select_ys_r_c_a',
\	'*select-i-function*': 'textobj#xbrackets#select_ys_r_c_i',
\   },
\})

let s:surround_objects = {
\   'x(': "\1x: \1(\r)",
\   'x)': "\1x: \1( \r )",
\   'xb': "\1x: \1(\r)",
\   'x<': "\1x: \1<\r>",
\   'x>': "\1x: \1< \r >",
\   'x[': "\1x: \1[\r]",
\   'x]': "\1x: \1[ \r ]",
\   'x{': "\1x: \1{\r}",
\   'x}': "\1x: \1{ \r }",
\   'xB': "\1x: \1{\r}",
\   '9': "\1x: \1(\r)",
\   '0': "\1x: \1( \r )",
\}

if !exists("g:textobj_xbrackets_extra_iskeyword")
    let g:textobj_xbrackets_extra_iskeyword = "*"
endif

if !exists("g:textobj_xbrackets_surround") || g:textobj_xbrackets_surround
    if !exists("g:surround_objects")
	let g:surround_objects = {}
    endif
    call extend(g:surround_objects, s:surround_objects, "keep")
endif

let &cpo = s:save_cpo
