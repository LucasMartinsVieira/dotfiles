if status is-interactive
    # Commands to run in interactive sessions can go here
  setxkbmap br
end

set TERM kitty


### Setting variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Changing sudo for doas with ALT + s
bind \es 'fish_commandline_prepend doas'

# Binding CRTL + f to run lf
bind \cf 'lfrun'

### Adding to the $PATH
fish_add_path "$HOME/.cargo/bin/" "$HOME/.local/bin/"

### EXPORT
set EDITOR nvim                  # Set the $EDITOR to nvim
set fish_greeting                           # Disable Fish's intro message

### Alias ###
alias beats="rofi-beats"
alias wiki="nvim ~/Documentos/vimwiki/index.md"
alias note="nvim ~/Documentos/vimwiki/Notes.md"

### Git Aliases ###

alias ga="git add"
alias gs="git status"
alias gc="git commit"
alias gp="git push"
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

# Apps
alias v="nvim"
alias lf="lfrun"
alias pcmanfm="devour pcmanfm"

# Alias for cd
alias ..="cd .."
alias .2="cd ../.."
alias .3="cd ../../.."

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

### Run fetch ###
# neofetch

# Lf icons

export LF_ICONS="\
tw=:\
st=:\
ow=:\
dt=:\
di=:\
fi=:\
ln=:\
or=:\
ex=:\
*.c=:\
*.cc=:\
*.clj=:\
*.coffee=:\
*.cpp=:\
*.css=:\
*.d=:\
*.dart=:\
*.erl=:\
*.exs=:\
*.fs=:\
*.go=:\
*.h=:\
*.hh=:\
*.hpp=:\
*.hs=:\
*.html=:\
*.java=:\
*.jl=:\
*.js=:\
*.json=:\
*.lua=:\
*.md=:\
*.php=:\
*.pl=:\
*.pro=:\
*.py=:\
*.rb=:\
*.rs=:\
*.scala=:\
*.ts=:\
*.vim=:\
*.cmd=:\
*.ps1=:\
*.sh=:\
*.bash=:\
*.zsh=:\
*.fish=:\
*.tar=:\
*.tgz=:\
*.arc=:\
*.arj=:\
*.taz=:\
*.lha=:\
*.lz4=:\
*.lzh=:\
*.lzma=:\
*.tlz=:\
*.txz=:\
*.tzo=:\
*.t7z=:\
*.zip=:\
*.z=:\
*.dz=:\
*.gz=:\
*.lrz=:\
*.lz=:\
*.lzo=:\
*.xz=:\
*.zst=:\
*.tzst=:\
*.bz2=:\
*.bz=:\
*.tbz=:\
*.tbz2=:\
*.tz=:\
*.deb=:\
*.rpm=:\
*.jar=:\
*.war=:\
*.ear=:\
*.sar=:\
*.rar=:\
*.alz=:\
*.ace=:\
*.zoo=:\
*.cpio=:\
*.7z=:\
*.rz=:\
*.cab=:\
*.wim=:\
*.swm=:\
*.dwm=:\
*.esd=:\
*.jpg=:\
*.jpeg=:\
*.mjpg=:\
*.mjpeg=:\
*.gif=:\
*.bmp=:\
*.pbm=:\
*.pgm=:\
*.ppm=:\
*.tga=:\
*.xbm=:\
*.xpm=:\
*.tif=:\
*.tiff=:\
*.png=:\
*.svg=:\
*.svgz=:\
*.mng=:\
*.pcx=:\
*.mov=:\
*.mpg=:\
*.mpeg=:\
*.m2v=:\
*.mkv=:\
*.webm=:\
*.ogm=:\
*.mp4=:\
*.m4v=:\
*.mp4v=:\
*.vob=:\
*.qt=:\
*.nuv=:\
*.wmv=:\
*.asf=:\
*.rm=:\
*.rmvb=:\
*.flc=:\
*.avi=:\
*.fli=:\
*.flv=:\
*.gl=:\
*.dl=:\
*.xcf=:\
*.xwd=:\
*.yuv=:\
*.cgm=:\
*.emf=:\
*.ogv=:\
*.ogx=:\
*.aac=:\
*.au=:\
*.flac=:\
*.m4a=:\
*.mid=:\
*.midi=:\
*.mka=:\
*.mp3=:\
*.mpc=:\
*.ogg=:\
*.ra=:\
*.wav=:\
*.oga=:\
*.opus=:\
*.spx=:\
*.xspf=:\
*.pdf=:\
*.nix=:\
"

# Start X at login
if status --is-login
if test -z "$DISPLAY" -a $XDG_VTNR = 1
exec startx -- -keeptty
end
  end
