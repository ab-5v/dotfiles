#!/bin/bash
if [ -d "../.vim" ]; then
    rm -rf ../.vim
fi
cp -rf .vim ../.vim
cp .vimrc ../.vimrc

vim +BundleInstall +qall
