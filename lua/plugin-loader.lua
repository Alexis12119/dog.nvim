local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if vim.fn.isdirectory(lazypath) == 0 then
  vim.notify("Installing lazy...", vim.log.levels.INFO)
  vim.fn.system {
    "git",
    "clone",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)


local opts = {
  git = {
    -- defaults for the `Lazy log` command
    -- log = { "-10" }, -- show the last 10 commits
    log = { "--since=3 days ago" }, -- show commits from the last 3 days
    timeout = 300, -- kill processes that take more than 2 minutes
    url_format = "https://github.com/%s.git",
  },
  lockfile = vim.fn.stdpath "data" .. "/lazy-lock.json", -- lockfile generated after running update.
  concurrency = nil, ---@type number limit the maximum amount of concurrent tasks
  dev = {
    -- directory where you store your local plugin projects
    path = "~/projects",
    ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
    patterns = {}, -- For example {"folke"}
  },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "dull", "habamax" },
  },
  ui = {
    -- a number <1 is a percentage., >1 is a fixed size
    size = { width = 0.8, height = 0.8 },
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "rounded",
    icons = {
      cmd = " ",
      config = "",
      event = "",
      ft = " ",
      init = " ",
      keys = " ",
      plugin = " ",
      runtime = " ",
      source = " ",
      start = "",
      task = "✔ ",
    },
    throttle = 20, -- how frequently should the ui process render events
    custom_keys = {},
    diff = {
      -- diff command <d> can be one of:
      -- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
      --   so you can have a different command for diff <d>
      -- * git: will run git diff and open a buffer with filetype git
      -- * terminal_git: will open a pseudo terminal with git diff
      -- * diffview.nvim: will open Diffview to show the diff
      cmd = "git",
    },
  },

  checker = {
    -- automatically check for plugin updates
    enabled = false,
    concurrency = nil, ---@type number? set to 1 to check for updates very slowly
    notify = true, -- get a notification when new updates are found
    frequency = 3600, -- check for updates every hour
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = false, -- get a notification when changes are found
  },
  -- lazy can generate helptags from the headings in markdown readme files,
  -- so :help works even for plugins that don't have vim docs.
  -- when the readme opens with :help it will be correctly displayed as markdown
  performance = {
    cache = {
      enabled = true,
      path = vim.fn.stdpath "state" .. "/lazy/cache",
      -- Once one of the following events triggers, caching will be disabled.
      -- To cache all modules, set this to `{}`, but that is not recommended.
      -- The default is to disable on:
      --  * VimEnter: not useful to cache anything else beyond startup
      --  * BufReadPre: this will be triggered early when opening a file from the command line directly
      disable_events = { "VimEnter", "BufReadPre" },
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = false, -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        -- "tarPlugin",
        -- "tohtml",
        -- "tutor",
        -- "zipPlugin",
      },
    },
  },
}
local plugins = {

  { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      "j-hui/fidget.nvim",

      -- Additional lua configuration, makes nvim stuff amazing
      "folke/neodev.nvim",
    },
  },

  
  -- Git related plugins
  -- DPK
  -- {'tpope/vim-fugitive'},
  -- {'tpope/vim-rhubarb'},
  -- {'lewis6991/gitsigns.nvim'},

  {
    "navarasu/onedark.nvim",
    config = function()
      vim.cmd [[colorscheme onedark]]
    end,
  }, -- Theme inspired by Atom
  { "nvim-lualine/lualine.nvim" }, -- Fancier statusline
  -- {'lukas-reineke/indent-blankline.nvim'}, -- Add indentation guides even on blank lines
  -- {'numToStr/Comment.nvim'}, -- "gc" to comment visual regions/lines
  { "tpope/vim-sleuth" }, -- Detect tabstop and shiftwidth automatically

  -- Fuzzy Finder (files, lsp, etc)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = vim.fn.executable "make" == 1,
      },
    },
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
}

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

lazy.setup("plugins", opts)
