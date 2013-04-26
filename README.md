dotfiles
========
vimrcを有効にするには下記のようにbundleをいれる必要がある。
```
$ mkdir -p ~/dotfiles/.vim/bundle
$ cd ~/dotfiles/.vim/bundle
$ git clone git@github.com:Shougo/vimproc.git
$ git clone git@github.com:Shougo/neobundle.vim.git
```
```:NeoBundleInstall```で必要なものインストール。

その他は下記のように。
```
$ cd
$ ln -s /usr/local/Cellar/git/1.8.1.5/etc/bash_completion.d/git-completion.bash git-completion.bash
$ ln -s /usr/local/Cellar/git/1.8.1.5/etc/bash_completion.d/git-prompt.sh git-prompt.sh
$ ln -s dotfiles/.bashrc .bashrc
$ ln -s dotfiles/.vimrc .vimrc
$ source ~/.bashrc
```

TODO:
近いうちセットアップスクリプト作成する。

