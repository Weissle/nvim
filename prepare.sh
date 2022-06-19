wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
wget https://nodejs.org/dist/v16.15.1/node-v16.15.1-linux-x64.tar.xz

QUIET=false
Echo(){
	if [ "$QUIET" = false ] ; then
		echo $@
	fi
}

check_software(){
	if ! type "$1" > /dev/null; then
		if [ "$2" = true ]; then
			echo "You have not install $1 and it is necessary. Please install it and rerun this script."
			exit 1
		else
			echo "You have not install $1 and the installation may fail."
		fi
	fi
}

check_software "nvim" 
check_software "git"
check_software "unzip"
check_software "curl"
check_software "wget"
check_software "cmake"
