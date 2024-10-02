# fox.zsh-theme

BLINKER="[%{$fg_bold[green]%}%{$terminfo[blink]%}■%{$reset_color%}]"
USERNAME="%n"
HOSTNAME="%m"
LOCATION="%~" ## %d
CMD_INDEX="%h"
LAST_INDEX="%!"
DATETIME="%D{%T}"
END_REPORT="%?"



USERNAME_AREA="[%{$fg_bold[blue]%}$USERNAME%{$reset_color%}@%{$fg_bold[red]%}$HOSTNAME%{$reset_color%}]"
LOCATION_AREA="[%{$fg_bold[cyan]%}$LOCATION%{$reset_color%}]"
DATETIME_AREA="%{$bg[blue]%}%{$fg_bold[default]%}[%{$fg_bold[yellow]%}$DATETIME%{$fg_bold[default]%}]%{$reset_color%}"


LINEF="[%{$fg_bold[yellow]%}$END_REPORT%{$reset_color%}] [$LAST_INDEX] [$DATETIME]"

LINE0="%{$reset_color%}%{$fg_bold[blue]%}⌠%{$reset_color%}$USERNAME_AREA $LOCATION_AREA"

LINEL="%{$reset_color%}%{$fg_bold[blue]%}⌡%{$reset_color%}»%{$reset_color%}"


ZSH_THEME_PROMPT_NEWLINE_BEFORE_PROMPT=true
ZSH_THEME_PROMPT_NEWLINE_AFTER_PROMPT=true

ZSH_THEME_PROMPT_PREFIX="PRE"
ZSH_THEME_PROMPT_SUFFIX="SUF"


ZSH_THEME_TERM_TITLE_IDLE="OMZ Mustafa [$DATETIME]"
ZSH_THEME_TERM_TITLE="OMZ Mustafa [$DATETIME] (Active)"

RPROMPT="« $BLINKER$DATETIME_AREA"

PROMPT="$LINEF
$LINE0
$LINEL "
