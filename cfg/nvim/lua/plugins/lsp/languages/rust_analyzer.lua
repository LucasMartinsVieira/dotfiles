return {
  settings = {
    ["rust-analyzer"] = {
      procMacro = { enable = true },
      cargo = { allFeatures = true },
      check = {
        command = "clippy",
      },
      checkOnSave = {
        command = "clippy",
        extraArgs = { "--no-deps" },
      },
      inlayHints = {
        enabled = true,
        locationLinks = false,
      },
    },
  },
}
