if status is-interactive
    # Commands to run in interactive sessions can go here

  # setxkbmap br
  # neofetch
end

### Setting variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Changing sudo for doas with ALT + s
bind \es 'fish_commandline_prepend doas'
bind \ec 'colorscheme'
bind \ef 'files'
bind \el 'lfcd'

### Adding to the $PATH
fish_add_path "$HOME/.cargo/bin/" "$HOME/.local/bin/"

### EXPORT
source $HOME/.config/fish/api.bash
source $HOME/.config/lf/lf_icons
set -Ux EDITOR nvim                  # Set the $EDITOR to nvim
set -Ux TERM kitty
set -Ux BROWSER librewolf
set fish_greeting                # Disable Fish's intro message

### Alias ###

### Git Aliases ###
alias ga="git add"
alias gs="git status"
alias gc="git commit"
alias gp="git push"
alias gP="git push"
alias gd="git diff"
alias gl="git log"

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# adding flags
alias df='df -h'                          
alias free='free -h'                      

# Changing "ls" to "exa"
alias ls="exa -al -s=type"
alias l="exa -a --icons -s=type"

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
alias v="nvim"
alias lf="lfrun"
alias g="lazygit"
alias t="tldr --list | fzf --preview 'tldr {1} --color=always' --preview-window=right,75% | xargs tldr"

# Alias for cd
alias ..="cd .."
alias .2="cd ../.."
alias .3="cd ../../.."

# File Extraction 

function ex --description "Extract bundled & compressed files"
    if test -f "$argv[1]"
        switch $argv[1]
            case '*.tar.bz2'
                tar xjf $argv[1]
            case '*.tar.gz'
                tar xzf $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.rar'
                unrar $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.tar'
                tar xf $argv[1]
            case '*.tbz2'
                tar xjf $argv[1]
            case '*.tgz'
                tar xzf $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.Z'
                uncompress $argv[1]
            case '*.7z'
                7z $argv[1]
            case '*.deb'
                ar $argv[1]
            case '*.tar.xz'
                tar xf $argv[1]
            case '*.tar.zst'
                tar xf $argv[1]
            case '*'
                echo "'$argv[1]' cannot be extracted via ex"
        end
   else
       echo "'$argv[1]' is not a valid file"
   end
end

# Starship Prompt
starship init fish | source
