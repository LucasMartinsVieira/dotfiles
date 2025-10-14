return {
  weather = {
    --- API Key
    key = "",
    --- Coordinates
    coordinates = {
      "", --- lat
      "", --- lon
    },
  },
  user = {
    -- Your Wallpapers directory
    wallpapers_dir = "~/Pictures/Wallpapers/",
    -- Your main disk
    main_disk = "/dev/mapper/cryptroot",
  },
  apps = {
    -- Default Applications
    app_launcher = "rofi -show drun -show-icons",
    browser = "librewolf",
    terminal_emulator = "kitty",
    file_manager = "kitty lf",
  },
}
