all: install

install:
	if test -d ~/.vim; then rm -rf ~/.vim; fi
	cp -rf .vim ~/.vim
	cp .vimrc ~/.vimrc
	vim +BundleInstall +qall
