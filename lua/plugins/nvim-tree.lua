local ext,nvimtree = pcall(require, 'nvim-tree')

nvimtree.setup { -- BEGIN_DEFAULT_OPTS
  git = {
    ignore = false,
  },
}
-- END_DEFAULT_OPTS
