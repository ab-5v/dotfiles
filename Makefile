all: bash vim

bash:
	ln -nfs ~/.dotfiles/bashrc ~/.bashrc
	ln -nfs ~/.dotfiles/screenrc ~/.screenrc
	@echo '. ~/.bash_profile'

vim:
	git submodule update --init
	make -C vim/

.PHONY: bash vim all
