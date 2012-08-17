all: bash vim

bash:
	ln -nfs ~/.dotfiles/bashrc ~/.bashrc
	@echo '. ~/.bash_profile'

vim:
	git submodule init
	git submodule update
	make -C vim/

.PHONY: bash vim all
