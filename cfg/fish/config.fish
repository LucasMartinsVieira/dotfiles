fish_vi_key_bindings

### Setting variables
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_STATE_HOME $HOME/.local/state/

# Cleaning Home
set -x DOCKER_CONFIG $XDG_CONFIG_HOME/docker
set -x CARGO_HOME $XDG_DATA_HOME/cargo
set -x GOPATH $XDG_DATA_HOME/go
set -x SDKMAN_DIR $XDG_DATA_HOME/sdkman
set -x RUSTUP_HOME $XDG_DATA_HOME/rustup
set -x NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -x XAUTHORITY $XDG_RUNTIME_DIR/Xauthority

### "Nvim" as manpager
# set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -x MANPAGER "nvim +Man!"

# Changing sudo for doas with ALT + s
bind \es 'fish_commandline_prepend doas'
bind -M insert \cp 'yazicd'
# bind -M insert \cf 'tmux-sessionizer'

### Adding to the $PATH
fish_add_path "$HOME/.local/share/cargo/bin" "$HOME/.cargo/bin/" "$HOME/.local/bin/" "$HOME/.npm-global/bin/" "$HOME/.local/share/go/bin/"

### EXPORT

if test -f "$HOME/.config/lf/lf_icons"
  source $HOME/.config/lf/lf_icons
end

set -Ux FZF_DEFAULT_OPTS "--layout=reverse --height 40%"
set -Ux FZF_DEFAULT_COMMAND "fd --hidden --strip-cwd-prefix --exclude .git";
set -Ux FZF_CTRL_T_COMMAND "fd --hidden --strip-cwd-prefix --exclude .git";
set -Ux FZF_ALT_C_COMMAND "fd --type=d --hidden --strip-cwd-prefix --exclude .git";
set -Ux STEAM_EXTRA_COMPAT_TOOLS_PATH "$HOME/.steam/root/compatibilitytools.d";

set -Ux EDITOR nvim                  # Set the $EDITOR to nvim
set -Ux TERM kitty
set -Ux BROWSER firefox
set fish_greeting                # Disable Fish's intro message

### Alias ###

alias mon "wlr-randr --output eDP-1 --on --mode 1920x1080 --pos 1920,0 --transform normal --output HDMI-A-1 --on --preferred --mode 1920x1080 --pos 0,0 --transform normal"
alias mof "wlr-randr --output eDP-1 --on --mode 1920x1080 --pos 1920,0 --transform normal --output HDMI-A-1 --off"
alias restart-gpu "doas modprobe -r -f amdgpu && sleep 10 && doas mobprobe amdgpu"

source ~/.config/fish/completions/sb.fish
alias s "sesh connect (sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')"

### Git Aliases ###
abbr ga "git add"
abbr gs "git status"
abbr gc "git commit"
abbr gC "git checkout"
abbr gp "git pull"
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
alias lt="eza --tree --git-ignore --icons --color=always"
alias l="eza -al --icons -s=type"

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
# alias lf="lfrun"
alias v="nvim"

abbr g "lazygit"
abbr d "lazydocker"

# Alias for cd
alias ..="cd .."
alias .2="cd ../.."
alias .3="cd ../../.."

### Functions
function t --description "TL;DR"
  if test -n "$argv"
    for arg in $argv
      tldr $arg
    end
  else
    tldr --list | fzf --preview 'tldr {1} --color=always' --height "75%" --preview-window=right,75% | xargs tldr
  end
end

# Use lf to switch directories
function lfcd
  set tmp (mktemp)
  lf -last-dir-path=$tmp $argv
  if test -f "$tmp"
    set dir (cat $tmp)
    rm -f $tmp
    if test -d "$dir"
      if test "$dir" != (pwd)
        cd $dir
      end
    end
  end
end

# Use yazi to switch directories
function yazicd
  set tmp (mktemp)
  yazi --cwd-file $tmp $argv
  if test -f "$tmp"
    set dir (cat $tmp)
    rm -f $tmp
    if test -d "$dir"
      if test "$dir" != (pwd)
        cd $dir
      end
    end
  end
  starship prompt
end

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

# SDK MAN
# function sdk
#   bash -c "source '$HOME/.sdkman/bin/sdkman-init.sh'; sdk $argv[1..]"
# end
#
# fish_add_path (find "$HOME/.sdkman/candidates/java/current/bin" -maxdepth 0)

# Starship Prompt
function starship_transient_prompt_func
  starship module character
end
starship init fish | source
enable_transience

# Zoxide
zoxide init fish | source

# FZF
fzf --fish | source

# Direnv
direnv hook fish | source

# Mise
if type -q mise
  mise activate fish | source
end
