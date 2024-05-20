# SDK MAN
function sdk
    bash -c "source '$HOME/.sdkman/bin/sdkman-init.sh'; sdk $argv[1..]"
end

fish_add_path (find "$HOME/.sdkman/candidates/java/current/bin" -maxdepth 0)
fish_add_path (find "$HOME/.sdkman/candidates/maven/current/bin" -maxdepth 0)
fish_add_path (find "$HOME/.sdkman/candidates/gradle/current/bin" -maxdepth 0)
