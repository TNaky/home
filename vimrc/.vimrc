" Vimの設定ファイル(.vimrc)
" author  : TNak
" since   : 2015.04.01

" 諸注意
" *1
"   基本的にNeoCompleteの利用を想定しているので，luaに対応したver.7.3以上のVimを使ってね
"   Mac環境でbrewを使ってインストールする方法は，githubのREADMEに書いてあるよ
" *2
"   ステータスラインでPowerline Fontを利用することを前提にしているので，
"   Powerlineのパッチを当てたフォントを，Mac環境ならTerminalなりiTermなりに設定してね
"   iTermの場合は
"   Preferences > Profiles > Text
"   のRegular FontとNon-ASCII Fontから設定できるよ
"   Regular FontのFontSizeをNon-ASCII Fontより2point大きく設定するといい感じのバランス
"   おすすめのフォントはPowerline for ricty
"   Mac環境なら
"   $ brew tap sanemat/font
"   $ brew install --powerline --vim-powerline ricty
"   でダウンロードできるから，インストールしてみて
" *3
"   memolistで作成したメモのデータは，デフォルト設定だと'$HOME/.vim/memolists/'に格納されるよ
"   変更したい場合は，g:memolist_pathに設定するディレクトリパスを変えてね

" プラグイン設定
" NeoBundle が無ければインストール
if !isdirectory(expand('$HOME/.vim/bundle'))
  call system('mkdir -p $HOME/.vim/bundle')
  call system('git clone https://github.com/Shougo/neobundle.vim.git $HOME/.vim/bundle/neobundle.vim')
  source $HOME/.vimrc
  NeoBundleInstall
  q
endif

" Vim 起動時のみ実行
if has('vim_starting')
  " neobundle で管理するディレクトリを設定
  set runtimepath+=$HOME/.vim/bundle/neobundle.vim
  " NeoBundle の初期化関数を呼び出し
  call neobundle#begin(expand('~/.vim/bundle'))
  " NeoBundle 自体を NeoBundle で管理
  NeoBundleFetch 'Shougo/neobundle.vim'

  " 以下に追加したいプラグインを記述
  " Vimのドキュメントが日本語化される神プラグイン
  NeoBundle 'vim-jp/vimdoc-ja'
  " Vim上でデータを操作するためのインターフェース
  NeoBundle 'Shougo/unite.vim'
  " Vimで開いたファイル履歴を記録
  NeoBundle 'Shougo/neomru.vim', {
    \ 'depends' : 'Shougo/unite.vim'
  \ }
  " Vim上で閲覧可能なファイラー（Shougo/unite.vimと依存関係有り）
  NeoBundle 'Shougo/vimfiler.vim'
  " Vimproc（非同期処理を実現するプラグイン：重たい処理実施時にVimがフリーズしない様にします）
  NeoBundle 'Shougo/vimproc.vim', {
    \ 'build' : {
      \ 'windows' : 'make -f make_mingw32.mak',
      \ 'cygwin' : 'make -f make_cygwin.mak',
      \ 'mac' : 'make -f make_mac.mak',
      \ 'unix' : 'make -f make_unix.mak',
    \ },
  \ }
  " 入力補完
  if has('lua')
    " luaインタプリタがある場合はNeoCompleteがインストールされるよ
    " NeoCompleteはNeoComplcacheの新しいバージョンだよ
    " NeoComplcacheと比較して高速化等がなされてるらしいよ
    NeoBundle 'Shougo/neocomplete.vim', {
      \ 'depends' : 'Shougo/vimproc.vim',
      \ 'autoload' : { 'insert' : 1,}
    \ }
  else
    " luaインタプリタが無い場合はNeoComplcacheがインストールされるよ
    " NeoComplcacheはNeoCompleteの古いバージョンだよ
    NeoBundle 'Shougo/neocomplcache.vim'
  endif
  " Python用入力補完
  NeoBundle 'davidhalter/jedi-vim'
  " スニペット補完プラグイン
  NeoBundle 'Shougo/neosnippet'
  " 各種スニペット
  NeoBundle 'Shougo/neosnippet-snippets'
  " 構文チェックをしてくれまする
  NeoBundle 'scrooloose/syntastic.git'
  " Uniteを利用してカラースキーム一覧表示を行う(:Unite colorscheme -auto-preview)
  NeoBundle 'ujihisa/unite-colorscheme'
  " タグジャンプに必要なtagファイルってのを自動生成してくれる良い奴
  NeoBundle 'soramugi/auto-ctags.vim'
  " メモ帳的なやつ
  NeoBundle 'glidenote/memolist.vim'
  " 絞り込み検索をしてくれる頼れるやつだよ
  NeoBundle 'fuenor/qfixgrep'
  " Vimの中でスクリプトを実行するよ
  NeoBundle 'thinca/vim-quickrun', {
    \ 'autoload' : {
      \ 'mappings' : [['n', '\r']],
      \ 'commands' : ['QuickRun']
    \ }
  \ }
  " QuickRunの出力結果を吐き出す場所
  NeoBundle "osyo-manga/unite-quickfix"
  " QuickRun実行中に，ほんとに実行してるの？ってならないようにするアニメーション
  NeoBundle 'osyo-manga/shabadou.vim'
  " Git
  NeoBundle 'tpope/vim-fugitive'
  " Gitの差分を教えてくれるやつ
  NeoBundle 'airblade/vim-gitgutter'
  " Powerline化
  NeoBundle 'itchyny/lightline.vim'
  " VimScriptで作ってあるshell
  NeoBundle 'Shougo/vimshell', {
    \ 'depends' : 'Shougo/vimproc.vim',
    \ 'autoload' : {
      \ 'commands' : [
        \ { 'name' : 'VimShell', 'complete' : 'customlist,vimshell#complete'},
        \ 'VimShellExecute', 'VimShellInteractive',
        \ 'VimShellTerminal', 'VimShellPop'
      \ ],
      \ 'mappings' : ['<Plug>(vimshell_switch)']
    \ }
  \ }
  " VimShellでssh
  NeoBundle 'ujihisa/vimshell-ssh'
  " コメントアウトをしてくれるよ
  NeoBundle 'tomtom/tcomment_vim'
  " LaTeXの文書作成支援プラグイン
  NeoBundle 'lervag/vim-latex'
  " ブラウザ開くよ(GUIが無いと駄目だよ)
  NeoBundle 'open-browser.vim'
  " markdown記法をゴニョゴニョしてくれる
  NeoBundle 'plasticboy/vim-markdown'
  " Processing のシンタックスハイライト＆リファレンス参照用
  NeoBundle 'sophacles/vim-processing'

  " 以下カラースキーム
  " olarized カラースキーム
  NeoBundleLazy 'altercation/vim-colors-solarized'
  " mustang カラースキーム
  NeoBundleLazy 'croaker/mustang-vim'
  " wombat カラースキーム
  NeoBundleLazy 'jeffreyiacono/vim-colors-wombat'
  " jellybeans カラースキーム
  NeoBundleLazy 'nanotech/jellybeans.vim'
  " lucius カラースキーム
  NeoBundleLazy 'vim-scripts/Lucius'
  " zenburn カラースキーム
  NeoBundleLazy 'vim-scripts/Zenburn'
  " mrkn256 カラースキーム
  NeoBundleLazy 'mrkn/mrkn256.vim'
  " railscasts カラースキーム
  NeoBundleLazy 'jpo/vim-railscasts-theme'
  " pyte カラースキーム
  NeoBundleLazy 'therubymug/vim-pyte'
  " molokai カラースキーム
  NeoBundle 'tomasr/molokai'
  " Hybiridカラースキーム
  NeoBundleLazy 'w0ng/vim-hybrid'

  " NeoBundleを終了
  call neobundle#end()
  " 未インストールのプラグインがないかチェックを実行
  NeoBundleCheck
endif

" Filerの設定
" Vim標準ファイラを置き換え
let g:vimfiler_as_default_explorer = 1
" Tree状にディレクトリを展開した際にずれるスペース
let g:vimfiler_tree_indentation = 2
" 開いたファイルのディレクトリへVimのカレントディレクトリを自動移動
let g:vimfiler_enable_auto_cd = 1

" 入力補完設定
if neobundle#is_installed('neocomplete.vim')
  " NeoComplete用設定
  " Neocompleteを有効化
  let g:neocomplete#enable_at_startup = 1
  " 補完が自動で開始される文字数
  let g:neocomplete#auto_completion_start_length = 1
  " Smart caseを有効化（大文字が入力されるまで，大文字小文字の区別を考慮しない）
  let g:neocomplete#enable_smart_case = 1
  " camle caseを有効化（大文字を区切りとしたワイルドカードのように振る舞う）
  let g:neocomplete#enable_camel_case_completion = 1
  " アンダーバー区切りの補完を有効化
  let g:neocomplete#enable_underbar_completion = 1
  " シンタックスをキャッシュするときの最大文字長を25に設定
  let g:neocomplete#min_syntax_length = 25
  " neocomplete を自動的にロックするバッファ名のパターン
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
  " ハイフンの入力による候補番号の標示
  let g:neocomplete#enable_quick_match = 1
  " 提示される候補の最大数（初期値：100）
  let g:neocomplete#max_list = 5
  " 補完候補提示の際に先頭を選択状態へ
  let g:neocomplete#enable_auto_select = 1
  " 補完（小文字を無視して検索）
  let g:neocomplete#enable_refresh_always = 1
  " 辞書ファイルの定義
  let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
  \ }
  " キーワードの定義
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns._ = '\h\w*'

  " jedi-vimの設定
  autocm FileType python setlocal omnifunc=jedi#completions completeopt-=preview
  let g:jedi#completions_enabled = 0
  let g:jedi#auto_vim_configuration = 0
  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

elseif neobundle#is_installed('neocomplcache')
  " NeoComplcache用設定
  let g:neocomplcache_enable_at_startup = 1
  let g:neocomplcache_enable_ignore_case = 1
  let g:neocomplcache_enable_smart_case = 1
  if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}e*
  endif
  let g:neocomplcache_keyword_patterns._ = '\h\w*'
  let g:neocomplcache_enable_camel_case_completion = 1
  let g:neocomplcache_enable_underbar_completion = 1
endif

" NeoSnippetの設定
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" いわゆるタグジャンプについての設定(auto-ctagsの設定なわけだが)
" 読み込むタグファイルを設定
set tags+=tags;./**/tags
" ファイルの保存時にtagsファイルを作り直すよ(もともとtagsファイルが合った場合のみ）
if filereadable(expand('./tags'))
  let g:auto_ctags = 1
else
  let g:auto_ctags = 0
endif
" ctagsのオプションを設定してるよ
let g:auto_ctags_tags_args = '--tag-relative --recurse --sort=yes --edit_action'

" メモ帳の設定
" メモ帳を保存する場所
let g:memolist_path = expand('~/.vim/memolists')
" メモの形式
let g:memolist_memo_suffix = "md"
" メモ作成時にグループタグを設定
let g:memolist_prompt_tags = 1
" メモ作成時にカテゴリタグを設定
let g:memolist_prompt_categories = 1
" 検索にgfixgrepを使うよ
let g:memolist_gfixgrep = 1
" メモ表示にVimFiler使う
let g:memolist_vimfiler = 1
" メモを開くときにVimFilerに渡されるオプション
" -split : 画面を分割してVimFilerを表示
" -winwidth : VimFiler展開時のタブサイズ
let g:memolist_vimfiler_option = "-split -winwidth=30 -simple"
" メモ作成画面を別タブで表示する関数
function! MemoNew()
  :30vsplit
  :MemoNew
endfunction

if executable('ctags')
  " LaTeXでtexファイルからpdfを生成するコマンドを叩く際の設定ファイルが有るかどうか確認
  if !filereadable(expand('$HOME/.ctags'))
    " 設定ファイルが無い場合生成して，設定内容を書込
    :let outputfile = '$HOME/.ctags'
    :execute ':redir! > ' . outputfile
      :silent! echon "--sort=yes" . "\n"
      :silent! echon "--input-encoding=utf-8" . "\n"
      :silent! echon "--input-encoding-c=sjis" . "\n"
      :silent! echon "--input-encoding-vim=utf-8" . "\n"
      :silent! echon "--input-encoding-go=utf-8" . "\n"
    :redir END
  endif
endif

" QuickRunの設定
" QuickRun実行時に渡されるオプション群
let g:quickrun_config = {
  \ "_" : {
    \ "hook/unite_quickfix/enable_failure" : 1,
    \ "hook/close_unite_quickfix/enable_hook_loaded" : 1,
    \ "hook/close_quickfix/enable_exit" : 1,
    \ "hook/close_buffer/enable_failure" : 1,
    \ "hook/close_buffer/enable_empty_data" : 1,
    \ "hook/inu/enable" : 1,
    \ "hook/inu/wait" : 20,
    \ "outputter" : "multi:buffer:quickfix",
    \ "outputter/buffer/split" : ":botright 5sp",
    \ "runner" : "vimproc",
    \ "runner/vimproc/updatetime" : 30,
    \ }
  \ }

let g:quickrun_config.processing = {
  \ 'command': 'processing-java',
  \ 'exec': '%c --sketch=%s:p:h/ --output=/tmp/processing --run --force'
\ }

" Markdown記法関連の設定
au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = 'open -a Firefox'

" Syntasticの設定
" LaTeXでのチェックが厳しすぎるからOffに
let g:syntastic_ignore_files=['\.tex$']

" LaTeX作成支援
" latexmkがインストールされてるかどうか
if executable('latexmk')
  " LaTeXでtexファイルからpdfを生成するコマンドを叩く際の設定ファイルが有るかどうか確認
  if !filereadable(expand('$HOME/.latexmkrc'))
    " 設定ファイルが無い場合生成して，設定内容を書込
    :let outputfile = '$HOME/.latexmkrc'
    :execute ':redir! > ' . outputfile
      :silent! echon "$latex = 'platex -synctex=1 -halt-on-error';" . "\n"
      :silent! echon "$latex_silent = 'platex -synctex=1 -halt-on-error -interaction=batchmode';" . "\n"
      :silent! echon "$bibtex = 'pbibtex';" . "\n"
      :silent! echon "$dvipdf = 'dvipdfmx %O -o %D %S';" . "\n"
      :silent! echon "$makeindex = 'mendex %O -o %D %S';" . "\n"
      :silent! echon "$pdf_mode = 3;" . "\n"
      :silent! echon "$pvc_view_file_via_temporary = 0;" . "\n"
    :redir END
  endif
  
  " texファイルをQuickRunでコンパイルする際の設定
  let g:quickrun_config['tex'] = {
    \ 'command' : 'latexmk',
    \ 'outputter' : 'error',
    \ 'outputter/error/error' : 'quickfix',
    \ 'cmdopt': '-pdfdvi',
    \ 'exec': ['%c %o %s']
  \ }
endif
" Vim-latexの設定
let g:latex_fold_enabled = 0

" Graphvizをコンパイルする
if executable('dot')
  let g:quickrun_config['dot'] = {
    \ 'command' : 'dot',
    \ 'outputter' : 'error',
    \ 'outputter/error/error' : 'quickfix',
    \ 'cmdopt' : '-Tpdf -o ' . expand('%:r') . '.pdf',
  \ }
endif

" tcomment.vimの設定(編集すると，コメントアウトしてくれるファイルタイプが増やせます)
if !exists('g:tcomment_types')
  let g:tcomment_types = {}
endif

" vim-gitgutterの設定
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '➜'
let g:gitgutter_sign_removed = '✘'

" lightlineの設定
let g:lightline = {
  \ 'colorscheme' : 'powerline',
  \ 'mode_map': {'c': 'NORMAL'},
  \ 'active': {
    \ 'left': [
      \ [ 'mode', 'paste' ],
      \ [ 'fugitive', 'filename' ]
    \ ],
    \ 'right' : [
      \ ['lineinfo', 'syntastic'],
      \ ['percent'],
      \ ['charcode', 'fileformat', 'fileencoding', 'filetype'],
    \ ]
  \ },
  \ 'component_function': {
    \ 'modified': 'MyModified',
    \ 'readonly': 'MyReadonly',
    \ 'fugitive': 'MyFugitive',
    \ 'filename': 'MyFilename',
    \ 'fileformat': 'MyFileformat',
    \ 'filetype': 'MyFiletype',
    \ 'fileencoding': 'MyFileencoding',
    \ 'mode': 'MyMode',
    \ 'syntastic': 'SyntasticStatuslineFlag',
    \ 'charcode': 'MyCharCode',
    \ 'gitgutter': 'MyGitGutter',
  \ },
  \ 'separator': {'left': '⮀', 'right': '⮂'},
  \ 'subseparator': {'left': '⮁', 'right': '⮃'}
\ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &ro ? '⭤' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
    \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
    \  &ft == 'unite' ? unite#get_status_string() :
    \  &ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
    \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
    \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? '⭠ '._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth('.') > 60 ? lightline#mode() : ''
endfunction

function! MyGitGutter()
  if ! exists('*GitGutterGetHunkSummary') || ! get(g:, 'gitgutter_enabled', 0) || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
    \ g:gitgutter_sign_added . ' ',
    \ g:gitgutter_sign_modified . ' ',
    \ g:gitgutter_sign_removed . ' '
  \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

function! MyCharCode()
  if winwidth('.') <= 70
    return ''
  endif
  redir => ascii
  silent! ascii
  redir END
  if match(ascii, 'NUL') != -1
    return 'NUL'
  endif
  let nrformat = '0x%02x'
  let encoding = (&fenc == '' ? &enc : &fenc)
  if encoding == 'utf-8'
    let nrformat = '0x%04x'
  endif
  let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')
  let nr = printf(nrformat, nr)
  return "'". char ."' ". nr
endfunction

" キーマップ設定
" コマンド入力をセミコロンでも可
noremap ; :
" 文字列検索後のハイライトを解除
noremap <silent> <Esc><Esc> :<C-u>nohlsearch<Cr><Esc>
" 数値のインクリメント
nnoremap <C-i> <C-a>
" 数値のインクリメント
vnoremap <C-i> <C-a>gv
" 数値のデクリメント
vnoremap <C-x> <C-x>gv
" 行の先頭へ移動
noremap <C-a> ^
" 行の末尾へ移動
noremap <C-e> $
" 終了
nnoremap q :q<Cr>
" 終了
nnoremap qq :qa<Cr>
" 保存
nnoremap w :w<Cr>
" 画面を横分割
nnoremap <silent> <BAR> :vsplit<Cr>
" 画面を立て分割
nnoremap <silent> - :split<Cr>
" 上の画面へ移動
nnoremap <C-k> <C-w>k
" 下の画面へ移動
nnoremap <C-j> <C-w>j
" 右の画面へ移動
nnoremap <C-l> <C-w>l
" 左の画面へ移動
nnoremap <C-h> <C-w>h
" 上の画面と入れ替え
nnoremap wk <C-w>K
" 下の画面と入れ替え
nnoremap wj <C-w>J
" 右の画面と入れ替え
nnoremap wl <C-w>L
" 左の画面と入れ替え
nnoremap wh <C-w>H
" 画面幅を均等にします
nnoremap = <C-w>=
" 画面幅を増やします
nnoremap > <C-w>>
" 画面幅を減らします
nnoremap < <C-w><
" 画面の高さを上げます
nnoremap ^ <C-w>+
" 画面の高さを下げます(アンダーバーだぞ! ハイフンじゃないぞ!!）
nnoremap _ <C-w>-
" 新規タブを作成
nnoremap <C-t> :tabnew<Cr>
" 次のタブへ移動
nnoremap <C-n> gt
" 前のタブへ移動
nnoremap <C-p> gT
" 置換
noremap s :%s/
" Filerのキーバインド（<silent> をコマンド前につけると，実行されるコマンドがコンソールに非表示になる）
nnoremap <silent> ft :VimFilerTab<Cr>
" Filerのキーバインド（<silent> をコマンド前につけると，実行されるコマンドがコンソールに非表示になる）
nnoremap <silent> fo :VimFiler -split -winwidth=30 -simple -toggle<Cr>
" 入力補完のキーバインド
" tabキーで次の検索候補を選択
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" S-tabキーで前の検索候補を選択
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
if neobundle#is_installed('neocomplete.vim')
  " 選択されている候補をEnterキーで入力
  inoremap <expr><Cr> pumvisible() ? neocomplete#close_popup() : "\<Cr>"
  " 入力補完ウィンドウを閉じる
  inoremap <expr><C-y> neocomplete#close_popup()
  " 入力補完をキャンセル
  inoremap <expr><C-e> neocomplete#cancel_popup()
endif
" スニペット補完のキーマップ
imap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
" タグジャンプに必要なtagファイルを生成
nnoremap <silent><Leader>tg :Ctags
" タグジャンプしますよ
noremap tj <C-]>
" タグジャンプ戻りますよ
noremap tb <C-t>
" メモを新規作成
nnoremap <silent>mn :call MemoNew()<Cr>
" メモをリスト表示
nnoremap <silent>ml :MemoList<Cr>
" メモをgrep検索
nnoremap <silent>gm :MemoGrep<Cr>
" Quickrunを実行（要するにIEDとかにあるRunです）
nnoremap rn :QuickRun 
" Quickrunの終了(おなじみCtrl+cです）
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
" git status 現在のファイルの状態を取得
nnoremap st :Gstatus<Cr>
" git add 変更をステージに追加
nnoremap ad :Gwrite<Cr>
" git commit 変更を記録
nnoremap cm :Gcommit<Cr>
" git checkout 変更をなかったことに
nnoremap co :Gread<Cr>
" git blame ファイルの各行の変更がどのコミットか調べる(バッグった時に，誰の変更可わかるよね！)
nnoremap lm :Gblame<Cr>
" git diff HEADとの変更をdiffってくれる
nnoremap df :Gdiff<Cr>
" git fetch フェッチしてくれる
nnoremap fc :Gfetch<Cr>
" 標準で設定されているサーバにpushします
nnoremap ps :Gpush<Cr>
" VimShellが起動するよ
noremap <silent> vs :<C-u>VimShellPop<Cr>
" 2回押しで選択行をコメントアウトしてくれます
noremap <silent> <C-/> :TComment<Cr>


" 環境設定
" カラースキーマを設定(:Unite colorscheme -auto-preview => 良さそうなのを選ぶ)
if neobundle#is_installed('molokai')
  colorscheme molokai
endif
" バックスペースキーを有効化
set backspace=indent,eol,start
" タブの文字数
set tabstop=2
" タブを複数のスペースに置き換え
set expandtab
" 改行時に前行のインデントを継続
set autoindent
" 改行時に入力された行の末尾にあわせて次の行のインデントを増減
set smartindent
" 自動インデントした際のズレ幅
set shiftwidth=2
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
if has('mouse')
  set mouse=a
endif
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
" ESC打鍵時に，挿入モード離脱までの時間
set timeoutlen=250
" ビープ音を鳴らさない
set visualbell
set vb t_vb=
" コメントの色変更
hi Comment ctermfg=Gray

" 全角スペースを表示
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
