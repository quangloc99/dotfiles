return {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    init = function()
        vim.keymap.set(
            "n",
            "<leader>ft", -- t for tree
            ":Telescope file_browser<CR>",
            { noremap = true }
        )
        vim.keymap.set(
            "n",
            "<leader>Ft", -- t for tree
            ":Telescope file_browser respect_gitignore=0<CR>",
            { noremap = true }
        )
        local fb_actions = require("telescope._extensions.file_browser.actions")
        require("telescope").setup({
            extensions = {
                file_browser = {
                    mappings = {
                        ["i"] = {
                            ["<A-a>"] = fb_actions.toggle_respect_gitignore,
                        },
                        ["n"] = {
                            [",a"] = fb_actions.toggle_respect_gitignore,
                        },
                    },
                },
            },
        })
        require("telescope").load_extension("file_browser")
    end,
}
