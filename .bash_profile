#!/usr/bin/env bash

dotfiles=(path exports functions aliases bash_prompt extras)

for dotfile in ${dotfiles[@]}; do
	local dotfile=~/.dotfiles/."$dotfile"
	[ -f "$dotfile" ] && source "$dotfile"
done

shopts=(
	autocd # Directory names cd to them
	cdspell # Autocorrect typos when using `cd`
	checkwinsize # Update $LINES, $COLUMNS on terminal window size change
	cmdhist # Save multiline commands as on entry
	complete_fullquote # Quote file names with shell metacharacters during word completion
	direxpand # Expand directory names during word completion
	dirspell # Autocorrect directory names during word completion
	dotglob # Include file names beginning with . in path expansion
	expand_aliases # Expand aliases in non-interactive shells
	extglob # Use extended pattern matching in path expansion
	extquote # Expand parameters between quotes in $'string' and $"string"
	force_fignore # Ignore files with suffixes in $FIGNORE during word completion
	globstar # Expand ** during path expansion
	histappend # Append to .bash_history
	interactive_comments # Enable comments in interactive shells
	progcomp # Enable programmable completion facilities
	promptvars # Expand metachars in shell prompt
	sourcepath # `source` looks through $PATH
)

for opt in ${shopts[@]}; do
	shopt -s "$opt" &> /dev/null
done


# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion"
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi

# Enable tab completion for `g` by marking it as an alias for `git`
if command -v _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal" killall

# Disable persistent bash history
unset HISTFILE
cleanhome
history -c
