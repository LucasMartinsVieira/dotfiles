vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

return packer.startup(function(use)
  
  --Plugins to support other plugins 
  use({ "nvim-lua/popup.nvim" })
  use({ "nvim-lua/plenary.nvim" })
  use({ "wbthomason/packer.nvim" })

  -- Colorschemes
  use({ "Mofiqul/dracula.nvim" })
  use({ "bluz71/vim-nightfly-guicolors" })
  use({ "romgrk/doom-one.vim" })
  use({ "tanvirtin/monokai.nvim" })
  use({ "maxmx03/solarized.nvim" })

  -- FZF
  use({ "junegunn/fzf" })

  -- ToggleTerm
  use({ "akinsho/toggleterm.nvim" })

  -- AutoPairs
  use({ "jiangmiao/auto-pairs" })
  
  -- indent Blankline
  use("lukas-reineke/indent-blankline.nvim")

  -- Vim wiki
  use({ "vimwiki/vimwiki" })

  -- Zen Mode
  use({ "folke/zen-mode.nvim" })

  -- Dashboard (Alpha)
  use({
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  })
  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    requires = { { "nvim-lua/plenary.nvim" } },
  })

  use({
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({})
    end,
  })


  -- Markdown preview
  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  })

  -- Auto complete
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "quangnguyen30192/cmp-nvim-ultisnips",
    },
  })

  -- Snippets
  use({ "L3MON4D3/LuaSnip" })
  use({ "rafamadriz/friendly-snippets" })
  use({ "honza/vim-snippets" })

  -- LSP
  use({ "neovim/nvim-lspconfig", requires = "williamboman/nvim-lsp-installer" })

  -- Better lights on syntax
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use({ "p00f/nvim-ts-rainbow" })

  -- Comments
  use({ "JoosepAlviste/nvim-ts-context-commentstring" })
  use({ "numToStr/Comment.nvim" })

  -- Git
  use({ "lewis6991/gitsigns.nvim" })

  -- Null-ls
  use({ "jose-elias-alvarez/null-ls.nvim" })

  -- Lualine
  use({ "nvim-lualine/lualine.nvim" })

  -- Nvim-tree
  use({ "kyazdani42/nvim-tree.lua" })

  -- Errors
  use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" })

  -- Color Highlighter
  use({ "norcalli/nvim-colorizer.lua" })
end)
