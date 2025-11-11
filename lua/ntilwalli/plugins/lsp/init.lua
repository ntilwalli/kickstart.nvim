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
          -- If you are using mason.nvim, you can get the ts_plugin_path like this
          -- For Mason v1,
          -- local mason_registry = require('mason-registry')
          -- local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'
          -- For Mason v2,
          -- local vue_language_server_path = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server'
          -- or even
          -- local vue_language_server_path = vim.fn.stdpath('data') .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

          -- IMPORTANT: nvchad users cannot use `$MASON` directly as the option is set to `skip`, see: https://github.com/NvChad/NvChad/blob/29ebe31ea6a4edf351968c76a93285e6e108ea08/lua/nvchad/configs/mason.lua#L4
          local vue_language_server_path = '/Users/ntilwalli/.nvm/versions/node/v16.20.2/lib/node_modules/@vue/language-server'
          local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
          local vue_plugin = {
            name = '@vue/typescript-plugin',
            location = vue_language_server_path,
            languages = { 'vue' },
            configNamespace = 'typescript',
          }
          local vtsls_config = {
            settings = {
              vtsls = {
                tsserver = {
                  globalPlugins = {
                    vue_plugin,
                  },
                },
              },
            },
            filetypes = tsserver_filetypes,
          }

          local vue_ls_config = {}
          vim.lsp.config('vtsls', vtsls_config)
          vim.lsp.config('vue_ls', vue_ls_config)
          vim.lsp.enable { 'vtsls', 'vue_ls' } -- If using `ts_ls` replace `vtsls` to `ts_ls`
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
