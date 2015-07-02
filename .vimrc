"b8 プラグイン設定
" NeoBundle が無ければインストール
if !isdirectory(expand('~/.vim/bundle'))
    !mkdir -p ~/.vim/bundle
    !git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
    source ~/.vimrc
    NeoBundleInstall
    q
endif
" Vim 起動時のみ実行
if has('vim_starting')
    " bundle で管理するディレクトリを設定
    set runtimepath+=$HOME/.vim/bundle/neobundle.vim
    " NeoBundle の初期化関数を呼び出し
    call neobundle#begin(expand('~/.vim/bundle'))
    " NeoBundle 自体を NeoBundle で管理
    NeoBundleFetch 'Shougo/neobundle.vim'

    " 以下に追加したいプラグインを記述
    " Vim上でデータを操作するためのインターフェース
    NeoBundle 'Shougo/unite.vim'
    " Vim上で閲覧可能なファイラー（Shougo/unite.vimと依存関係有り）
    NeoBundle 'Shougo/vimfiler.vim'
    " 入力補完
    NeoBundle has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'
    " Python用入力補完
    NeoBundle 'davidhalter/jedi-vim'
    " Vimproc（非同期処理を実現するプラグイン：重たい処理実施時にVimがフリーズしない様にします）
    NeoBundle 'Shougo/vimproc.vim', {
        \ 'build' : {
            \ 'windows' : 'make -f make_mingw32.mak',
            \ 'cygwin' : 'make -f make_cygwin.mak',
            \ 'mac' : 'make -f make_mac.mak',
            \ 'unix' : 'make -f make_unix.mak',
        \ },
    \ }
    " Uniteを利用してカラースキーム一覧表示を行う(:Unite colorscheme -auto-preview)
    NeoBundle 'ujihisa/unite-colorscheme'

    " 以下カラースキーム
    " olarized カラースキーム
    NeoBundle 'altercation/vim-colors-solarized'
    " mustang カラースキーム
    NeoBundle 'croaker/mustang-vim'
    " wombat カラースキーム
    NeoBundle 'jeffreyiacono/vim-colors-wombat'
    " jellybeans カラースキーム
    NeoBundle 'nanotech/jellybeans.vim'
    " lucius カラースキーム
    NeoBundle 'vim-scripts/Lucius'
    " zenburn カラースキーム
    NeoBundle 'vim-scripts/Zenburn'
    " mrkn256 カラースキーム
    NeoBundle 'mrkn/mrkn256.vim'
    " railscasts カラースキーム
    NeoBundle 'jpo/vim-railscasts-theme'
    " pyte カラースキーム
    NeoBundle 'therubymug/vim-pyte'
    " molokai カラースキーム
    NeoBundle 'tomasr/molokai'

    " NeoBundleを終了
    call neobundle#end()
    " 未インストールのプラグインがないかチェックを実行
    NeoBundleCheck
endif

" Filerの設定
" Vim標準ファイラを置き換え
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_defaul = 0

" 入力補完設定
if neobundle#is_installed('neocomplete')
    " NeoComplete用設定
    " Neocompleteを有効化
    let g:neocomplete#enable_at_startup = 1
    " 補完が自動で開始される文字数
    let g:neocomplete#auto_completion_start_length = 3
    " Smart caseを有効化（大文字が入力されるまで，大文字小文字の区別を考慮しない）
    let g:neocomplete#enable_smart_case = 1
    " camle caseを有効化（大文字を区切りとしたワイルドカードのように振る舞う）
    let g:neocomplete#enable_camel_case_completion = 1
    " アンダーバー区切りの補完を有効化
    let g:neocomplete#enable_underbar_completion = 1
    " シンタックスをキャッシュするときの最大文字長を10に設定
    let g:neocomplete#min_syntax_length = 10
    " neocomplete を自動的にロックするバッファ名のパターン
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
    " ハイフンの入力による候補番号の標示
    let g:neocomplete#enable_quick_match = 1
    " 提示される候補の最大数（初期値：100）
    let g:neocomplete#max_list = 5
    " 補完候補提示の際に先頭を選択状態へ
    let g:neocomplete#enable_auto_select = 1
    let g:neocomplete#enable_ignore_case = 0
    " 辞書ファイルの定義
    let g:neocomplete#dictionary_filetype_lists = {}

    " jedi-vimの設定
    autocm FileType python setlocal omnifunc=jedi#completions completeopt-=preview
    let g:jedi#completions_enabled = 0
    let g:jedi#auto_vim_configuration = 0
    if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
    endif
    let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
    
    " キーワードの定義
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns._ = '\h\w*'

    " Neocomplete のキーマップ
    " tabキーで次の検索候補を選択
    inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    " S-tabキーで前の検索候補を選択
    inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    " 選択されている候補をEnterキーで入力
    inoremap <expr><CR> pumvisible() ? neocomplete#close_popup() : "\<CR>"

elseif neobundle#is_installed('neocomplcache')
    " NeoComplcache用設定
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_ignore_case = 1
    let g:neocomplcache_enable_smart_case = 1
    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns._ = '\h\w*'
    let g:neocomplcache_enable_camel_case_completion = 1
    let g:neocomplcache_enable_underbar_completion = 1
endif

" キーマップ設定
" 文字列検索後のハイライトを解除
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<cr><Esc>
" 行の先頭へ移動
noremap <C-a> ^
" 行の末尾へ移動
noremap <C-e> $
" Filerのキーバインド（<silent> をコマンド前につけると，実行されるコマンドがコンソールに非表示になる）
noremap <silent> <C-o><C-o> :VimFiler -split -simple -winwidth=35 -toggle -no-quit<ENTER>

" 環境設定
" バックスペースキーを有効化
set backspace=indent,eol,start
" タブの文字数
set tabstop=4
" タブを複数のスペースに置き換え
set expandtab
" 改行時に前行のインデントを継続
set autoindent
" 改行時に入力された行の末尾にあわせて次の行のインデントを増減
set smartindent
" 自動インデントした際のズレ幅
set shiftwidth=4
" 文字コード設定（UTF-8）
set encoding=utf-8
" 文字コードの自動判定
set fileencodings=utf-8,iso-2022-jp,sjis,euc-jp
" 改行コード設定（UNIX）
set ff=unix
" 改行コードの自動判別
set fileformats=unix,dos,mac
" 行番号標示
set number
" マウス入力を有効化
set mouse=a
" TERM環境変数の値
set ttymouse=xterm2
" インクリメンタルサーチを有効化
set incsearch
" 検索結果をハイライト表示
set hlsearch
" 対応する括弧のハイライト表示
set showmatch
" バッファの変更を有効化
set modifiable
" ファイルの書き込みを有効化
set write
" タブ文字，行末など不可視文字を可視化
set list
"タブと改行を指定文字で可視化
set listchars=tab:»\ ,eol:¶
" ステータスラインを表示するウィンドウを設定
set laststatus=2
" コマンドをステータスラインに標示
set showcmd
" 現在のモードを標示
set showmode
" 編集中のファイル名を標示
set title
" カーソルが置かれている行と列を標示
set ruler
" テキスト標示の方法を変更
set display=lastline
" クリップボードの動作設定
set clipboard=unnamedplus,unnamed,autoselect
" バックアップファイルを作成しない
set nobackup
" 書込前にバックアップを作成し，書込成功後削除
set writebackup
" 挿入モード中のみ編集中の行をハイライト表示
au InsertEnter,InsertLeave * set cursorline!
" 挿入モード中のみ編集中の行番号をハイライト標示
hi CursorLineNr term=bold   cterm=NONE ctermfg=228 ctermbg=NONE
" ファイル形式の自動検出
filetype plugin indent on
" シンタックスカラーを有効化
syntax on
" カラー設定を256階調で設定
set t_Co=256
" カラースキーマを設定(:Unite colorscheme -auto-preview => 良さそうなのを選ぶ)
colorscheme molokai

" 全角スペースを標示
function! ZnkakSpace()
    highlight ZnkakSpace cterm=underline ctermfg=grey gui=underline guifg=grey
endfunction

if has('syntax')
    augroup ZnkakSpace
        autocmd!
        " ZnkakSpaceをカラーファイルで設定するなら次の行は削除
        autocmd ColorScheme * call ZnkakSpace()
        " 全角スペースのハイライト指定
        autocmd VimEnter,WinEnter * match ZnkakSpace /　/
        autocmd VimEnter,WinEnter * match ZnkakSpace '\%u3000'
    augroup END
    call ZnkakSpace()
endif

" バイナリ編集（xxd）モード（vim -b で起動，もしくは *.bin ファイルを開くと起動）
augroup Binary
    au!
    au BufReadPre   *.bin let &bin=1
    au BufReadPost  * if &bin | silent %!xxd -g 1
    au BufReadPost  * set filetype=xxd | endif
    au BufWritePre  * if &bin | %!xxd -r
    au BufWritePost * if &bin | silent %!xxd -g 1
    au BufWritePost * set nomod | endif
augroup END
