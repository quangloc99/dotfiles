return {
    "terrortylor/nvim-comment",
    config = function(lzPlugin, opts)
        require("nvim_comment").setup(opts)
    end,
}
