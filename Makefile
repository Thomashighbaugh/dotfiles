##############################################################################################################
## Makefile
##############################################################################################################

.PHONY: all


#######################################################################################################
## Maintaining the Repository
#######################################################################################################
update_repos: clean
	-cd ${HOME}/.config/awesome && git add . && git commit -m "updated" && git push --force
	-cd ${HOME}/.config/qtile && git add . && git commit -m "updated" && git push --force
	-cd ${HOME}/.mozilla/chrome && git add . && git commit -m "updated" && git push --force
	-cd ${HOME}/.local/share/bin && git add . && git commit -m "updated" && git push --force
	-cd ${HOME}/.local/share/vice-scheme && git add . && git commit -m "updated" && git push --force
	-cd ${HOME}/.local/share/startpage && git add . && git commit -m "updated" && git push --force
	cd ${PWD} && git add . && git commit -m "makefile group update" && git push --force

clean: 
	- rm -r ${PWD}/get-pip.py
	- rm -r ${PWD}/yarn.lock 
	- rm -r ${PWD}/.yarnclean 

