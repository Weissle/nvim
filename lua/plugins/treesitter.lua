return function ()

	require'nvim-treesitter.configs'.setup {
		-- A list of parser names, or "all"
		ensure_installed = { 'c', 'lua', 'cpp', 'json', 'python', 'cmake' },

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		highlight = {
			-- `false` will disable the whole extension
			enable = true,
			additional_vim_regex_highlighting = false,
		},
	}

	require'nvim-treesitter.install'.prefer_git = true

end
