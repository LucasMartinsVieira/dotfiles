if status is-interactive
    # Commands to run in interactive sessions can go here
  setxkbmap br
end

export CARGO_HOME="$HOME/.local/share/cargo"
export RUSTUP_HOME="$HOME/.local/share/rustup"
export GOPATH="$HOME/.local/share/go"

# Changing sudo for doas with ALT + s
bind \es 'fish_commandline_prepend doas'
bind \cf 'lfrun'

export FZF_DEFAULT_COMMAND="find -H"
export PATH="/home/lucas/.local/share/cargo/bin/:$PATH"
export PATH="/home/lucas/.local/bin/:$PATH"

export EDITOR="/usr/bin/nvim"
# bare git repo alias for dotfiles
alias dotfiles="/usr/bin/git --git-dir=$HOME/repos/dotfiles --work-tree=$HOME"

### Disable Fish intro menssage ###

set fish_greeting 


### Alias ###
alias sudo="doas"
alias beats="rofi-beats"
alias wiki="nvim ~/Documentos/vimwiki/index.md"
alias note="nvim ~/Documentos/vimwiki/Notes.md"
alias op="nvim ~/Documentos/vimwiki/one-piece-manga.md"

### Git Aliases ###

alias ga="git add"
alias gs="git status"
alias gm="git commit"
alias gp="git push"
alias gd="git diff"
alias gl="git log"

### Curl's alias ###
alias crypto="curl rate.sx"
alias news="curl getnews.tech"

### FZF aliases ###
alias vfzf="nvim (fzf)"
alias zfzf="cd ~/Documentos/Media/Livros/ | zathura (fzf)"

# confirm before overwriting something
# alias cp="cp -i"
# alias mv='mv -i'
# alias rm='rm -i'

# adding flags
alias df='df -h'                          
alias free='free -h'                      

# Changing "ls" to "exa"
alias ls="exa -al -s=type"
alias l="exa -a --icons -s=type"

# yt-dlp
alias yta-aac="yt-dlp --extract-audio --audio-format aac"
alias yta-best="yt-dlp --extract-audio --audio-format best"
alias yta-flac="yt-dlp --extract-audio --audio-format flac"
alias yta-m4a="yt-dlp --extract-audio --audio-format m4a"
alias yta-mp3="yt-dlp --extract-audio --audio-format mp3"
alias yta-opus="yt-dlp --extract-audio --audio-format opus"
alias yta-vorbis="yt-dlp --extract-audio --audio-format vorbis"
alias yta-wav="yt-dlp --extract-audio --audio-format wav"
alias ytv-best="yt-dlp -f bestvideo+bestaudio"

# Apps
alias v="nvim"
alias lf="lfrun"
alias mpv="devour mpv"
alias feh="devour feh"
alias sxiv="devour sxiv"
alias zathura="devour zathura"
alias pcmanfm="devour pcmanfm"
alias librewolf="devour librewolf"


# Alias for cd
alias ..="cd .."
alias .2="cd ../.."
alias .3="cd ../../.."

### Run fetch ###
# neofetch

# Start X at login
if status --is-login
if test -z "$DISPLAY" -a $XDG_VTNR = 1
exec startx -- -keeptty
end
  end
