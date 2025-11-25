---@module "snacks"

return {
  {
    "snacks.nvim",
    ---@type snacks.Config
    opts = {
      explorer = { trash = false },
      picker = {
        win = {
          input = {
            keys = {
              ["<M-h>"] = false,
            },
          },
          list = {
            keys = {
              ["<M-h>"] = false,
            },
          },
        },
      },
      terminal = {
        win = {
          keys = {
            nav_h = false,
            nav_j = false,
            nav_k = false,
            nav_l = false,
          },
        },
      },
    },
  },
}
