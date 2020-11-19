# cli-tools

# 1 Step Installation 

Clone this repo and run the install script which will it for fish, bash, and zsh if they are installed. 
If you want install in a location other then your HOME change the `cd` command.  

```
cd ~; git clone https://github.com/daringway/cli-tools.git; ./cli-tools/install.sh
``` 

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