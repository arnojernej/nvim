-- rempaing <space> to open file in nvim-tree
local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<space>', api.node.open.edit, opts('Open'))

end

local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.98

return {

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    opts = {

      git = {
        enable = false,
      },
      on_attach = my_on_attach,
      filters = {
        dotfiles = false,  -- if you want to show dotfiles, set this to true
        custom = {
          '.git',
          'node_modules',
          '__pycache__',
          '.cache',
          '.vscode',
          '.idea',
          '.DS_Store',
          '.venv',
          '.pytest_cache',
          '.mypy_cache',
          '.tox',
          '.next',
        },
      },

      -- update to root dir
      update_focused_file = {
        enable = true,
      },
      respect_buf_cwd = true,

      -- center window like telescope
      view = {
        float = {
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * WIDTH_RATIO
            local window_h = screen_h * HEIGHT_RATIO
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w - window_w) / 2
            - vim.opt.cmdheight:get()
            return {
              border = 'rounded',
              relative = 'editor',
              row  = 2,
              col = center_x,
              width = window_w_int,
              height = window_h_int,
            }
          end,
        },
        width = function()
          return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
      },
    },
    init = function()

    -- NvimTree
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "NvimTree",
      callback = function()
        -- Close nvim-tree with ESC
        vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", ":NvimTreeClose<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_hl(0, 'NvimTreeSignColumn', { bg = "none" })
      end
    })

    -- Open file explorer
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })



    end
  },

}
