return {
    "sbdchd/neoformat",
    init = function()
        vim.keymap.set("n", "<leader><C-i>", ":Neoformat<cr>", { silent = true })
        vim.g.neoformat_try_node_exe = 1
        vim.g.neoformat_enabled_typescript = { "prettier" }
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            pattern = { "*.js", "*.ts" },
            callback = function()
                vim.cmd("Neoformat")
            end,
        })
    end,
}
