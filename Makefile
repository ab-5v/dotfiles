all: bash vim

bash:
	git submodule init
	git submodule update
	ln -nfs ~/dotfiles/bashrc ~/.bashrc
	. ~/.bash_profile

vim:
	make -C vim/

.PHONY: bash vim all
