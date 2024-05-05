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
    {
        "AlexvZyl/nordic.nvim",
        enabled = false,
        lazy = false,
        priority = 1000,
        opts = {
            bold_keywords = true,
            transparent_bg = true,
            bright_border = true,
            reduce_blue = false,
            swap_backgrounds = true,
            cursorline = {
                -- Bold font in cursorline.
                bold = false,
                -- Bold cursorline number.
                bold_number = true,
                -- Available styles: 'dark', 'light'.
                theme = 'light',
                -- Blending the cursorline bg with the buffer bg.
                blend = 0.5,
            },
        },
        config = function(Lazy, opts)
            local nordic = require 'nordic'
            nordic.setup(opts)
            nordic.load()
        end
    }
}
