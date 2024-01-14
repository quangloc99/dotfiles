local M = {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    opts = function()
        local lualine_c = {}

        if vim.fn.exists(":Neomake") ~= 0 then
            local function neomake_status()
                local curbuff = vim.fn.bufnr("%")
                local res = "Neomake ("
                    .. curbuff
                    .. "): "
                    .. vim.fn["neomake#statusline#get"](curbuff, {
                        format_running = "… ({{running_job_names}})",
                        format_loclist_ok = "✓",
                        format_quickfix_ok = "",
                        format_quickfix_issues = "%s",
                    })
                return res
            end
            table.insert(lualine_c, neomake_status)
        end

        if vim.fn.exists(":codeium#Complete()") then
            local function codeium_status()
                return vim.api.nvim_call_function("codeium#GetStatusString", {})
            end
            table.insert(lualine_c, codeium_status)
        end

        return {
            options = {
                globalstatus = true,
                always_divide_middle = false,
                -- theme = "OceanicNext",
                theme = "auto",
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = lualine_c,
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            winbar = {
                lualine_a = { "filename" },
                lualine_b = {},
                lualine_c = {
                    function()
                        return " "
                    end,
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            inactive_winbar = {
                lualine_a = { "filename" },
                lualine_b = {},
                lualine_c = {
                    function()
                        return " "
                    end,
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        }
    end,
}

return M
