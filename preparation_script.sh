function verify_installation {
  application=$(which "$1")
  if [[ $application == "" ]];
  then
    echo "$2"
    exit 1
  fi
}


# Check SHELL

cur_shell=$(echo "$SHELL" | grep "zsh")

if [[ $cur_shell == "" ]];
then
  if [[ $(which zsh) != "" ]];
  then
    echo "Change shell to zsh, use the path: $(which zsh)"
  else
    echo "You don't have the zsh binary file. Make sure installed it!"
  fi
  exit 1
fi

# Checking python3 and pip
verify_installation "python3" "Python3 is not installed!"
verify_installation "pip3" "Python module, pip3 is not installed!"

# Checking utilities
verify_installation "unzip" "unzip is not installed!"
verify_installation "node" "nodejs is not installed!"
verify_installation "gem" "gem (rubygem) is not installed!"

# Checking golang
verify_installation "go" "Golang is not installed!"

# Checking terminal ENV
verify_installation "omz" "oh-my-zsh is not installed! Clone the github project https://github.com/ohmyzsh/ohmyzsh and put it to dotfiles/config/oh-my-zsh."

# For Neovim plugins
verify_installation "fzf" "FZF is not installed!"

# For K8s containers
verify_installation "kubectl" "Kubernetes (kubectl) is not installed! Or you can remove the line in zshrc file that placed at dotfiles/config/zsh/zshrc"
