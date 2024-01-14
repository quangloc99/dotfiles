return {
    "neoclide/coc.nvim",
    branch = "release",
    run = "yarn install --frozen-lockfile",
    init = function()
        local keyset = vim.keymap.set

        local function show_documentation()
            if vim.fn.CocAction("hasProvider", "hover") then
                vim.fn.CocActionAsync("doHover")
            else
                vim.fn.feedkeys("h", "in")
            end
        end

        keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })
        keyset("n", "gh", show_documentation, { silent = true })

        keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
        keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
        keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
        keyset("n", "gr", "<Plug>(coc-references)", { silent = true })

        -- Rename. Get the impression of the F2 key
        keyset("n", "<leader>2", "<Plug>(coc-rename)", { silent = true })
    end,
}
