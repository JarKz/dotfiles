return {
  "booperlv/nvim-gomove",
  keys = {
    remap = false,
    nowait = false,
    -- Move
    { "<S-h>", "<Plug>GoVSMLeft",  desc = "Move visual left", mode = "x" },
    { "<S-j>", "<Plug>GoVSMDown",  desc = "Move visual down", mode = "x" },
    { "<S-k>", "<Plug>GoVSMUp",    desc = "Move visual up", mode = "x" },
    { "<S-l>", "<Plug>GoVSMRight", desc = "Move visual right", mode = "x" },
    -- Duplicate
    { "<C-h>", "<Plug>GoVSDLeft",  desc = "Duplicate visual left", mode = "x" },
    { "<C-j>", "<Plug>GoVSDDown",  desc = "Duplicate visual down", mode = "x" },
    { "<C-k>", "<Plug>GoVSDUp",    desc = "Duplicate visual up", mode = "x" },
    { "<C-l>", "<Plug>GoVSDRight", desc = "Duplicate visual right", mode = "x" },
  },
  opts = {
    -- whether or not to map default key bindings, (true/false)
    map_defaults = false,
    -- whether or not to reindent lines moved vertically (true/false)
    reindent = true,
    -- whether or not to undojoin same direction moves (true/false)
    undojoin = true,
    -- whether to not to move past end column when moving blocks horizontally, (true/false)
    move_past_end_col = false,
  },
}
