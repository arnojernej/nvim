if not vim.g.vscode then
   -- [[ Configure LSP ]]
   --  This function gets run when an LSP connects to a particular buffer.
   local on_attach = function(_, bufnr)
      -- NOTE: Remember that lua is a real programming language, and as such it is possible
      -- to define small helper and utility functions so you don't have to repeat yourself
      -- many times.
      --
      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local nmap = function(keys, func, desc)
         if desc then
            desc = 'LSP: ' .. desc
         end

         vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('R', vim.lsp.buf.rename, '[R]e[n]ame')
      nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

      nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
      nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
      nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
      nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      -- See `:help K` for why this keymap
      nmap('<leader>i', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- vim.api.nvim_create_autocmd("CursorHold", {
      --    pattern = "*",
      --    callback = function()
      --       vim.lsp.buf.hover()
      --    end,
      -- })

      -- Lesser used LSP functionality
      nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
      nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
      nmap('<leader>wl', function()
         print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, '[W]orkspace [L]ist Folders')

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
         vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
   end

   -- Enable the following language servers
   --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
   --
   --  Add any additional override configuration in the following tables. They will be passed to
   --  the `settings` field of the server config. You must look up that documentation yourself.
   local servers = {
      -- clangd = {},
      -- gopls = {},
      -- rust_analyzer = {},
      jsonls = {},
      pyright = {},
      tsserver = {},
      omnisharp = {},
      -- jdtls = {},
      -- lua_ls = {
      --    Lua = {
      --       workspace = { checkThirdParty = false },
      --       telemetry = { enable = false },
      --    },
      -- },
   }

   -- Setup neovim lua configuration
   require('neodev').setup()

   -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
   local capabilities = vim.lsp.protocol.make_client_capabilities()
   capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

   -- Ensure the servers above are installed
   local mason_lspconfig = require 'mason-lspconfig'

   mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
   }

   mason_lspconfig.setup_handlers {
      function(server_name)
         require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
         }
      end,
   }

   -- [[ Configure nvim-cmp ]]
   -- See `:help cmp`
   local cmp = require 'cmp'
   local luasnip = require 'luasnip'
   require('luasnip.loaders.from_vscode').lazy_load()
   luasnip.config.setup {}

   cmp.setup {
      snippet = {
         expand = function(args)
            luasnip.lsp_expand(args.body)
         end,
      },
      window = {
         completion = cmp.config.window.bordered(), -- Adds border to the completion window
         documentation = cmp.config.window.bordered(), -- Adds border to the documentation window
      },
      mapping = cmp.mapping.preset.insert {
         ['<C-n>'] = cmp.mapping.select_next_item(),
         ['<C-p>'] = cmp.mapping.select_prev_item(),
         ['<C-d>'] = cmp.mapping.scroll_docs(-4),
         ['<C-f>'] = cmp.mapping.scroll_docs(4),
         ['<C-Space>'] = cmp.mapping.complete {},
         ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
         },
      },
      sources = {
         { name = 'nvim_lsp' },
         { name = 'nvim_lua' },
         { name = 'luasnip' },
         {
            name = 'path',
            option = {
               -- Options go into this table
            },
         },
         {
            name = 'buffer',
            option = {
               -- Options go into this table
            },
         },
      },
   }

   local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
   local null_ls = require("null-ls")
   null_ls.setup({
      sources = {
         null_ls.builtins.formatting.prettierd,
         -- python
         null_ls.builtins.formatting.black.with({
            -- extra_args = { "--line-length=120" }
         }),
         --null_ls.builtins.formatting.isort,
      },

      on_attach = function(client, bufnr)
         if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
               group = augroup,
               buffer = bufnr,
               callback = function()
                  -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                  -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                  -- vim.lsp.buf.formatting_sync()
                  vim.lsp.buf.format({ async = false })
               end,
            })
         end
      end,

   })

   vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
      config = config or {
         border = "rounded",
      }
      config.focus_id = ctx.method
      if not (result and result.contents) then
         return
      end
      local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
      markdown_lines = vim.split(vim.fn.trim(vim.fn.join(markdown_lines, "\n")), "\n")
      if vim.tbl_isempty(markdown_lines) then
         return
      end
      return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
   end

end
