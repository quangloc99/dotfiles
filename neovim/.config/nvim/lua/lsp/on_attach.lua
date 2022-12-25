require 'config_module'.register(...)
local keybinds = require 'key_bindings'

local M = {}

---comment
-- Use an `on_attach` function to only map the following keys
-- after the language server attaches to the current buffer
---@param client any
---@param bufnr number
function M.on_attach(client, bufnr)
    keybinds.lsp_on_attach_keys(client, bufnr)
end

return M
