# vim:et sts=2 sw=2 ft=zsh
#
# A Zim (zsh framework) theme by Aggrathon. Heavily inspired by:
#   - https://github.com/zimfw/sorin
#   - https://github.com/zimfw/asciiship
#   - https://github.com/ohmyzsh/ohmyzsh/wiki/themes#mh
#
# Requires the following zmodules in the .zimrc file:
#   - duration-info
#   - git-info


_torim_prompt() {
  # Start [
  print -n '%B%(!.%F{red}#.%F{default}[)%b%f '
  # user and host names if SSH
  print -n ${SSH_TTY:+"%B%(!.%F{red}.%F{yellow})%n%f@%b%F{green}%m%f "}
  # Truncated Path
  local width=$(($COLUMNS < 100 ? $COLUMNS-50 : $COLUMNS/2))
  local width=$((width < 30 ? 30 : width))
  local prompt="%${width}<..<%~"
  print -n '%B%F{blue}'${prompt}'%b%f'
  # End ❯
  print -n ' %B%(!.%F{red}.%F{default})❯%f%b '
}

_torim_status() {
  # Previous command info
  print -n '%(?:%F{yellow}'${duration_info}'%f:%F{red}%B✘%b %?'${duration_info}'%f) '
  # Current time
  print -n '%B%F{grey}%T%f%b'
  # Git status
  print -n ''${(e)git_info[status]}'%f%b'
  # Virtual environment
  print -n ${VIRTUAL_ENV:+" %f(${VIRTUAL_ENV:t})"}
}

typeset -g VIRTUAL_ENV_DISABLE_PROMPT=1
setopt nopromptbang prompt{cr,percent,sp,subst}
autoload -Uz add-zsh-hook

if (( ${+functions[duration-info-preexec]} && ${+functions[duration-info-precmd]} )); then
  zstyle ':zim:duration-info' format ' %d'
  add-zsh-hook preexec duration-info-preexec
  add-zsh-hook precmd duration-info-precmd
fi

typeset -gA git_info
if (( ${+functions[git-info]} )); then
  zstyle ':zim:git-info' verbose yes
  zstyle ':zim:git-info:action' format '%F{default}:%F{1}%s'
  zstyle ':zim:git-info:ahead' format ' %F{magenta}⬆'
  zstyle ':zim:git-info:behind' format ' %F{magenta}⬇'
  zstyle ':zim:git-info:branch' format ' %F{cyan}%b'
  zstyle ':zim:git-info:commit' format ' %F{yellow}%c'
  zstyle ':zim:git-info:indexed' format ' %F{green}✚'
  zstyle ':zim:git-info:unindexed' format ' %F{green}✱'
  zstyle ':zim:git-info:position' format ' %F{magenta}%p'
  zstyle ':zim:git-info:stashed' format ' %F{blue}✭'
  zstyle ':zim:git-info:untracked' format ' %F{default}◼'
  zstyle ':zim:git-info:keys' format  'status' '$(coalesce "%b" "%p" "%c")%s%A%B%S%i%I%u'
  add-zsh-hook precmd git-info
fi

PS1='$(_torim_prompt)'
RPS1='$(_torim_status)'
