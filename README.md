# My vim config files!

## Installation:

- Firstly, make sure you have installed "Exuberant Ctags" and "GNU GLOBAL"
- Nextly, execute following command in your term

``` 
cd
mv .vimrc{,.bak}
mv .vim{,.bak}
git clone https://github.com/nemopwn/dotvim.git ~/.vim
ln -s ~/.vim/.vimrc ~/.vimrc
```

- Then, install `vim-plug`and other plugins.

  - install vim-plug, see https://github.com/junegunn/vim-plug#installation

    ```sh
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ```


  - install other plugins,

    ```sh
    vim +PlugUpdate
    ```


- And then, add ~/.vim/scripts to your $PATH

  `eg: add "PATH=$HOME/.vim/scripts:$PATH" to ~/.bash_profile`

- Finally, set YouCompleteMe.

  - compile YouCompleteMe

    ``` 
    cd ~/.vim/plugged/YouCompleteMe
    ./install.sh --clang-completer
    ```

  - `mkdir ycm_extra_conf` and find a file `.ycm_extra_conf.py` in bundle/YouCompleteMe.

  - copy the `.ycm_extra_conf.py` to `ycm_extra_conf/c.ycm_extra_conf.py` and `ycm_extra_conf/cpp.ycm_extra_conf.py`.

  - change `*.ycm_extra_conf.py` files.

  - you can use `echo | c++ -std=c++11 -stdlib=libc++ -v -E -x c++ -` to get include directories, and put them to `flags` with `-isystem` in `*.ycm_extra_conf.py`.

## Recommend

Add following alias to use `vims` cmd to start vim with automatic syntax check .

```
alias vims="vim --cmd 'let g:ycm_show_diagnostics_ui=1'"
```

