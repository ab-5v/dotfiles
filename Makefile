all: bash vim

bash:
	ln -nfs ~/.dotfiles/bashrc ~/.bashrc
	ln -nfs ~/.dotfiles/screenrc ~/.screenrc
	ln -nfs ~/.dotfiles/tmux.conf ~/.tmux.conf
	ln -nfs ~/.dotfiles/gitconfig ~/.gitconfig
	@echo '. ~/.bash_profile'

vim:
	git submodule update --init
	make -C vim/

.PHONY: bash vim all
