return {

   { -- Main LSP Configuration

      'neovim/nvim-lspconfig',
      dependencies = {
         -- Automatically install LSPs and related tools to stdpath for Neovim
         { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
         'williamboman/mason-lspconfig.nvim',
         'WhoIsSethDaniel/mason-tool-installer.nvim',

         -- Useful status updates for LSP.
         {
            'j-hui/fidget.nvim',
            opts = {
               progress = { display = { done_style = 'Normal' } },
               notification = { window = { winblend = 0, normal_hl = 'Comment' } },
            },
         },

         -- Allows extra capabilities provided by nvim-cmp
         'hrsh7th/cmp-nvim-lsp',
      },
      config = function()
         -- Brief aside: **What is LSP?**
         --
         -- LSP is an initialism you've probably heard, but might not understand what it is.
         --
         -- LSP stands for Language Server Protocol. It's a protocol that helps editors
         -- and language tooling communicate in a standardized fashion.
         --
         -- In general, you have a "server" which is some tool built to understand a particular
         -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
         -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
         -- processes that communicate with some "client" - in this case, Neovim!
         --
         -- LSP provides Neovim with features like:
         --  - Go to definition
         --  - Find references
         --  - Autocompletion
         --  - Symbol Search
         --  - and more!
         --
         -- Thus, Language Servers are external tools that must be installed separately from
         -- Neovim. This is where `mason` and related plugins come into play.
         --
         -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
         -- and elegantly composed help section, `:help lsp-vs-treesitter`

         --  This function gets run when an LSP attaches to a particular buffer.
         --    That is to say, every time a new file is opened that is associated with
         --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
         --    function will be executed to configure the current buffer
         vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            callback = function(event)
               -- NOTE: Remember that Lua is a real programming language, and as such it is possible
               -- to define small helper and utility functions so you don't have to repeat yourself.
               --
               -- In this case, we create a function that lets us more easily define mappings specific
               -- for LSP related items. It sets the mode, buffer and description for us each time.
               local map = function(keys, func, desc, mode)
                  mode = mode or 'n'
                  vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
               end

               -- Jump to the definition of the word under your cursor.
               --  This is where a variable was first declared, or where a function is defined, etc.
               --  To jump back, press <C-t>.
               map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

               -- Find references for the word under your cursor.
               -- map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
               map('gr', function()
                  require('telescope.builtin').lsp_references { include_declaration = false, show_line = false }
               end, '[G]oto [R]eferences')

               -- Jump to the implementation of the word under your cursor.
               --  Useful when your language has ways of declaring types without an actual implementation.
               map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

               -- Jump to the type of the word under your cursor.
               --  Useful when you're not sure what type a variable is and you want to see
               --  the definition of its *type*, not where it was *defined*.
               map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

               -- Fuzzy find all the symbols in your current document.
               --  Symbols are things like variables, functions, types, etc.
               map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

               -- Fuzzy find all the symbols in your current workspace.
               --  Similar to document symbols, except searches over your entire project.
               map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

               -- Rename the variable under your cursor.
               --  Most Language Servers support renaming across files, etc.
               map('R', vim.lsp.buf.rename, '[R]e[n]ame')

               map('<leader>i', vim.lsp.buf.hover, 'Hover Documentation')
               map('<leader>d', vim.diagnostic.open_float, 'Hover Diagnostic')

               -- Execute a code action, usually your cursor needs to be on top of an error
               -- or a suggestion from your LSP for this to activate.
               map('<leader>.', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

               -- WARN: This is not Goto Definition, this is Goto Declaration.
               --  For example, in C this would take you to the header.
               map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

               -- The following two autocommands are used to highlight references of the
               -- word under your cursor when your cursor rests there for a little while.
               --    See `:help CursorHold` for information about when this is executed
               --
               -- When you move your cursor, the highlights will be cleared (the second autocommand).
               -- local client = vim.lsp.get_client_by_id(event.data.client_id)
               -- if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
               --   local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
               --   vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
               --     buffer = event.buf,
               --     group = highlight_augroup,
               --     callback = vim.lsp.buf.document_highlight,
               --   })
               --
               --   vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
               --     buffer = event.buf,
               --     group = highlight_augroup,
               --     callback = vim.lsp.buf.clear_references,
               --   })
               --
               --   vim.api.nvim_create_autocmd('LspDetach', {
               --     group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
               --     callback = function(event2)
               --       vim.lsp.buf.clear_references()
               --       vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
               --     end,
               --   })
               -- end
               --
               -- The following code creates a keymap to toggle inlay hints in your
               -- code, if the language server you are using supports them
               --
               -- This may be unwanted, since they displace some of your code
               if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                  map('<leader>th', function()
                     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                  end, '[T]oggle Inlay [H]ints')
               end
            end,
         })

         -- LSP servers and clients are able to communicate to each other what features they support.
         --  By default, Neovim doesn't support everything that is in the LSP specification.
         --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
         --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
         local capabilities = vim.lsp.protocol.make_client_capabilities()
         capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

         -- Enable the following language servers
         --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
         --
         --  Add any additional override configuration in the following tables. Available keys are:
         --  - cmd (table): Override the default command used to start the server
         --  - filetypes (table): Override the default list of associated filetypes for the server
         --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
         --  - settings (table): Override the default settings passed when initializing the server.
         --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
         local servers = {
            -- clangd = {},
            -- gopls = {},
            -- pyright = {},
            -- rust_analyzer = {},
            -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
            --
            -- Some languages (like typescript) have entire language plugins that can be useful:
            --    https://github.com/pmizio/typescript-tools.nvim
            --
            -- But for many setups, the LSP (`tsserver`) will work just fine
            -- tsserver = {},
            prettierd = {
               tabWidth = 2,
               useTabs = false,
            },

            lua_ls = {
               -- cmd = {...},
               -- filetypes = { ...},
               -- capabilities = {},
               settings = {
                  Lua = {
                     completion = {
                        callSnippet = 'Replace',
                     },
                     -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                     -- diagnostics = { disable = { 'missing-fields' } },
                     diagnostics = {
                        globals = { 'vim' },
                     },
                  },
               },
            },
         }

         -- Ensure the servers and tools above are installed
         --  To check the current status of installed tools and/or manually install
         --  other tools, you can run
         --    :Mason
         --
         --  You can press `g?` for help in this menu.
         require('mason').setup {
            ui = {
               border = 'rounded',
            },
         }

         -- You can add other tools here that you want Mason to install
         -- for you, so that they are available from within Neovim.
         local ensure_installed = vim.tbl_keys(servers or {})
         vim.list_extend(ensure_installed, {
            'stylua', -- Used to format Lua code
         })
         require('mason-tool-installer').setup { ensure_installed = ensure_installed }

         require('mason-lspconfig').setup {
            handlers = {
               function(server_name)
                  local server = servers[server_name] or {}
                  -- This handles overriding only values explicitly passed
                  -- by the server configuration above. Useful when disabling
                  -- certain features of an LSP (for example, turning off formatting for tsserver)
                  server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                  require('lspconfig')[server_name].setup(server)
               end,
            },
         }

         -- Custom hover handler that trims blank lines from the hover text
         vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = 'rounded', -- Optional: Set rounded borders if desired
            -- Custom formatting to trim leading/trailing blank lines
            focusable = false,
         })
      end,
   },

   { -- Autocompletion
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
         -- Snippet Engine & its associated nvim-cmp source
         {
            'L3MON4D3/LuaSnip',
            build = (function()
               -- Build Step is needed for regex support in snippets.
               -- This step is not supported in many windows environments.
               -- Remove the below condition to re-enable on windows.
               if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                  return
               end
               return 'make install_jsregexp'
            end)(),
            dependencies = {
               -- `friendly-snippets` contains a variety of premade snippets.
               --    See the README about individual language/framework/plugin snippets:
               --    https://github.com/rafamadriz/friendly-snippets
               {
                  'rafamadriz/friendly-snippets',
                  config = function()
                     require('luasnip.loaders.from_vscode').lazy_load()
                     require('luasnip').filetype_extend('typescriptreact', { 'tsdoc' })
                     require('luasnip').filetype_extend('typescript', { 'tsdoc' })
                  end,
               },
            },
         },
         'saadparwaiz1/cmp_luasnip',

         -- Adds other completion capabilities.
         --  nvim-cmp does not ship with all sources by default. They are split
         --  into multiple repos for maintenance purposes.
         'hrsh7th/cmp-nvim-lsp',
         'hrsh7th/cmp-path',
         'hrsh7th/cmp-buffer',

         -- Adds icons to the completion menu
         'onsails/lspkind.nvim',
      },

      config = function()
         -- See `:help cmp`
         local cmp = require 'cmp'
         local luasnip = require 'luasnip'
         luasnip.config.setup {}

         local lspkind = require 'lspkind'

         cmp.setup {

            snippet = {
               expand = function(args)
                  luasnip.lsp_expand(args.body)
               end,
            },
            completion = { completeopt = 'menu,menuone,noinsert' },

            -- For an understanding of why these mappings were
            -- chosen, you will need to read `:help ins-completion`
            --
            -- No, but seriously. Please read `:help ins-completion`, it is really good!
            mapping = cmp.mapping.preset.insert {
               -- Select the [n]ext item
               ['<C-n>'] = cmp.mapping.select_next_item(),
               -- Select the [p]revious item
               ['<C-p>'] = cmp.mapping.select_prev_item(),

               -- Scroll the documentation window [b]ack / [f]orward
               ['<C-b>'] = cmp.mapping.scroll_docs(-4),
               ['<C-f>'] = cmp.mapping.scroll_docs(4),

               -- Accept ([y]es) the completion.
               --  This will auto-import if your LSP supports it.
               --  This will expand snippets if the LSP sent a snippet.
               ['<CR>'] = cmp.mapping.confirm { select = true },

               -- Think of <c-l> as moving to the right of your snippet expansion.
               --  So if you have a snippet that's like:
               --  function $name($args)
               --    $body
               --  end
               --
               -- <c-l> will move you to the right of each of the expansion locations.
               -- <c-h> is similar, except moving you backwards.
               ['<C-l>'] = cmp.mapping(function()
                  if luasnip.expand_or_locally_jumpable() then
                     luasnip.expand_or_jump()
                  end
               end, { 'i', 's' }),
               ['<C-h>'] = cmp.mapping(function()
                  if luasnip.locally_jumpable(-1) then
                     luasnip.jump(-1)
                  end
               end, { 'i', 's' }),

               -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
               --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
            },
            sources = {
               {
                  name = 'lazydev',
                  -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
                  group_index = 0,
               },
               { name = 'nvim_lsp' },
               { name = 'luasnip' },
               { name = 'path' },
               {
                  name = 'buffer',
                  option = {
                     get_bufnrs = function()
                        return vim.api.nvim_list_bufs()
                     end,
                  },
               },
            },

            window = {
               documentation = cmp.config.window.bordered(), -- Adds border to the documentation window
               completion = {
                  winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
                  col_offset = -1,
                  side_padding = 0,
               },
            },

            formatting = {
               fields = { 'kind', 'abbr', 'menu' },

               format = function(entry, vim_item)
                  local kind = require('lspkind').cmp_format {
                     mode = 'symbol_text',
                  } (entry, vim.deepcopy(vim_item))
                  local highlights_info = require('colorful-menu').cmp_highlights(entry)

                  -- highlight_info is nil means we are missing the ts parser, it's
                  -- better to fallback to use default `vim_item.abbr`. What this plugin
                  -- offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
                  if highlights_info ~= nil then
                     vim_item.abbr_hl_group = highlights_info.highlights
                     vim_item.abbr = highlights_info.text
                  end
                  local strings = vim.split(kind.kind, '%s', { trimempty = true })
                  vim_item.kind = '' .. (strings[1] or '') .. ''
                  vim_item.menu = ''

                  return vim_item
               end,
            },

            -- formatting = {
            --    format = function(entry, vim_item)
            --       -- Set the kind icons and display both the kind and the source
            --       vim_item.kind = string.format('%s %s', lspkind.presets.default[vim_item.kind], vim_item.kind)
            --
            --       -- Set the source name (e.g., "LSP", "Buffer", "Snip")
            --       vim_item.menu = ({
            --          nvim_lsp = '[LSP]',
            --          luasnip = '[Snippet]',
            --          buffer = '[Buffer]',
            --          path = '[Path]',
            --       })[entry.source.name]
            --
            --       return vim_item
            --    end,
            -- },
         }

         vim.diagnostic.config {
            -- update_in_insert = true,
            float = {
               focusable = false,
               style = 'minimal',
               border = 'rounded',
               source = 'always',
               header = '',
               prefix = '',
            },
         }
      end,
   },

   {
      'antosha417/nvim-lsp-file-operations',
      dependencies = {
         'nvim-lua/plenary.nvim',
         -- Uncomment whichever supported plugin(s) you use
         'nvim-tree/nvim-tree.lua',
         -- "nvim-neo-tree/neo-tree.nvim",
         -- "simonmclean/triptych.nvim"
      },
      config = function()
         require('lsp-file-operations').setup()
      end,
   },

   {
      'xzbdmw/colorful-menu.nvim',
      config = function()
         -- You don't need to set these options.
         require('colorful-menu').setup {
            ls = {
               lua_ls = {
                  -- Maybe you want to dim arguments a bit.
                  arguments_hl = '@comment',
               },
               gopls = {
                  -- By default, we render variable/function's type in the right most side,
                  -- to make them not to crowd together with the original label.

                  -- when true:
                  -- foo             *Foo
                  -- ast         "go/ast"

                  -- when false:
                  -- foo *Foo
                  -- ast "go/ast"
                  align_type_to_right = true,
                  -- When true, label for field and variable will format like "foo: Foo"
                  -- instead of go's original syntax "foo Foo". If align_type_to_right is
                  -- true, this option has no effect.
                  add_colon_before_type = false,
                  -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
                  preserve_type_when_truncate = true,
               },
               -- for lsp_config or typescript-tools
               ts_ls = {
                  -- false means do not include any extra info,
                  -- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
                  extra_info_hl = '@comment',
               },
               vtsls = {
                  -- false means do not include any extra info,
                  -- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
                  extra_info_hl = '@comment',
               },
               ['rust-analyzer'] = {
                  -- Such as (as Iterator), (use std::io).
                  extra_info_hl = '@comment',
                  -- Similar to the same setting of gopls.
                  align_type_to_right = true,
                  -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
                  preserve_type_when_truncate = true,
               },
               clangd = {
                  -- Such as "From <stdio.h>".
                  extra_info_hl = '@comment',
                  -- Similar to the same setting of gopls.
                  align_type_to_right = true,
                  -- the hl group of leading dot of "•std::filesystem::permissions(..)"
                  import_dot_hl = '@comment',
                  -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
                  preserve_type_when_truncate = true,
               },
               zls = {
                  -- Similar to the same setting of gopls.
                  align_type_to_right = true,
               },
               roslyn = {
                  extra_info_hl = '@comment',
               },
               dartls = {
                  extra_info_hl = '@comment',
               },
               -- The same applies to pyright/pylance
               basedpyright = {
                  -- It is usually import path such as "os"
                  extra_info_hl = '@comment',
               },
               -- If true, try to highlight "not supported" languages.
               fallback = true,
               -- this will be applied to label description for unsupport languages
               fallback_extra_info_hl = '@comment',
            },
            -- If the built-in logic fails to find a suitable highlight group for a label,
            -- this highlight is applied to the label.
            fallback_highlight = '@variable',
            -- If provided, the plugin truncates the final displayed text to
            -- this width (measured in display cells). Any highlights that extend
            -- beyond the truncation point are ignored. When set to a float
            -- between 0 and 1, it'll be treated as percentage of the width of
            -- the window: math.floor(max_width * vim.api.nvim_win_get_width(0))
            -- Default 60.
            max_width = 60,
         }
      end,
   },
}
