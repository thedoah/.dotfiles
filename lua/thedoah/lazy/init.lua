return{
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false, --load during start up
		priority = 1000, --load before all
		config = function()
			vim.cmd("colorscheme rose-pine")
		end
	},
	{
		"nvim-lua/plenary.nvim",
		name = "plenary"
	},
	
	"github/copilot.vim"

}

