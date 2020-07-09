# zsh-auto-update-plugins

[oh-my-zsh plugin](https://github.com/robbyrussell/oh-my-zsh) to update all [oh-my-zsh plugin's](https://github.com/robbyrussell/oh-my-zsh) git-repositories, and my personal zsh plugins stored in $ZSH_CUSTOM folder.

## Table of content

## Install

Once the plugin installed, `auto-update-plugins` will be available

- As an [Oh My ZSH!](https://github.com/robbyrussell/oh-my-zsh) custom plugin

Clone `zsh-auto-update-plugins` into your custom plugins repo and load as a plugin in your `.zshrc`

```shell script
git clone https://github.com/ptavares/zsh-auto-update-plugins.git ~/.oh-my-zsh/custom/plugins/zsh-auto-update-plugins
```

```shell script
plugins+=(zsh-auto-update-plugins)
```

Keep in mind that plugins need to be added before `oh-my-zsh.sh` is sourced.

## Usage

### Setup custom days

By default, the plugin will check for updates every 15 days. If you want to change this value, add this line in your `${HOME}/.zshrc `.

```shell script
# Example to check every 10 days
export UPDATE_ZSH_DAYS=10
```

### Disable auto-update functions

By default, the plugin will call all my plugins custom update functions. 
This feature can be disabled exporting some variables in your `${HOME}/.zshrc`.

#### ALL

* Disable all auto-update

```shell script
export ZSH_AUTOUPDATE_IGNORE_ALL=true
```

#### Custom 

* Disable `direnv` auto-update from [zsh-direnv](https://github.com/ptavares/zsh-direnv) plugin

```shell script
export ZSH_AUTOUPDATE_IGNORE_DIRENV=true
```

* Disable `kubectx` auto-update from [zsh-kubectx](https://github.com/ptavares/zsh-kubectx) plugin

```shell script
export ZSH_AUTOUPDATE_IGNORE_KUBECTX=true
```

* Disable `sdkman` auto-update from [zsh-sdkman](https://github.com/ptavares/zsh-sdkman) plugin

```shell script
export ZSH_AUTOUPDATE_IGNORE_SDKMAN=true
```

* Disable `tfenv` auto-update from [zsh-tfenv](https://github.com/ptavares/zsh-tfenv) plugin

```shell script
export ZSH_AUTOUPDATE_IGNORE_TFENV=true
```

* Disable `tgenv` auto-update from [zsh-tgenv](https://github.com/ptavares/zsh-tgenv) plugin

```shell script
export ZSH_AUTOUPDATE_IGNORE_TGENV=true
```

* Disable `pkenv` auto-update from [zsh-pkenv](https://github.com/ptavares/zsh-pkenv) plugin

```shell script
export ZSH_AUTOUPDATE_IGNORE_PKENV=true
```

* Disable `exa` auto-update from [zsh-exa](https://github.com/ptavares/zsh-exa) plugin

```shell script
export ZSH_AUTOUPDATE_IGNORE_EXA=true
```

### Silent Mode

To turn off `auto-update-plugins` message, add this variable in your `${HOME}/.zshrc`  

```shell script
export ZSH_AUTOUPDATE_PLUGINS_SILENT=true
```

### Force update

The plugin comes with a zsh function to force update manually (not wait for automatic) :

```shell script
upgrade_oh_my_zsh_custom
```

And another function to call `upgrade_oh_my_zsh` before updating custom plugins :

```shell script
upgrade_all_oh_my_zsh
```

## License

[MIT](LICENCE)
