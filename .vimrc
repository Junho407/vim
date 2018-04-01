set nocompatible    "be iMproved, required
filetype off        "required
"map <f9> :Tlist<CR>
" set the runtime path to include Vundle and initialize

filetype plugin indent on    "required

function! RunShell(Msg, Shell)
    echo a:Msg.'...'
    call system(a:Shell)
    echo 'done'
endfunction


call te#feat#feat_enable('g:feat_enable_basic', 1)
call te#feat#feat_enable('g:feat_enable_airline', 1)
call te#feat#feat_enable('g:feat_enable_gui', 1)

"" set leader key <leader>
let mapleader = "\<Space>"
" [ PLUGINS    ] =================================================
" pathogen ----------------------------------------------------{{{2
execute pathogen#infect()
filetype plugin indent on " required
" Source Explorer(srcExpl) ------------------------------------{{{2
" Tagbar  -----------------------------------------------------{{{2
nmap <F8> :TagbarToggle<CR>
" Taglist  ----------------------------------------------------{{{2
nnoremap <F3> :TlistToggle<CR>
"  Nerdtree ---------------------------------------------------{{{2
nnoremap <F2> :NERDTreeToggle<CR>
" " Generate filename tags ------------------------------------{{{2
nmap <F9>  :call RunShell("Generate tags", "ctags -R --c++-kinds=+p --fields=+iaS --extra=+q.")<cr>
nmap <F11> :call RunShell("Generate cscope file and lookup filename tags", "gencscope.sh && genfiletags.sh")<cr>
" Lookupfile  ----------------------------------------------------{{{2
let g:LookupFile_MinPatLength = 2
let g:LookupFile_PreserveLastPattern = 0
let g:LookupFile_PreservePatternHistory = 1
let g:LookupFile_AlwaysAcceptFirst = 1
let g:LookupFile_AllowNewFiles = 0
if filereadable("./filenametags" )
    let g:LookupFile_TagExpr = '"./filenametags"'
endif
nmap <silent><leader>lk :LUTags<cr>
nmap <silent><leader>ll :LUBufs<cr>
nmap <silent><leader>lw :LUWalk<cr>

" Airline -----------------------------------------------------{{{2
set laststatus=0
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts = 1
" enable tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#bufer_nr_show = 0 " Show bufer number
let g:airline#extensions#tabline#fnametruncate = 16 " Show bufer number
let g:airline#extensions#tabline#fnamecollapse = 2  " Show bufer number
let g:airline#extensions#tabline#buffer_idx_mode = 1 "  * enable/disable displaying index of the buffer.
nmap <Leader>p <Plug>AirlineSelectPrevTab       
nmap <Leader>n <Plug>AirlineSelectNextTab       

" Set left separator which are not editting
let g:airline#extensions#tabline#left_alt_sep = '' 
let g:airline#extensions#tabline#right_alt_sep = '' 
let g:airline#extensions#tagbar#enabled = 1
"* change how tags are displayed (:help tagbar-statusline) > 
"let g:airline#extensions#tagbar#flags = ''  (default)
"let g:airline#extensions#tagbar#flags = 'f'
"let g:airline#extensions#tagbar#flags = 's'
"let g:airline#extensions#tagbar#flags = 'p'

"* enable/disable detection of whitespace errors. >      
"let g:airline#extensions#whitespace#enabled = 1

" Set left separator
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#right_sep = ''
" the separator used on the left side
let g:airline_left_sep='▶'
" the separator used on the right side
let g:airline_right_sep='◀'
" themes are automatically selected based on the matching colorscheme. this
" can be overridden by defining a value
" Always show the status line
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h24 "config font for vim
"set guifont=Meslo\ LG\ S\ Regular\ for\ Powerline:h28 "config font for vim
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

function! te#utils#tab_buf_switch(num) abort
    if exists('g:feat_enable_airline') && g:feat_enable_airline == 1
        execute 'normal '."\<Plug>AirlineSelectTab".a:num
    else
        if exists( '*tabpagenr' ) && tabpagenr('$') != 1
            Tab support && tabs open
            execute 'normal '.a:num.'gt'
        else
            let l:temp=a:num
            let l:buf_index=a:num
            let l:buf_count=len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
            if l:temp > l:buf_count
                return
            endif
            while l:buf_index != 0
                while !buflisted(l:temp)
                    let l:temp += 1
                endw
                let l:buf_index -= 1
                if l:buf_index != 0
                    let l:temp += 1
                endif
            endw
            execute ':'.l:temp.'b'
        endif
    endif
endfunction

"" Key binding
"" tab or buf 1
nnoremap <leader>1 :call te#utils#tab_buf_switch(1)<cr>
"" tab or buf 2
nnoremap <leader>2 :call te#utils#tab_buf_switch(2)<cr>
"" tab or buf 3
nnoremap <leader>3 :call te#utils#tab_buf_switch(3)<cr>
"" tab or buf 4
nnoremap <leader>4 :call te#utils#tab_buf_switch(4)<cr>
"" tab or buf 5
nnoremap <leader>5 :call te#utils#tab_buf_switch(5)<cr>
"" tab or buf 6
nnoremap <leader>6 :call te#utils#tab_buf_switch(6)<cr>
"" tab or buf 7
nnoremap <leader>7 :call te#utils#tab_buf_switch(7)<cr>
"" tab or buf 8
nnoremap <leader>8 :call te#utils#tab_buf_switch(8)<cr>
"" tab or buf 9
nnoremap <leader>9 :call te#utils#tab_buf_switch(9)<cr>

" tabline
" Always display tab page
"set showtabline=2
" GUI use pure text to display tab page
set guioptions-=m  " add menu bar
set guioptions+=l  " add menu bar
set guioptions+=b  " add menu bar
set guioptions-=T  " remove tool bar
set guioptions-=r  " remove right-hand scroll bar(Right of split window)
set guioptions-=R  " remove right-hand scroll bar
set guioptions-=l  " remove left-hand scroll bar(Left of split windows)
set guioptions-=L  " remove left-hand scroll bar
set guioptions-=e  " add Tab-page
" Colorscheme -------------------------------------------------{{{2
" Colorscheme 1: [Papercolor]
set t_Co=256   " This is may or may not need
set background=dark
colorscheme PaperColor

" [seoul256(dark)]
" Range: 233 (darkest) ~ 239 (lightest)
" Default: 237
let g:seoul256_background = 235
colorscheme seoul256

" Colorscheme 2:[seould256(light)]
" Range: 252(darkest) ~ 256 (lightest)
" Default: 253
let g:seoul256_light_background = 252
colorscheme seoul256-light

" switch background mode
set background=dark

" ,q - close document
nnoremap <Leader>q :q!<CR>
" ,s - Save document
nnoremap <Leader>s :w<CR>
" ,o - Open new document
nnoremap <Leader>o :CtrlP<CR>a

" [ VIM EDITOR ] ==============================================
syntax on
set ruler
set showmode
" show line number
set nu
set hlsearch
set smartindent
" tabstop size 
set tabstop=4
" Acknowledge C or Java language and use C format to process indent >> <<
set cindent shiftwidth=4
" use space to replace when using tab key
set expandtab
set nowrap
set ut=100

if has("autocmd")
        filetype on
        autocmd Filetype html,aspvbs,javascript,xml setlocal ts=2 sts=2 sw=2 expandtab
endif
set ic
set backspace=2
set history=100
" enable or disable mouse use
nnoremap <F6> :call ToggleMouse() <CR>
function! ToggleMouse()
       if &mouse == 'a'
           set mouse=
           set nonumber
           echo "Mouse usage disabled"
       else
           set mouse=a
           set number
           echo "Mouse usage enabled"
       endif
endfunction
"" search result at center
nnoremap N nzz
nnoremap n nzz
"" ESC mapping
inoremap jk <ESC>
"" tab switch
nnoremap <C-h> gT
nnoremap <C-l> gt
"" adjust window size
nnoremap + <C-W>+
nnoremap - <C-W>-
nnoremap <RIGHT> <C-W><
nnoremap <LEFT> <C-W>>


" map hotkey ciw <C-R> 0 <Esc> replace the word and press '.' to repeat 
map <leader>rr ciw<C-r>0<Esc>
set cscopetag
set csto=0

set cscopeverbose
myvim_config.tar.gz                                                                                 0000664 0001765 0001765 00000005274 13257727014 015045  0                                                                                                    ustar   junho.wu                        junho.wu                                                                                                                                                                                                               � ��Z �Y�n�:�o?�T]Tv��S'�覗�ݤ'HҞma�m��E����.�)v�dh�dgHɒ/���,��9��p8�P���_�$��i��uOT��n[�vw�����n��k�;[�wڝ����^����� ��hEV�L� 6��n���i��@"9I����6o�!>J����&(�-�k�Xps�r���͛�z����E�g"�f��_��M�Ae��'PLFB�"9|̒��$Į��L��y����l'8�ĀL��FY�X&�$KN#.D�H�7�>6jD̓H�bw�o�Z�������:�.R��L�_�IX��j5�b��g���������[y����fa�1J��8�C�sf��\�9��}�ܯ�&��y�4e�{�6������w�Oi�_�w׆��r�h�D���G��/y�>Cz'#�z��J���Tf*���2RqU�*��ƭT�*xp��C�?3��X���߂���X�|`퉟������Sl�9��(�FƢ�6�x������I��-O�b�`�<	�-m�X��ع�0N@׺�l�z3hB�6��	��s� ��H�usA�1;�7~i�m|ky�� �>���ݿ^F���Y��#�<���Y�蒎��#x���:&cO.ЃC�n�~~�i����B��䘙C��1j�`ű⚫~ȴAR�U��[��D���Hu���˴/Ŕ]�A�S�&V�א	9}ϧ����xd�0�ؐ嵞��d��p��� �/��0��5�4d�E|��=��ܺ��4�h���n���oL�[\ϗ.$���`C2�
�&ӽbI�X?�Cq�{~*��v�:�Hfc��L�������C�gy�;�',�('x�����@���Dl�E���I6r��[Gr:p�7�jb��V>K�o���_�:�F\��$��u=�G;pk�G��0;	((�һ�'�B�TN~�i^qx9�ȰXx�/��0�v��7�*N��\�Ĥ��Y������so|:�3��;�)x�b@�8��um�!Y��խ0��k�����#eU��i0�1�4����q��	f�� 9��yT<���D���n�@�d́�ɞ5�xnZ$�w��H��6�F&����5�hՂz�G,�q��b}�ԯ��]�n�]�%\G�5�����J�p�nᯗS2��y����%����7��=�J��4j�s�^�I.D�A!�������J[�1SA���dk��Hx1%%W�L�
1�d(�q<�h_c4A���X#V���+3���a^��vBLd��/{����v�w��t0a�@gJ���>f��%�3�D~ʟ�8{�Q�fb��1��E<�yU�#���E��p�Ǚ`j���X�8<䗘�h*s
[��P
�W���1\��S�J5��Sfba�c�1q��1���a�l(���(����"kؔo��K��E\T1~B'� ����r���X�pŦ�|Q��T;e�j*�
����'T�aU65��:KS�XN�s�d�hYI�J���IU��좋�r�+5�$�S�F�@f�(�w�1��3��(�ַ7���g��ߨ��a�������9D4��#Ry����&S�~R������2����#{X��4h,�[6*�b�Թ`Ih��S_��-5X�ÒN3g��-��7�!����σ��+��t�{.�ĭ���6e�����y�vݮ�Ϋ�9��2N{N{��2����U8ϖq���y�
����Y��Y������gw��2����U8ϗq���y�
��2΋58/EYWTM�2O�� ���T�s3'��������4�C�`�AW�K��y(S��ٛP��&<��W=��b����;{6�� ��b%����ѥ��,�Q?�	f~8������6��N�-q�
%XK�)[��%��Yb����pl����2��{i�_V1���阥\�d���d�����y�	:
:0�Pa�pZ�!��
ϯ�2u^�$}`��4r�O��L n�_���.�wv�vrm�w|uA�CH��D����ؠT��֝ΜUma����&$u��9}:�9u�ר��YT��-(�i�T�iiI5��+���W��7�A!q?�2�pc�JH�+�o���0�����p�.n��Н����Wyz���Q�ؘ]a���^�zw��ɝ��k�*1��;o�	��2kϕ6yͯ#�ן��D��1D�gq��.hj#S�v�sp.�zz�(�牜b��u���_����ឳw�:�]�P�L���ō~���7�{t��4MdE��E�Yq���8�����"�9���2E���&'����13������u�j�`zeW~�*�Ɯ
�c���M�Ӌ����3� �f�r"�#��x�ѽ6�\����:�d�ԉ��ک�܍a��e����>4jQ�O$�W��w�{nwWD4�X,k���b�h���������c���D�TM�˙w��GK��z�bmQ
`Kn���1��K���2F^�^�1� �_���3�����5������>��������s�ǁYN�"Oe-�Q�gs={q��k��#�n��n�(�o�=M�Ӭ`��{��Y���W#��7E7�9�8�IC��xJ#'}�B�uП� ��J�=�*ڑ~���V�P�&YJ"����q;�~1l����=V�\p5�H[�_�o���ݷ�v��[����� (                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      