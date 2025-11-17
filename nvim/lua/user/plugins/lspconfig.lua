-- Language Server Protocol
return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'b0o/schemastore.nvim',
    -- { 'nvimtools/none-ls.nvim', dependencies = 'nvim-lua/plenary.nvim' },
    -- 'jayp0521/mason-null-ls.nvim',
  },
  config = function()
    -- Setup Mason to automatically install LSP servers
    require('mason').setup({
      ui = {
        height = 0.8,
      },
    })

    -- Global capabilities (assuming cmp_nvim_lsp is available; adjust if needed)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- If using nvim-cmp, uncomment and adjust:
    -- local cmp_nvim_lsp = require('cmp_nvim_lsp')
    -- capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    -- PHP
    vim.lsp.config('intelephense', {
      commands = {
        IntelephenseIndex = {
          function()
            vim.lsp.buf.execute_command({ command = 'intelephense.index.workspace' })
          end,
        },
      },
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        -- client.server_capabilities.documentFormattingProvider = false
        -- client.server_capabilities.documentRangeFormattingProvider = false
        -- if client.server_capabilities.inlayHintProvider then
        --   vim.lsp.buf.inlay_hint(bufnr, true)
        -- end
      end,
    })

    -- Vue, JavaScript, TypeScript
    vim.lsp.config('vue_ls', {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        -- if client.server_capabilities.inlayHintProvider then
        --   vim.lsp.buf.inlay_hint(bufnr, true)
        -- end
      end,
    })

    vim.lsp.config('ts_ls', {
      capabilities = capabilities,
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
            languages = {"javascript", "typescript", "vue"},
          },
        },
      },
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "vue",
      },
    })

    -- Tailwind CSS
    vim.lsp.config('tailwindcss', {
      capabilities = capabilities,
    })

    -- JSON
    vim.lsp.config('jsonls', {
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
        },
      },
    })

    -- Lua
    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          workspace = {
            checkThirdParty = false,
            library = {
              '${3rd}/luv/library',
              unpack(vim.api.nvim_get_runtime_file('', true)),
            },
          }
        }
      }
    })

    -- require('lspconfig').eslint.setup({
    --   capabilities = capabilities,
    --   on_attach = function(client, bufnr)
    --     vim.api.nvim_create_autocmd("BufWritePre", {
    --       buffer = bufnr,
    --       command = "EslintFixAll",
    --     })
    --   end,
    --   handlers = {
    --     ['textDocument/publishDiagnostics'] = function() end
    --   }
    -- })

    -- null-ls (commented out; if using none-ls in 0.11+, adjust accordingly)
    -- local null_ls = require('null-ls')
    -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    -- null_ls.setup({
    --   temp_dir = '/tmp',
    --   sources = {
    --     -- null_ls.builtins.diagnostics.eslint_d.with({
    --     --   condition = function(utils)
    --     --     return utils.root_has_file({ '.eslintrc.js' })
    --     --   end,
    --     -- }),
    --     -- null_ls.builtins.diagnostics.phpstan, -- TODO: Only if config file
    --     null_ls.builtins.diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),
    --     -- null_ls.builtins.formatting.eslint_d.with({
    --     --   condition = function(utils)
    --     --     return utils.root_has_file({ '.eslintrc.js', '.eslintrc.json' })
    --     --   end,
    --     -- }),
    --     null_ls.builtins.formatting.pint.with({
    --       condition = function(utils)
    --         return utils.root_has_file({ 'vendor/bin/pint' })
    --       end,
    --     }),
    --     -- null_ls.builtins.formatting.prettier.with({
    --     --   condition = function(utils)
    --     --     return utils.root_has_file({ '.prettierrc', '.prettierrc.json', '.prettierrc.yml', '.prettierrc.js', 'prettier.config.js' })
    --     --   end,
    --     -- }),
    --   },
    --   on_attach = function(client, bufnr)
    --     if client.supports_method("textDocument/formatting") then
    --       vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    --       vim.api.nvim_create_autocmd("BufWritePre", {
    --         group = augroup,
    --         buffer = bufnr,
    --         callback = function()
    --           vim.lsp.buf.format({
    --             filter = function(client)
    --               return client.name == "null-ls"
    --             end,
    --             bufnr = bufnr,
    --             timeout_ms = 5000
    --           })
    --         end,
    --       })
    --     end
    --   end,
    -- })
    -- require('mason-null-ls').setup({ automatic_installation = true })

    -- Setup mason-lspconfig: Auto-install and auto-enable servers
    require('mason-lspconfig').setup({
      ensure_installed = {
        'intelephense',
        'vue_ls',
        'ts_ls',
        'tailwindcss',
        'jsonls',
        'lua_ls',
        -- Add more servers as needed
      },
      automatic_enable = true,  -- Automatically enable all installed servers with vim.lsp.enable()
      -- Optional: Custom setup_handlers callback for additional logic after each server setup
      setup_handlers = function(default_handler, server_name)
        -- Run the default handler first
        default_handler(server_name)
        -- Add custom logic here if needed, e.g.:
        -- if server_name == 'lua_ls' then
        --   -- Extra lua_ls config
        -- end
      end,
    })

    -- Keymaps
    vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
    vim.keymap.set('n', 'gd', ':Telescope lsp_definitions<CR>')
    vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
    vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
    vim.keymap.set('n', '<Leader>lr', ':LspRestart<CR>', { silent = true })
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

    -- Commands
    -- vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format({
    --   filter = function(client)
    --     return client.name == "null-ls"
    --   end,
    --   timeout_ms = 5000
    -- }) end, {})

    -- Diagnostic configuration
    vim.diagnostic.config({
      virtual_text = false,
      float = {
        source = true,
      }
    })

    -- Sign configuration
    vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
    vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
    vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
    vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
  end,
}
