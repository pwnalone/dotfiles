return {
  {
    "monaqa/dial.nvim",
    opts = function(_, opts)
      local augend = require("dial.augend")
      return vim.tbl_deep_extend("force", opts, {
        groups = {
          default = {
            augend.constant.alias.Alpha,
            augend.constant.alias.alpha,
            augend.constant.alias.bool,
            augend.constant.alias.en_weekday,
            augend.constant.alias.en_weekday_full,
            augend.date.new({
              pattern = "%Y-%m-%d",
              only_valid = true,
              word = false,
              default_kind = "day",
            }),
            augend.date.new({
              pattern = "%Y/%m/%d",
              only_valid = true,
              word = false,
              default_kind = "day",
            }),
            augend.hexcolor.new(),
            augend.integer.alias.binary,
            augend.integer.alias.decimal,
            augend.integer.alias.hex,
            augend.integer.alias.octal,
            augend.semver.alias.semver,
          },
        },
      })
    end,
  },
  {
    "flash.nvim",
    opts = {
      modes = {
        -- Do not use in search bar.
        search = {
          enabled = false,
        },
        -- Disable ',' and ';' keys.
        char = {
          keys = {
            "f",
            "F",
            "t",
            "T",
          },
        },
      },
    },
  },
  {
    "which-key.nvim",
    opts = {
      -- Ignore ',' and ';' from the "motions" preset.
      spec = {
        { ",", mode = { "n", "x", "o" }, desc = "which_key_ignore" },
        { ";", mode = { "n", "x", "o" }, desc = "which_key_ignore" },
      },
    },
  },
  {
    "render-markdown.nvim",
    optional = true,
    opts = {
      -- Revert LazyVim's tweaks and use the defaults.
      checkbox = { enabled = true },
      code = { sign = true },
      heading = {
        sign = true,
        icons = {
          "󰲡 ",
          "󰲣 ",
          "󰲥 ",
          "󰲧 ",
          "󰲩 ",
          "󰲫 ",
        },
      },
    },
  },
  {
    "mrjones2014/smart-splits.nvim",
    --
    -- Pin to this specific commit until [this bug][1] has been fixed.
    --
    -- [1]: https://github.com/mrjones2014/smart-splits.nvim/issues/342
    --
    commit = "c4afaf23141651845e6e1966d936d79ff8939e4d",
    event = "VeryLazy",
    opts = { default_amount = 1, cursor_follows_swapped_bufs = true },
  },
}
