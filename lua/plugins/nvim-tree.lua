return function ()
	local ext,nvimtree = pcall(require, 'nvim-tree')

	nvimtree.setup { -- BEGIN_DEFAULT_OPTS
	git = {
		ignore = false,
	},
}
end
