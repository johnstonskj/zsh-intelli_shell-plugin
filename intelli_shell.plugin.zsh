# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# @name intelli-shell
# @brief Zsh plugin to set up IntelliShell environment.
# @repository https://github.com/johnstonskj/zsh-intelli_shell-plugin
#

if command -v intelli-shell >/dev/null 2>&1; then
    eval "$(intelli-shell init zsh)"
else
    log_error "cannot initialize intelli-shell, it's not on the path"
fi
