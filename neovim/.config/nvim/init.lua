local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

local function init()
    require 'config_module'
    require 'general_setting'
    require 'key_bindings'
    require 'build_and_run_config'
    require 'lsp'
    require 'lines'
end

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'NLKNguyen/papercolor-theme'
    use 'mhartington/oceanic-next'

    use 'neomake/neomake'

    use 'terrortylor/nvim-comment'
    require('nvim_comment').setup()

    use 'ms-jpq/chadtree'

    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'

    use {
        'neoclide/coc.nvim',
        branch = 'release',
        run = 'yarn install --frozen-lockfile',
    }

    use 'leafgarland/typescript-vim'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }

    use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end

    init()
end)
