function setup_proxy() {
	local port=${1:-10809} # Use the default port 10809 of v2rayn if $1 is not provided
	host_ip=$(grep "nameserver" /etc/resolv.conf | cut -f 2 -d " ")
	export ALL_PROXY="http://$host_ip:$port"
}

function update_ubuntu() {
	sudo apt update
}

function install_tools() {
	sudo apt-get install -y curl exa ncdu git iproute2 ripgrep tmux httpie bat btop net-tools fd-find fzf ranger tree
}

function install_zsh() {
	if ! [ -f /usr/bin/zsh ]; then
		sudo apt install -y zsh
		chsh -s "$(which zsh)"
		touch ~/.zshrc
	fi
}

function install_zsh_plugins() {
	local PLUGIN_PATH="$HOME/.zsh/zsh-plugins" # Use $HOME to specify the home directory

	mkdir -p "$PLUGIN_PATH"

	# Install powerlevel10k
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$PLUGIN_PATH"/powerlevel10k
	echo "source $PLUGIN_PATH/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc

	# Install zsh-dircolors-nord
	git clone --recursive https://github.com/arcticicestudio/nord-dircolors.git "$PLUGIN_PATH"/nord-dircolors
	source $PLUGIN_PATH/nord-dircolors/src/nord-dircolors.zsh

	# Install zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGIN_PATH"/zsh-autosuggestions
	echo "source $PLUGIN_PATH/zsh-autosuggestions/zsh-autosuggestions.zsh" >>~/.zshrc

	# Install zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGIN_PATH"/zsh-syntax-highlighting
	echo "source $PLUGIN_PATH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >>~/.zshrc

	# Install autojump
	git clone https://github.com/wting/autojump.git "$PLUGIN_PATH"/autojump
	cd "$PLUGIN_PATH"/autojump && python install.py
}

function install_docker() {
	if ! [ -x "$(command -v docker)" ]; then
		sudo apt-get update
		sudo apt-get install -y ca-certificates curl gnupg
		sudo install -m 0755 -d /etc/apt/keyrings
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
		sudo chmod a+r /etc/apt/keyrings/docker.gpg

		# Add the repository to Apt sources:
		echo \
			"deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
 	 		"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" |
			sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
		sudo apt-get update

		# install docker
		sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	fi
}

function install_mamba() {
	if ! [ -x "$(command -v micromamba)" ]; then
		cd ~
		"${SHELL}" <(curl -L micro.mamba.pm/install.sh)
		./micromamba shell init -s zsh -p ~/micromamba
		source ~/.zshrc
		alias mcm="micromamba"
		micromamba activate
		micromamba create -n myproject python=3.11
	fi
}

function install_poetry() {
	curl -sSL https://install.python-poetry.org | python3 -
}

function install_neovim() {
	sudo apt update
	sudo apt install snapd
	sudo snap install nvim --classic
}

function install_nodejs() {
	sudo apt-get update
	sudo apt-get install -y ca-certificates curl gnupg
	sudo mkdir -p /etc/apt/keyrings
	curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
	local NODE_MAJOR=20
	echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
	sudo apt-get update
	sudo apt-get install nodejs -y
}

function clean_up() {
	sudo apt autoremove
}

function main() {
	setup_proxy
	update_ubuntu
	install_tools
	install_zsh
	install_zsh_plugins
	install_docker
	install_mamba
	install_neovim
	clean_up
}

main
