
export ZSH="$HOME/.oh-my-zsh"

RESET_CONSOLE="\033[0m"
BACKGRUND_WHITE="\033[47m"
TEXT_BLUE="\033[34m"
STATUS_BLINK="\033[5m"
FONT_BOLD="\033[1m"

_ST_0="\033[0m\033[1m\033[44m\033[34m"

_ST="$BACKGRUND_WHITE$TEXT_BLUE$FONT_BOLD"
_FN="$RESET_CONSOLE"


ZSH_THEME="MUSTAFA"

# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# DISABLE_MAGIC_FUNCTIONS="true"
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
ZSH_DISABLE_COMPFIX=true
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="dd.mm.yyyy"

plugins=(
	sudo
	debian
	ubuntu
	history
	git
	colored-man-pages
	emoji
	homestead
	nvm
	npm
	shrink-path
	web-search
	vscode
	zbell
	
	zsh-autosuggestions
	zsh-syntax-highlighting
	
	autojump
	urltools
	bgnotify
	zsh-history-enquirer
	jovial
)

source $ZSH/oh-my-zsh.sh

# export MANPATH="/usr/local/man:$MANPATH"
export LANG=tr_TR.UTF-8
export EDITOR='nano'

## neofetch

## echo "$_ST Hoş Geldiniz:\n $_FN"
