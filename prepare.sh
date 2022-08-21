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

mkdir binary
cd binary

wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
wget https://nodejs.org/dist/v16.17.0/node-v16.17.0-linux-x64.tar.xz
wget https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
wget https://github.com/sharkdp/fd/releases/download/v8.4.0/fd_8.4.0_amd64.deb
wget https://github.com/jesseduffield/lazygit/releases/download/v0.35/lazygit_0.35_Linux_x86_64.tar.gz
# nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
if [[ ! -e "~/.local/share/nvim/site/pack/packer/opt/packer.nvim/" ]] then
	git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/opt/packer.nvim
fi
