return {
    {
        "nvim-telescope/telescope.nvim",
        version = "^0.1.2",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = true,
        opts = {
            defaults = {
                layout_strategy = 'flex',
                layout_config = {
                    flip_columns = 180,
                    flip_lines = 20,
                },
            },
        },
        init = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.git_files, {})
            vim.keymap.set("n", "<leader>faf", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
        end,
    },
    { 'nvim-telescope/telescope-symbols.nvim' }
}
