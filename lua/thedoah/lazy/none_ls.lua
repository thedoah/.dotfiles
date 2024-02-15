return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                -- formatters
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.prettier,
                -- linters
                null_ls.builtins.formatting.eslint_d,
            }
        })

        vim.keymap.set('n','<leader>gf', vim.lsp.buf.format,{})
    end
}
