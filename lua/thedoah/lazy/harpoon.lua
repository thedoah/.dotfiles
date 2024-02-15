return {
	"ThePrimeagen/harpoon",
	
	dependecies = { "plenary" },

	config = function()
		local mark = require('harpoon.mark')
		local ui = require('harpoon.ui')
		
        vim.keymap.set('n', '<leader>a', mark.add_file)
        vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu)
        
        --vim.keymap.set('n', '<leader>y', function() ui.nav_file(1) end)
	end
}
