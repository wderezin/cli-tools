# cli-tools

# 1 Step Installation 

Clone this repo and run the install script which will it for fish, bash, and zsh if they are installed.

```
git clone https://github.com/daringway/cli-tools.git; ./cli-tools/install.sh
``` 

# Alternate Installation

If you want control on how the cli-tools are added to your shell then these are the steps for you.

```
git clone https://github.com/daringway/cli-tools.git; ./cli-tools/install.sh
``` 

## fish 

Add the following to your ~/.confif/fish/config.fish file
```
ln -s <PATH_TO_REPO>/etc/rc.fish ~/.config/fish/conf.d/cli-tools.fish
```

## bash
Add the following to your ~/.bashrc
```
eval $(<PATH_TO_REPO>/etc/bash-init)
```

## zsh
Add the following to your ~/.zshenv
```
source <PATH_TO_REPO>/etc/rc.zsh
```
