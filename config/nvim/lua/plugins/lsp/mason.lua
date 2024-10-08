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
        'bashls',
        'cssls',
        'efm',
        'gradle_ls',
        'groovyls',
        'html',
        'lua_ls',
        'stylelint_lsp',
        'tsserver',
        'typst_lsp',
        'nil_ls',
        'jdtls'
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
        'ktfmt',
        'ktlint',
        'htmlbeautifier',
        'java-debug-adapter',
        'jq',
        'jsonlint',
        'markdownlint',
        'prettier',
        'shellcheck',
        'shfmt',
        'yamllint',
        'nixpkgs-fmt'
      }
    }
  }
}
