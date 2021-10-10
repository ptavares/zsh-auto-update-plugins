#!/usr/bin/env zsh

#####################
# COMMONS
#####################
autoload colors
zmodload zsh/datetime

#########################
# CONSTANT
#########################
BOLD="bold"
NONE="NONE"

#########################
# Functions
#########################

_zsh_auto_update_log() {
  local font=$1
  local color=$2
  local msg=$3

  if [ $font = $BOLD ]; then
    echo $fg_bold[$color] "[zsh-auto-update-plugin] $msg" "$reset_color"
  else
    echo $fg[$color] "[zsh-auto-update-plugin] $msg" "$reset_color"
  fi
}

# Current day
function _current_date() {
  echo $(($EPOCHSECONDS / 60 / 60 / 24))
}

# temp file to store date
function _update_zsh_custom_update() {
  echo "LAST_DATE=$(_current_date)" >|"${ZSH_CACHE_DIR}/.zsh-custom-update"
}

#########################
# PLUGIN MAIN
#########################
# Define update time
date_target=$UPDATE_ZSH_DAYS
if [[ -z "$date_target" ]]; then
  # Default value for updates
  date_target=15
fi

# Upgrade all plugins and call all custom update functions
function upgrade_oh_my_zsh_custom() {
  if [[ -z "$ZSH_AUTOUPDATE_PLUGINS_SILENT" ]]; then
    _zsh_auto_update_log $NONE "blue" "#############################################"
    _zsh_auto_update_log $BOLD "blue" "-> Upgrading all custom plugins..."
  fi

  find "${ZSH_CUSTOM}" -type d -name .git | while read d; do
    p=$(dirname "$d")
    pushd -q "${p}"

    if git pull --rebase --stat origin master; then
      _zsh_auto_update_log $NONE "blue" "Plugin $d has been updated and/or is at the current version."
    else
      _zsh_auto_update_log $NONE "red" 'There was an error updating. Try again later?'
    fi
    popd -q
  done

  if [[ -z "$ZSH_AUTOUPDATE_PLUGINS_SILENT" ]]; then
    _zsh_auto_update_log $BOLD "blue" "-> Calling update custom functions..."
  fi
  if [[ -z "$ZSH_AUTOUPDATE_IGNORE_DIRENV" ]] || [[ -z "$ZSH_AUTOUPDATE_IGNORE_ALL" ]]; then
    type update_zsh_direnv &>/dev/null && update_zsh_direnv || _zsh_auto_update_log $NONE "blue" "-> direnv plugin will not be updated"
  fi
  if [[ -z "$ZSH_AUTOUPDATE_IGNORE_KUBECTX" ]] || [[ -z "$ZSH_AUTOUPDATE_IGNORE_ALL" ]]; then
    type update_zsh_kubectx &>/dev/null && update_zsh_kubectx || _zsh_auto_update_log $NONE "blue" "-> kubectx plugin will not be updated"
  fi
  if [[ -z "$ZSH_AUTOUPDATE_IGNORE_PKENV" ]] || [[ -z "$ZSH_AUTOUPDATE_IGNORE_ALL" ]]; then
    type update_zsh_pkenv &>/dev/null && update_zsh_pkenv || _zsh_auto_update_log $NONE "blue" "-> pkenv plugin will not be updated"
  fi
  if [[ -z "$ZSH_AUTOUPDATE_IGNORE_SDKMAN" ]] || [[ -z "$ZSH_AUTOUPDATE_IGNORE_ALL" ]]; then
    type update_zsh_sdkman &>/dev/null && update_zsh_sdkman || _zsh_auto_update_log $NONE "blue" "-> sdkman plugin will not be updated"
  fi
  if [[ -z "$ZSH_AUTOUPDATE_IGNORE_TFENV" ]] || [[ -z "$ZSH_AUTOUPDATE_IGNORE_ALL" ]]; then
    type update_zsh_tfenv &>/dev/null && update_zsh_tfenv || _zsh_auto_update_log $NONE "blue" "-> tfenv plugin will not be updated"
  fi
  if [[ -z "$ZSH_AUTOUPDATE_IGNORE_TGENV" ]] || [[ -z "$ZSH_AUTOUPDATE_IGNORE_ALL" ]]; then
    type update_zsh_tgenv &>/dev/null && update_zsh_tgenv || _zsh_auto_update_log $NONE "blue" "-> tgenv plugin will not be updated"
  fi
  if [[ -z "$ZSH_AUTOUPDATE_IGNORE_EXA" ]] || [[ -z "$ZSH_AUTOUPDATE_IGNORE_ALL" ]]; then
    type update_zsh_exa &>/dev/null && update_zsh_exa || _zsh_auto_update_log $NONE "blue" "-> exa plugin will not be updated"
  fi
  if [[ -z "$ZSH_AUTOUPDATE_IGNORE_Z" ]] || [[ -z "$ZSH_AUTOUPDATE_IGNORE_ALL" ]]; then
    type update_zsh_z &>/dev/null && update_zsh_z || _zsh_auto_update_log $NONE "blue" "-> z plugin will not be updated"
  fi
  if [[ -z "$ZSH_AUTOUPDATE_IGNORE_TFSWITCH" ]] || [[ -z "$ZSH_AUTOUPDATE_IGNORE_ALL" ]]; then
    type update_zsh_tfswitch &>/dev/null && update_zsh_tfswitch || _zsh_auto_update_log $NONE "blue" "-> tfswitch plugin will not be updated"
  fi
  if [[ -z "$ZSH_AUTOUPDATE_IGNORE_TGSWITCH" ]] || [[ -z "$ZSH_AUTOUPDATE_IGNORE_ALL" ]]; then
    type update_zsh_tgswitch &>/dev/null && update_zsh_tgswitch || _zsh_auto_update_log $NONE "blue" "-> tgswitch plugin will not be updated"
  fi

  if [[ -z "$ZSH_AUTOUPDATE_PLUGINS_SILENT" ]]; then
    _zsh_auto_update_log $NONE "blue" "#############################################"
  fi
}

# Source zsh-custom-update to load var as env
if [ -f "${ZSH_CACHE_DIR}/.zsh-custom-update" ]
then
  . "${ZSH_CACHE_DIR}/.zsh-custom-update"

  # Check if update is needed (by date)
  if [[ -z "$LAST_DATE" ]]
  then
    LAST_DATE=0
  fi

  date_diff=$(($(_current_date) - $LAST_DATE))
  if [ $date_diff -gt $date_target ]
  then
    if [ "$DISABLE_UPDATE_PROMPT" = "true" ]
    then
      (upgrade_oh_my_zsh_custom)
    else
      _zsh_auto_update_log $BOLD "blue" "[Oh My Zsh] Would you like to check for custom plugin updates? [Y/n]: \c"
      read -r line
      if [[ "$line" == Y* ]] || [[ "$line" == y* ]] || [ -z "$line" ]
      then
        (upgrade_oh_my_zsh_custom)
      fi
    fi
    _update_zsh_custom_update
  fi
else
  _update_zsh_custom_update
fi

# Alias to call upgrade_oh_my_zsh before calling upgrade_oh_my_zsh_custom
alias upgrade_all_oh_my_zsh='omz update && upgrade_oh_my_zsh_custom'

unset -f _update_zsh_custom_update _current_date
