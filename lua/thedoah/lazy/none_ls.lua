return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                -- formatters
                null_ls.builtins.formatting.stylua,
                -- linters
            }
        })

        vim.keymap.set('n','<leader>gf', vim.lsp.buf.format,{})
    end
}
