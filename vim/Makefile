all: $(HOME)/.vim $(HOME)/.vim/include/vundle

$(HOME)/.vim/include/vundle: $(CURDIR)/.vim/include/vundle
	mkdir -p $(HOME)/.vim/include
	cp $< $@
	cp -r $(CURDIR)/.vim/bundle $(HOME)/.vim/bundle
	vim +PluginInstall +qall

$(HOME)/.vim:
	mkdir $@
	ln -nfs $(CURDIR)/.vim/colors $@/colors
	ln -nfs $(CURDIR)/.vim/snippets $@/snippets
	ln -nfs $(CURDIR)/vimrc $(HOME)/.vimrc

clean:
	rm -rf $(HOME)/.vim*

.PHONY: all clean
