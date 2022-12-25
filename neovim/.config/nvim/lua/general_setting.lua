require 'config_module'.register(...)

local cmd, opt = vim.cmd, vim.opt

opt.termguicolors = true
opt.background = 'dark'
-- cmd.colorscheme 'PaperColor'
cmd.colorscheme 'OceanicNext'

opt.backspace = '2'
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.scrolloff = 5

opt.autowrite = true
opt.autoindent = true
opt.cindent = true
opt.number = true
opt.ruler = true
opt.showcmd = true

opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.splitbelow = true
opt.splitright = true

opt.cursorline = true
opt.scroll = 8
opt.wildmenu = true
opt.hlsearch = true
cmd.nohls()
opt.cc = { 120 }
opt.wrap = false

opt.foldmethod = 'marker'
opt.mouse = 'a'

opt.clipboard:append 'unnamedplus'

-- vimsense
-----------
vim.g.vimsence_client_id = '439476230543245312'
vim.g.vimsence_small_text = 'NeoVim'
vim.g.vimsence_small_image = 'neovim'
vim.g.vimsence_editing_details = 'Editing the future'
vim.g.vimsence_editing_state = 'Working on self-improvement'
vim.g.vimsence_file_explorer_text = 'In NERDTree'
vim.g.vimsence_file_explorer_details = 'Looking for life purposes'


-- cmd [[
-- hi Normal guibg=NONE ctermbg=NONE
-- hi! NonText guibg=NONE ctermbg=NONE
-- hi EndOfBuffer guibg=NONE ctermbg=NONE
-- ]]
