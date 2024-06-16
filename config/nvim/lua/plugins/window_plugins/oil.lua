return {
  {
    'stevearc/oil.nvim',
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "folke/which-key.nvim"
    },
    opts = {
      delete_to_trash = true,
    },
    config = function(opts)
      require("oil").setup(opts)
      require("plugins.keymap.oil")
    end,
  }
}
