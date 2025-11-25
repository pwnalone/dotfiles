return {
  { "blink.cmp", opts = { completion = { list = { selection = { preselect = false } } } } },
  {
    "nvim-mini/mini.align",
    opts = { mappings = { start = "gaa", start_with_preview = "gap" } },
    keys = {
      { "gaa", desc = "Align" },
      { "gap", desc = "Align with Preview" },
    },
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = { use_default_keymaps = false, max_join_length = 10000 },
    keys = {
      {
        "<leader>j",
        function()
          require("treesj").toggle()
        end,
        desc = "Toggle Split/Join",
      },
      {
        "<leader>J",
        function()
          require("treesj").toggle({ split = { recursive = true } })
        end,
        desc = "Toggle Split/Join (recursively)",
      },
    },
  },
}
