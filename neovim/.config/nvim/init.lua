local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("general_setting")
require("build_and_run_config")
require("key_bindings")

require("lazy").setup({
    -- themes
    "NLKNguyen/papercolor-theme",
    "mhartington/oceanic-next",
    -- {
    -- 	"EdenEast/nightfox.nvim",
    -- 	opts = {
    -- 		options = {
    -- 			transparent = true,
    -- 		},
    -- 	},
    -- 	init = function()
    -- 		vim.cmd.colorscheme("nordfox")
    -- 	end,
    -- },
    {
        "https://github.com/sainnhe/sonokai",
        init = function()
            vim.g.sonokai_style = "andromeda"
            vim.g.sonokai_transparent_background = 1
            vim.g.sonokai_enable_italic = 1
            vim.g.sonokai_diagnostic_virtual_text = "highlighted"
            vim.cmd.colorscheme("sonokai")
        end,
    },

    "neomake/neomake",

    {
        "terrortylor/nvim-comment",
        config = function(lzPlugin, opts)
            require("nvim_comment").setup(opts)
        end,
    },

    {
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
    },

    {
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
    },

    {
        "dense-analysis/ale",
        enabled = false,
    },

    "leafgarland/typescript-vim",

    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = function()
            local function neomake_status()
                if vim.fn.exists(":Neomake") == 0 then
                    return ""
                end
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
                    lualine_c = { neomake_status },
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
    },

    {
        "nvim-telescope/telescope.nvim",
        version = "^0.1.2",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        init = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.git_files, {})
            vim.keymap.set("n", "<leader>faf", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
        end,
    },

    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        init = function()
            vim.keymap.set(
                "n",
                "<leader>ft", -- t for tree
                ":Telescope file_browser<CR>",
                { noremap = true }
            )
            vim.keymap.set(
                "n",
                "<leader>Ft", -- t for tree
                ":Telescope file_browser respect_gitignore=0<CR>",
                { noremap = true }
            )
            local fb_actions = require("telescope._extensions.file_browser.actions")
            require("telescope").setup({
                extensions = {
                    file_browser = {
                        mappings = {
                            ["i"] = {
                                ["<A-a>"] = fb_actions.toggle_respect_gitignore,
                            },
                            ["n"] = {
                                [",a"] = fb_actions.toggle_respect_gitignore,
                            },
                        },
                    },
                },
            })
            require("telescope").load_extension("file_browser")
        end,
    },

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

    { "posva/vim-vue" },
    { "udalov/kotlin-vim" },
    -- use { 'dense-analysis/ale' }
})

local function init()
    require("config_module")
    require("general_setting")
    require("key_bindings")
    require("build_and_run_config")
    require("lsp")
    require("lines")
end
