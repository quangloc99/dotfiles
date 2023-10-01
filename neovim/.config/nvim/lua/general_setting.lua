local cmd, opt = vim.cmd, vim.opt
local keyset = vim.keymap.set

vim.g.mapleader = ','

keyset('n', '<leader>w', ':w<cr>')

-- Empty line indentation
-- https://vim.fandom.com/wiki/Get_the_correct_indent_for_new_lines_despite_blank_lines
-- There might be more, but these are frequently used so this is just a quick fix.
-- keyset('i', '<CR>', '<CR>x<BS>')
-- keyset('n', 'o', 'ox<BS>')
-- keyset('n', 'O', 'Ox<BS>')

-- quick switch to windows
keyset('n', '<C-H>', '<C-W>h')
keyset('n', '<C-J>', '<C-W>j')
keyset('n', '<C-K>', '<C-W>k')
keyset('n', '<C-L>', '<C-W>l')

-- quick tab switch
keyset('n', '<A-j>', 'gT')
keyset('n', '<A-k>', 'gt')

opt.relativenumber = true
opt.termguicolors = true
opt.background = 'dark'
-- cmd.colorscheme 'PaperColor'
-- cmd.colorscheme 'OceanicNext'
-- cmd.colorscheme 'nordfox'

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


cmd [[
hi Normal guibg=NONE ctermbg=NONE
hi! NonText guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
]]
