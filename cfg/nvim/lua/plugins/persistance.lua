return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  config = function()
    require("persistence").setup({
      dir = vim.fn.stdpath("state") .. "/sessions/", -- directory where session files are saved
      -- minimum number of file buffers that need to be open to save
      -- Set to 0 to always save
      need = 1,
      branch = true, -- use git branch to save session
    })

    -- load the session for the current directory
    vim.keymap.set("n", "<leader>ks", function()
      require("persistence").load()
    end, { desc = "Load the session for current directory" })

    -- select a session to load
    vim.keymap.set("n", "<leader>kS", function()
      require("persistence").select()
    end, { desc = "Select a session to load" })

    -- load the last session
    vim.keymap.set("n", "<leader>kl", function()
      require("persistence").load({ last = true })
    end, { desc = "Load last session" })

    -- stop Persistence => session won't be saved on exit
    vim.keymap.set("n", "<leader>kd", function()
      require("persistence").stop()
    end, { desc = "Stop persistence (session won't be saved on exit)" })
  end,
  -- opts = {
  --   -- add any custom options here
  --   dir = vim.fn.stdpath("state") .. "/sessions/", -- directory where session files are saved
  --   -- minimum number of file buffers that need to be open to save
  --   -- Set to 0 to always save
  --   need = 1,
  --   branch = true, -- use git branch to save session
  -- },
}
