return {
    {
        "jackMort/ChatGPT.nvim",
        enabled = false,
        event = "VeryLazy",
        config = function()
            require("chatgpt").setup({
                model = "gpt-4-1106-preview",
                frequency_penalty = 0,
                presence_penalty = 0,
                max_tokens = 4095,
                temperature = 0.2,
                top_p = 0.1,
                n = 1,
            })
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "folke/trouble.nvim", -- optional
            "nvim-telescope/telescope.nvim"
        }
    },
    {
        "github/copilot.vim",
        config = function()
            vim.g.copilot_filetypes = {
                ['*'] = false,
                ['javascript'] = true,
                ['typescript'] = true,
                ['lua'] = true,
                ['python'] = true,
                ['html'] = true,
                ['css'] = true,
                ['markdown'] = true,
                ['solidity'] = true,
                ['json'] = true,
                ['yaml'] = true,
                ['rust'] = true,
                ['cpp'] = true,
                ['c'] = true,
                ['java'] = true,
                ['go'] = true,
                ['fish'] = true,
                ['vim'] = true,
            }
            vim.keymap.set("i", "<C-J>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
        end,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        enabled = false,
        dependencies = {
            { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
        },
        -- See Commands section for default commands if you want to lazy load on them
    }
}
