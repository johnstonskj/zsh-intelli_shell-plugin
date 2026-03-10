# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# @name: intelli-shell
# @brief: Set the environment for IntelliShell completion.
# @repository: https://github.com/johnstonskj/zsh-intelli_shell-plugin
# @version: 0.1.1
# @license: MIT AND Apache-2.0
#

if command -v intelli-shell >/dev/null 2>&1; then
    eval "$(intelli-shell init zsh)"
else
    log_error "cannot initialize intelli-shell, it's not on the path"
fi
