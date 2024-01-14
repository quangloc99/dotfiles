return {
    { "tpope/vim-fugitive" },

    {
        "lewis6991/gitsigns.nvim",
        opts = {
            numhl = true,
            word_diff = true,
            linehl = true,
            update_debounce = 500,
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]c", function()
                    if vim.wo.diff then
                        return "]c"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true })

                map("n", "[c", function()
                    if vim.wo.diff then
                        return "[c"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true })

                -- Actions
                map("n", "<leader>hs", gs.stage_hunk)
                map("n", "<leader>hr", gs.reset_hunk)
                map("v", "<leader>hs", function()
                    gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end)
                map("v", "<leader>hr", function()
                    gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end)
                map("n", "<leader>hS", gs.stage_buffer)
                map("n", "<leader>hu", gs.undo_stage_hunk)
                map("n", "<leader>hR", gs.reset_buffer)
                map("n", "<leader>hp", gs.preview_hunk)
                map("n", "<leader>hb", function()
                    gs.blame_line({ full = true })
                end)
                map("n", "<leader>tb", gs.toggle_current_line_blame)
                map("n", "<leader>hd", gs.diffthis)
                map("n", "<leader>hD", function()
                    gs.diffthis("~")
                end)
                map("n", "<leader>td", gs.toggle_deleted)

                -- Text object
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
            end,
        },
    },

    {
        "tanvirtin/vgit.nvim",
        enabled = false,
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function(lzPlugin, opts)
            require("vgit").setup(opts)
        end,
        init = function()
            vim.o.updatetime = 1000
            vim.o.incsearch = false
            vim.o.signcolumn = "yes"

            vim.keymap.set("n", "<leader>gd", ":VGit hunk_down<CR>", { noremap = true })
            vim.keymap.set("n", "<leader>gu", ":VGit hunk_up<CR>", { noremap = true })
            vim.keymap.set("n", "<leader>gbd", ":VGit buffer_diff_preview<CR>", { noremap = true })
            vim.keymap.set("n", "<leader>gpd", ":VGit project_diff_preview<CR>", { noremap = true })
            vim.keymap.set("n", "<leader>ghs", ":VGit buffer_hunk_stage<CR>", { noremap = true })
            vim.keymap.set(
                "n",
                "<leader>G",
                ":VGit ", -- just open up and let the wild menu do the rest.
                { noremap = true }
            )
        end,
    },
}
