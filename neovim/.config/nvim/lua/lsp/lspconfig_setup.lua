local M = {}

-- local opts = { noremap = true, silent = true }
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

---On attach function. The actual implementation is in ./on_attach.lua
---for dynamic reloading
---@param client any
---@param bufnr number
---@return nil
function M.on_attach(client, bufnr)
    return require('lsp/on_attach').on_attach(client, bufnr)
end

--[[
Server installation:
- https://github.com/sumneko/lua-language-server/wiki/Getting-Started#command-line
- On archlinux: yay -S lua-language-server
--]]
function M.setup_lua()
    require('lspconfig').lua_ls.setup {
        on_attach = M.on_attach,
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim' },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    }
end

--[[
Server Installation:
npm install -g typescript typescript-language-server
--]]
function M.setup_ts()
    require('lspconfig').tsserver.setup {
        on_attach = M.on_attach
    }
end

M.setup_lua()
-- M.setup_ts()

return M
