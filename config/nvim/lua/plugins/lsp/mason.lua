return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = require('config.window_config').border,
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    -- build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      ensure_installed = {
        'pyright',
        'gopls',
        'bashls',
        'cssls',
        'efm',
        'gradle_ls',
        'groovyls',
        'html',
        'kotlin_language_server',
        'lua_ls',
        'rust_analyzer',
        'stylelint_lsp',
        'tsserver',
        'typst_lsp',
      },
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    opts = {
      ensure_installed = {
        'autopep8',
        'eslint_d',
        'vale',
        'fixjson',
        'google-java-format',
        'htmlbeautifier',
        'java-debug-adapter',
        'jq',
        'jsonlint',
        'markdownlint',
        'prettier',
        'shellcheck',
        'shfmt',
        'yamllint',
      }
    }
  }
}
