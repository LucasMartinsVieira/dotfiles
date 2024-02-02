# Filename: myscript.fish
function __fish_sb
    # You can use commands like `complete` to specify suggestions.
    # This function provides suggestions for the second argument based on the current input.
    # It suggests "day", "week", and "year" for the second argument, each with a separate description.

    complete -c sb -a "day" -d "Open or create daily note"
    complete -c sb -a "d" -d "Open or create daily note"
    complete -c sb -a "week" -d "Open or create weekly note"
    complete -c sb -a "w" -d "Open or create weekly note"
    complete -c sb -a "year" -d "Open or create yearly note"
    complete -c sb -a "y" -d "Open or create yearly"

    complete -c sb -a "basic" -d "Open or create basic note"
    complete -c sb -a "b" -d "Open or create basic note"
    complete -c sb -a "pr" -d "Open or create project note"
    complete -c sb -a "pg" -d "Open or create programming note"
    complete -c sb -a "cl" -d "Open or create college note"
    complete -c sb -a "cs" -d "Open or create course note"
    complete -c sb -a "ar" -d "Open or create article note"
end

# Register the completion function
complete -f -c sb -n "__fish_sb"

