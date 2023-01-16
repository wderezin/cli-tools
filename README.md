# cli-tools

A set of cli tools for Mac and Linux environments with a focus on the [fish shell](https://fishshell.com).  
For non fish features bash and zsh are also supported.

# Docker Dev Environments Dotfiles Setup

Add the followig lines to your VSCode `settings.json` file.

On Mac: ` ~/Library/Application\ Support/Code/User/settings.json`

```
    "dotfiles.repository": "https://github.com/wderezin/cli-tools",
    "terminal.integrated.defaultProfile.linux": "fish",
```

# GitHub Codespace Dotfiles

Set in `https://github.com/settings/codespaces`

# 1 Step Installation 

Clone this repo and run the install script which will it for fish, bash, and zsh if they are installed. 
If you want install in a location other then your HOME change the `cd` command.  

```
cd ~; git clone https://github.com/daringway/cli-tools.git; ./cli-tools/install.sh
``` 

# Fish Daring Prompt

```
[ <Account Information> ] · <CWD>  ·  <GIT Remote> ( <GIT BRANCH INFO> ) <GIT LOCAL INFO>
[ <ERROR RETURN CODE> ]#
```

Where:
Account Information: Supported accounts AWS, Virtual ENV, IBM Cloud, ETCDV3
CWD: Current working directory or short git path relative to repo directory
GIT Remote: information about the remote.

# Alternate Installation

If you want control on how the cli-tools are added to your shell then these are the steps for you.

```shell script
cd ~; git clone https://github.com/daringway/cli-tools.git;
``` 

## fish 

Add the following to your ~/.confif/fish/config.fish file
```shell script
ln -s ~/cli-tools/etc/rc.fish ~/.config/fish/conf.d/cli-tools.fish
```

## bash
Add the following to your ~/.bashrc
```shell script
eval ~/cli-tools/etc/bash-init)
```

## zsh
Add the following to your ~/.zshenv
```shell script
source ~/cli-tools/etc/rc.zsh
```

## direnv
```shell script
mkdir -p ~/.config/direnv/lib
ln -s ~/cli-tools/direnv.sh ~/.config/direnv/lib/cli-tools.sh
```