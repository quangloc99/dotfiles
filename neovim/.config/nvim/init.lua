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

require("lazy").setup("plugins")

local function init()
    require("config_module")
    require("general_setting")
    require("key_bindings")
    require("build_and_run_config")
end
