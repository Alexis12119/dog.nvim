return {
  "nvim-lualine/lualine.nvim",
  -- Set lualine as statusline
  -- See `:help lualine.txt`

  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = false,
        theme = "onedark",
        component_separators = "|",
        section_separators = "",
      },
    })
  end,
} -- Fancier statusline
