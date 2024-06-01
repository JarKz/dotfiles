return {
  "folke/trouble.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/which-key.nvim",
  },
  config = function()
    require("plugins.keymap.trouble")
    require("trouble").setup()
  end
}
