local extensions = {
    'coc-tsserver',
    'coc-eslint',
    
    'coc-cmake',
    'coc-clangd',

    'coc-yaml',

    'coc-calc',
    'coc-spell-checker',
    
    -- to be install when needed on the new machine
    -- '@nomicfoundation/coc-solidity',
    -- 'coc-rust-analyzer',
}

return {
    "neoclide/coc.nvim",
    branch = "release",
    run = "yarn install --frozen-lockfile",
    init = function()
        vim.g.coc_global_extensions = extensions

        local keyset = vim.keymap.set

        local function show_documentation()
            if vim.fn.CocAction("hasProvider", "hover") then
                vim.fn.CocActionAsync("doHover")
            else
                vim.fn.feedkeys("h", "in")
            end
        end

        keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
        keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

        local opts = {silent = true, nowait = true, expr = true}
        keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
        keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
        keyset("i", "<C-f>",
               'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
        keyset("i", "<C-b>",
               'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
        keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
        keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


        keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
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
