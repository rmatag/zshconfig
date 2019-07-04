
export JAVA_HOME=$(/usr/libexec/java_home)
export M2_HOME=/Users/rur/work/apps/maven
export MONGO_HOME=/Users/rur/work/apps/mongodb/bin
export PATH=$JAVA_HOME:$MONGO_HOME:$M2_HOME/bin:$PATH


export ZSH=/Users/rur/.oh-my-zsh
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters

ZSH_THEME="agnoster"
alias zshconfig=". ~/.zshrc"

plugins=(git mvn colored-man colorize brew osx z zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

DEFAULT_USER=$USER

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Java versions
alias java_versions="jenv versions"
java_add(){
	jenv add $1
}
alias java9="jenv global 9.0.4"
alias java8="jenv global 1.8.0.171"


alias mci="mvn clean install"
alias mct="mvn clean test"
alias mcc="mvn clean compile"

check_dependencies_vulnerabilities() { mvn org.owasp:dependency-check-maven:aggregate versions:display-dependency-updates -P dependency-check }

restore_db_docker_container() {
	docker stop mongodb
	docker rm mongodb
	docker run -ti --name mongodb -p 27017:27017 docker.repo.dreamit.de/lotto-dump
}
restore_db_docker_image() {
	docker stop mongodb
	docker rm mongodb
	docker rmi --force docker.repo.dreamit.de/lotto-dump
	docker pull docker.repo.dreamit.de/lotto-dump
	docker run -ti --name mongodb -p 27017:27017 docker.repo.dreamit.de/lotto-dump
}
clean_docker_volume() { docker volume rm $(docker volume ls -qf dangling=true) }

git_new() { git checkout -b $1 }

git_master() { 
	git checkout master
	git pull
}

git_merge_master() {
	git checkout master
	git pull
	git checkout $1
	git merge master
	git push
}

git_list_deleted_files() {
  if [ "$#" -ne 1 ]; then
    # Log whole summary
    git log --diff-filter=D --summary
  else
    # Log filtered by pattern
    git log --diff-filter=D --summary | grep $1 -B 6
  fi
}

git_restore_deleted_file() {
  # First arg = Hash commit
  # Second arg = Path to file
  git checkout $1~1 $2
}

git_delete_remote_branch() { git push origin --delete $1 }
git_delete_local_branch() { git branch -D $1 }
git_delete_all_local_branches() {git branch | grep -v "master" | xargs git branch -D}

import_bson_file() {
	mongorestore -d $1 -c $2 $3
	#mongorestore -d lotto -c tickets /Users/rur/Downloads/lotto/tickets.bson
}


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
eval "$(jenv init -)"
