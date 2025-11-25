-- Sync to the primary selection only, rather than to the regular clipboard.
vim.opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamed"

-- Highlight the colorcolumn.
vim.opt.colorcolumn = "+0"

-- Do not hide markup syntax.
vim.opt.conceallevel = 0

-- The LazyVim "extra" for Python uses Pyright by default, but Basedpyright
-- includes many features and improvements that Microsoft reserved only for
-- their closed-source VSCode-exclusive Pylance extension, plus some
-- enhancements that are not available, even with Pylance.
vim.g.lazyvim_python_lsp = "basedpyright"
