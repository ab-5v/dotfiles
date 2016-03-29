all: bash vim

git: ~/.gitconfig

bash:
	ln -nfs ~/.dotfiles/bashrc ~/.bashrc
	ln -nfs ~/.dotfiles/screenrc ~/.screenrc
	ln -nfs ~/.dotfiles/tmux.conf ~/.tmux.conf
	@echo '. ~/.bash_profile'

vim:
	git submodule update --init
	make -C vim/

~/.gitconfig: gitconfig
	cp $< $@


.PHONY: bash vim all git
