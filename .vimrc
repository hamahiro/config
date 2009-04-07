

"-----------------------------------------------------------------------------
" �ץ饰�����Ϣ
"
" --- autocomplpop ---
autocmd FileType * let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i'
autocmd FileType perl let g:AutoComplPop_CompleteOption = '.,w,b,u,t,k~/.vim/dict/perl.dict'
"let g:AutoComplPop_IgnoreCaseOption = 1

" �ݥåץ��åץ�˥塼�Υ��顼������
hi Pmenu guibg=#666677
hi PmenuSel guibg=#8cd0d3 guifg=#556666
hi PmenuSbar guibg=#333333

" �����ȤΥ����ȥ���ǥ�Ȥ򤷤ʤ�
" http://d.hatena.ne.jp/dayflower/20081208/1228725403
if has("autocmd")
  autocmd FileType *
  \ let &l:comments
        \=join(filter(split(&l:comments, ','), 'v:val =~ "^[sme]"'), ',')
endif


"-----------------------------------------------------------------------------
" ʸ�������ɴ�Ϣ
"
if &encoding !=# 'utf-8'
	set encoding=japan
	set fileencoding=japan
endif
if has('iconv')
	let s:enc_euc = 'euc-jp'
	let s:enc_jis = 'iso-2022-jp'
	" iconv��eucJP-ms���б����Ƥ��뤫������å�
	if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'eucjp-ms'
		let s:enc_jis = 'iso-2022-jp-3'
	" iconv��JISX0213���б����Ƥ��뤫������å�
	elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'euc-jisx0213'
		let s:enc_jis = 'iso-2022-jp-3'
	endif
	" fileencodings����
	if &encoding ==# 'utf-8'
		let s:fileencodings_default = &fileencodings
		let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
		let &fileencodings = &fileencodings .','. s:fileencodings_default
		unlet s:fileencodings_default
	else
		let &fileencodings = &fileencodings .','. s:enc_jis
		set fileencodings+=utf-8,ucs-2le,ucs-2
		if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
			set fileencodings+=cp932
			set fileencodings-=euc-jp
			set fileencodings-=euc-jisx0213
			set fileencodings-=eucjp-ms
			let &encoding = s:enc_euc
			let &fileencoding = s:enc_euc
		else
			let &fileencodings = &fileencodings .','. s:enc_euc
		endif
	endif
	" ������ʬ
	unlet s:enc_euc
	unlet s:enc_jis
endif
" ���ܸ��ޤޤʤ����� fileencoding �� encoding ��Ȥ��褦�ˤ���
if has('autocmd')
	function! AU_ReCheck_FENC()
		if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
			let &fileencoding=&encoding
		endif
	endfunction
	autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" ���ԥ����ɤμ�ưǧ��
set fileformats=unix,dos,mac
" ���Ȥ�����ʸ�������äƤ⥫��������֤�����ʤ��褦�ˤ���
if exists('&ambiwidth')
	set ambiwidth=double
endif

"-----------------------------------------------------------------------------
" �Խ���Ϣ
"
"�����ȥ���ǥ�Ȥ���
"set autoindent
set smartindent " AutoIndent ���⸭������ǥ��

"�Х��ʥ��Խ�(xxd)�⡼�ɡ�vim -b �Ǥε�ư���⤷���� *.bin ��ȯư���ޤ���
augroup BinaryXXD
	autocmd!
	autocmd BufReadPre  *.bin let &binary =1
	autocmd BufReadPost * if &binary | silent %!xxd -g 1
	autocmd BufReadPost * set ft=xxd | endif
	autocmd BufWritePre * if &binary | %!xxd -r | endif
	autocmd BufWritePost * if &binary | silent %!xxd -g 1
	autocmd BufWritePost * set nomod | endif
augroup END

"��������ޡ�����
set scrolloff=9
" �Хå����ڡ����ζ���
set backspace=indent,eol,start "eol:����,start:���ϥ⡼�ɤ���������ʸ��


"-----------------------------------------------------------------------------
" ������Ϣ
"
"����ʸ���󤬾�ʸ���ξ�����ʸ����ʸ������̤ʤ���������
set ignorecase
"����ʸ�������ʸ�����ޤޤ�Ƥ�����϶��̤��Ƹ�������
set smartcase
"�������˺Ǹ�ޤǹԤä���ǽ�����
set wrapscan
"����ʸ�������ϻ��˽缡�о�ʸ����˥ҥåȤ����ʤ�
"set noincsearch
set incsearch	" ���󥯥��󥿥륵������ͭ���ˤ���

"-----------------------------------------------------------------------------
" ������Ϣ
"
"���󥿥å����ϥ��饤�Ȥ�ͭ���ˤ���
if has("syntax")
	syntax on
endif
"���ֹ��ɽ�����ʤ�
set nonumber
"��������ɽ��
set cursorline
"���֤κ�¦�˥�������ɽ��
"set listchars=tab:\ \ 
"set list
"�����������ꤹ��
set tabstop=4
set shiftwidth=4
"������Υ��ޥ�ɤ򥹥ơ�������ɽ������
set showcmd
"������ϻ����б������̤�ɽ��
set showmatch
"�������ʸ����Υϥ��饤�Ȥ�ͭ���ˤ���
set hlsearch
"���ơ������饤�����ɽ��
set laststatus=2
"���ơ������饤���ʸ�������ɤȲ���ʸ����ɽ������
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
"����ʸ�������ѥ��ڡ�����ɽ��$
set list
set lcs=tab:>.,trail:_,extends:\
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
au BufRead,BufNew * match JpSpace /��/

""�����ȹԤ�ʸ����
"function! CurrentLineLength()
"  let len = strlen(getline("."))
"  return len
"endfunction

"-----------------------------------------------------------------------------
" �ޥå����
"
"�Хåե���ư�ѥ����ޥå�
" F2: ���ΥХåե�
" F3: ���ΥХåե�
" F4: �Хåե����
map <F2> <ESC>:bp<CR>
map <F3> <ESC>:bn<CR>
map <F4> <ESC>:bw<CR>
"ɽ����ñ�̤ǹ԰�ư����
nnoremap j gjzz
nnoremap k gkzz
""�ե졼�ॵ���������Ƥ��ѹ�����
"map <kPlus> <C-W>+
"map <kMinus> <C-W>-

"window���
nnoremap wh <C-w>h
nnoremap wj <C-w>j
nnoremap wk <C-w>k
nnoremap wl <C-w>l
 
"Tab���
nnoremap tn :<C-u>tabnew<Cr>
nnoremap th :<C-u>tabprev<Cr>
nnoremap tl :<C-u>tabnext<Cr>
nnoremap tc :<C-u>tabclose<Cr>
 
"Window �ե졼�ॵ����
nnoremap + 4<C-w>+
nnoremap - 4<C-w>-
nnoremap { 4<C-w><
nnoremap } 4<C-w>>
 
