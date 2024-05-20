if status is-interactive
    # Commands to run in interactive sessions can go here
  freshfetch
end

fish_vi_key_bindings

### Setting variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

### "Nvim" as manpager
# set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -x MANPAGER "nvim +Man!"

# Changing sudo for doas with ALT + s
bind \es 'fish_commandline_prepend doas'
bind -M insert \cp 'yazicd'
# bind -M insert \cf 'tmux-sessionizer'

### Adding to the $PATH
fish_add_path "$HOME/.cargo/bin/" "$HOME/.local/bin/"

### EXPORT

if test -f "$HOME/.config/lf/lf_icons"
  source $HOME/.config/lf/lf_icons
end

set -Ux FZF_DEFAULT_OPTS "--layout=reverse --height 40%"

set -Ux EDITOR nvim                  # Set the $EDITOR to nvim
set -Ux TERM kitty
set -Ux BROWSER firefox
set fish_greeting                # Disable Fish's intro message

### Alias ###

source ~/.config/fish/completions/sb.fish
alias sbb "cd ~/Documents/obsidian && clear"
abbr sr "steam-run"

### Git Aliases ###
abbr ga "git add"
abbr gs "git status"
abbr gc "git commit"
abbr gC "git checkout"
abbr gp "git push"
abbr gP "git push"
abbr gd "git diff"
abbr gl "git log"

# Confirm before overwriting something
# alias cp="cp -i"
# alias mv='mv -i'
# alias rm='rm -i'

# Adding flags
alias df='df -h'                          
alias free='free -h'                      

# Changing "ls" to "eza"
alias ls="eza -al -s=type"
alias ll="eza -al --icons -s=type"

# Yt-dlp
alias yta-aac="yt-dlp --extract-audio --audio-format aac"
alias yta-best="yt-dlp --extract-audio --audio-format best"
alias yta-flac="yt-dlp --extract-audio --audio-format flac"
alias yta-m4a="yt-dlp --extract-audio --audio-format m4a"
alias yta-mp3="yt-dlp --extract-audio --audio-format mp3"
alias yta-opus="yt-dlp --extract-audio --audio-format opus"
alias yta-vorbis="yt-dlp --extract-audio --audio-format vorbis"
alias yta-wav="yt-dlp --extract-audio --audio-format wav"
alias ytv-best="yt-dlp -f bestvideo+bestaudio"

# Programs
alias lf="lfrun"
alias v="nvim"

abbr g "lazygit"

# Alias for cd
alias ..="cd .."
alias .2="cd ../.."
alias .3="cd ../../.."

# Starship Prompt
starship init fish | source

# Zoxide
zoxide init fish | source

# FZF
fzf --fish | source

