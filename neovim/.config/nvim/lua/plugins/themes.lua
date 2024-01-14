return {
    {
        "NLKNguyen/papercolor-theme",
        enabled = false,
        init = function()
            vim.cmd.colorscheme("papercolor")
        end,
    },
    {
        "mhartington/oceanic-next",
        enabled = false,
        init = function()
            vim.cmd.colorscheme("oceanic")
        end,
    },
    {
        "EdenEast/nightfox.nvim",
        enabled = false,
        opts = {
            options = {
                transparent = true,
            },
        },
        init = function()
            vim.cmd.colorscheme("nordfox")
        end,
    },
    {
        "https://github.com/sainnhe/sonokai",
        enabled = true,
        init = function()
            vim.g.sonokai_style = "andromeda"
            vim.g.sonokai_transparent_background = 1
            vim.g.sonokai_enable_italic = 1
            vim.g.sonokai_diagnostic_virtual_text = "highlighted"
            vim.cmd.colorscheme("sonokai")
        end,
    },
}
