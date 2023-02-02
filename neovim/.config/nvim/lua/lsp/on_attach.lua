require 'config_module'.register(...)
local keybinds = require 'key_bindings'

local M = {}

---@param bufnr number
function M.cmp_setup_buffer(bufnr)
    local cmp = require 'cmp'
    local config = require 'cmp.config'

    config.set_buffer({
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            end,
        },
        window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
        }, {
            { name = 'path' }
        })
    }, bufnr)
end

-- Use an `on_attach` function to only map the following keys
-- after the language server attaches to the current buffer
---@param client any
---@param bufnr number
function M.on_attach(client, bufnr)
    keybinds.lsp_on_attach_keys(client, bufnr)
    M.cmp_setup_buffer(bufnr)
end

return M
