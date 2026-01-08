# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Plugin Name: intelli-shell
# Repository: https://github.com/johnstonskj/zsh-intelli_shell-plugin
#
# Description:
#
#   Zsh plugin to set up IntelliShell environment.
#
# Public variables:
#
# * `INTELLI_SHELL`; plugin-defined global associative array with the following keys:
#   * `_FUNCTIONS`; a list of all functions defined by the plugin.
#   * `_PLUGIN_DIR`; the directory the plugin is sourced from.
#

############################################################################
# Standard Setup Behavior
############################################################################

# See https://wiki.zshell.dev/community/zsh_plugin_standard#zero-handling
0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# See https://wiki.zshell.dev/community/zsh_plugin_standard#standard-plugins-hash
declare -gA INTELLI_SHELL
INTELLI_SHELL[_PLUGIN_DIR]="${0:h}"
INTELLI_SHELL[_FUNCTIONS]=""

############################################################################
# Internal Support Functions
############################################################################

#
# This function will add to the `INTELLI_SHELL[_FUNCTIONS]` list which is
# used at unload time to `unfunction` plugin-defined functions.
#
# See https://wiki.zshell.dev/community/zsh_plugin_standard#unload-function
# See https://wiki.zshell.dev/community/zsh_plugin_standard#the-proposed-function-name-prefixes
#
.intelli_shell_remember_fn() {
    builtin emulate -L zsh

    local fn_name="${1}"
    if [[ -z "${INTELLI_SHELL[_FUNCTIONS]}" ]]; then
        INTELLI_SHELL[_FUNCTIONS]="${fn_name}"
    elif [[ ",${INTELLI_SHELL[_FUNCTIONS]}," != *",${fn_name},"* ]]; then
        INTELLI_SHELL[_FUNCTIONS]="${INTELLI_SHELL[_FUNCTIONS]},${fn_name}"
    fi
}
.intelli_shell_remember_fn .intelli_shell_remember_fn

############################################################################
# Plugin Unload Function
############################################################################

# See https://wiki.zshell.dev/community/zsh_plugin_standard#unload-function
intelli_shell_plugin_unload() {
    builtin emulate -L zsh

    # Remove all remembered functions.
    local plugin_fns
    IFS=',' read -r -A plugin_fns <<< "${INTELLI_SHELL[_FUNCTIONS]}"
    local fn
    for fn in ${plugin_fns[@]}; do
        whence -w "${fn}" &> /dev/null && unfunction "${fn}"
    done

    # Remove the global data variable.
    unset INTELLI_SHELL

    # Remove/reset any exported environment variables here if necessary.

    # Remove this function.
    unfunction intelli_shell_plugin_unload
}

############################################################################
# Initialize Plugin
############################################################################

eval "$(intelli-shell init zsh)"

true
