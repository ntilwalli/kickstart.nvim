return {
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      -- list of servers for mason to install
      ensure_installed = {
        'lua_ls',
      },
    },
    dependencies = {
      {
        'williamboman/mason.nvim',
        opts = {},
      },
      {
        'neovim/nvim-lspconfig',
        config = function()
          vim.lsp.set_log_level 'DEBUG'

          local capabilities = require('blink.cmp').get_lsp_capabilities()
          vim.lsp.config('*', {
            capabilities = capabilities,
          })

          -- Configure lua_ls, mason-lspconfig will do the enablement
          vim.lsp.config('lua_ls', {
            settings = {
              Lua = {
                completion = { callSnippet = 'Replace' },
                -- diagnostics = { disable = { 'missing-fields' } },
              },
            },
          })
          -- This is installed globally and does not need configuration
          -- (nvim-lspconfig default should work fine):q
          vim.lsp.enable 'vue_ls'

          vim.lsp.config('vtsls', {
            filetypes = {
              'javascript',
              'javascriptreact',
              'javascript.jsx',
              'typescript',
              'typescriptreact',
              'typescript.tsx',
              'vue',
            },
            settings = {
              vtsls = {
                tsserver = {
                  globalPlugins = {
                    {
                      name = '@vue/typescript-plugin',
                      location = './node_modules/@vue/typescript-plugin',
                      languages = { 'vue' },
                      enableForWorkspaceTypeScriptVersions = true,
                    },
                  },
                },
              },
            },
          })
          vim.lsp.enable 'vtsls'
        end,
      },
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'prettier', -- prettier formatter
        'stylua', -- lua formatter
      },
    },
    dependencies = {
      'williamboman/mason.nvim',
    },
  },
}
