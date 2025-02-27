function ColorMyPencils(color)
   -- color = color or "nord"
   color = color or "juliana"
   -- color = color or "rose-pine"
   -- color = color or "rose-pine-moon"

   vim.cmd.colorscheme(color)

   -- vim.api.nvim_set_hl(0, "Normal", { bg = "#2f343f" })
   vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
   vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

   vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })

   -- vim.api.nvim_set_hl(0, "Comment", { fg = "#3b4252", bg = "#88c0d0"}) -- FIXME
   -- vim.api.nvim_set_hl(0, "Spell", { fg = "#3b4252", bg = "#88c0d0"}) -- FIXME

   vim.api.nvim_set_hl(0, "Search", { bg = "#4c566a"})
   vim.api.nvim_set_hl(0, "IncSearch", { bg = "#4c566a"})
   vim.api.nvim_set_hl(0, "CurSearch", { fg = "#3b4252", bg = "#88c0d0"})

   vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
   vim.api.nvim_set_hl(0, "LineNr", { fg = "#a6acb9", bg = "none" })

   vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#95b2d6" })
   vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#95b2d6" })
   vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName", { fg = "#95b2d6" })
   vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#fac761" })

   vim.api.nvim_set_hl(0, 'LspReferenceText', { bg = '#3b4252', underline = true })
   vim.api.nvim_set_hl(0, 'LspReferenceRead', { bg = '#3b4252', underline = true })
   vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = '#3b4252', underline = true })

   -- vim.api.nvim_set_hl(0, "@tag.tsx", { fg = "#81a1c1"}) -- blue
   -- vim.api.nvim_set_hl(0, "@tag.delimiter.tsx", { fg = "#81a1c1"}) -- blue
   -- vim.api.nvim_set_hl(0, "@constructor.tsx", { fg = "#88c0d0"}) -- lightblue
   -- vim.api.nvim_set_hl(0, "@tag.attribute.tsx", { fg = "#88c0d0"}) -- lightblue

   vim.api.nvim_set_hl(0, "@keyword", { fg = "#5fb4b4"}) -- lightblue
   vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = "#c695c6"}) -- lightblue
   vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = "#c695c6"}) -- lightblue
   vim.api.nvim_set_hl(0, "@type", { fg = "#81a1c1"}) -- blue
   vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { link = "Conceal" })

end

return {

   {
      -- color theme
      'kaiuri/nvim-juliana',
      lazy = false,
      opts = { --[=[ configuration --]=] },
      config = function()
         ColorMyPencils("juliana")
      end,
   },

   -- { 'shaunsingh/nord.nvim' },

   -- {
   --    "rose-pine/neovim", name = "rose-pine",
   --    opts = {
   --       styles = {
   --          transparency = true,
   --       },
   --       highlight_groups = {
   --          TelescopeBackground = { bg = "none" },
   --          TelescopeBorder = { fg = "highlight_high", bg = "none" },
   --          TelescopeNormal = { bg = "none" },
   --          TelescopePromptNormal = { bg = "none" },
   --          TelescopeResultsNormal = { fg = "subtle", bg = "none" },
   --          TelescopeSelection = { fg = "text", bg = "none" },
   --          TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
   --          CurSearch = { fg = "base", bg = "rose", inherit = false },
   --          Search = { bg = "rose", blend = 20, inherit = false },
   --       },
   --    },
   --    config = function()
   --       ColorMyPencils("rose-pine-moon")
   --    end,
   -- },

   -- {
   --    "folke/tokyonight.nvim",
   --    lazy = false,
   --    priority = 1000,
   --    opts = {},
   -- },

}
