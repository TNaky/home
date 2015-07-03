homeDir
=======
# .vimrc
homeディレクトリに置いてあるrcファイルとか...
## syntasticを使う場合
zshenvにrbenvの設定が必要です

```zsh
$ vim .zshenv
```

```vim
if [ -d ${HOME}/.rbenv  ] ; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi
```
