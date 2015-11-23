" GVimの設定ファイルです
" タブを表示
set showtabline=2
" GUIツールバーを非表示
set guioptions-=T
" mac os x環境固有の設定
if has('mac')
  " フォントサイズを18ポイントに設定
  set guifont=Ricty-RegularForPowerline:h18
  " 半透明化
  set transparency=10
endif
