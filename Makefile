all: bash vim

bash:
	git submodule init
	git submodule update
	ln -nfs ~/dotfiles/bashrc ~/.bashrc
	cd ~; . ~/.bash_profile

vim:
	make -C vim/

.PHONY: bash vim all
