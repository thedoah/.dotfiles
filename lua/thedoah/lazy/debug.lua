return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "leoluz/nvim-dap-go",
        "mxsdev/nvim-dap-vscode-js",
        {
            "microsoft/vscode-js-debug",
            build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
        },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        require("dapui").setup()
        -- golang dapgo setup default is enough to debug with basic functionality
        require("dap-go").setup()

        require("dap-vscode-js").setup({
            adapters = {
                "pwa-node",
            },
            debugger_path = vim.fn.resolve(vim.fn.stdpath('data') .. "/lazy/vscode-js-debug"),
        })

        --dap.adapters["pwa-node"] = {
        --    type = "server",
        --    host = "127.0.0.1",
        --    --port = "3000", --let both ports be the same for now...
        --}
        local js_based_languages = {
            "typescript", "javascript",
        }
        for _, language in ipairs(js_based_languages) do
            dap.configurations[language] = {
                {
                    type = "pwa-node",
                    request = "launch",
                    name = "Launch file",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                    sourceMaps = true,
                    skipFiles = { "<node_internals>/**", "node_modules/**" },
                },
                {
                    type = "pwa-node",
                    request = "attach",
                    name = "Attach",
                    processId = require 'dap.utils'.pick_process,
                    cwd = "${workspaceFolder}",
                },
            }
        end

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        vim.keymap.set('n', '<leader>du', dapui.toggle)
        vim.keymap.set("n", "<leader>dx", dapui.close, {})

        -- Set keymaps to control the debugger
        vim.keymap.set('n', '<F5>', require 'dap'.continue)
        vim.keymap.set('n', '<F10>', require 'dap'.step_over)
        vim.keymap.set('n', '<F11>', require 'dap'.step_into)
        vim.keymap.set('n', '<F12>', require 'dap'.step_out)
        vim.keymap.set('n', '<leader>db', require 'dap'.toggle_breakpoint)
        vim.keymap.set('n', '<leader>dB', function()
            require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end)
    end,
}
