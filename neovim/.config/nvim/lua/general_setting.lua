require 'config_module'.register(...)

local cmd, opt = vim.cmd, vim.opt

opt.termguicolors = true
opt.background = 'dark'
-- cmd.colorscheme 'PaperColor'
cmd.colorscheme 'OceanicNext'
cmd [[
hi Normal guibg=NONE ctermbg=NONE
hi! NonText guibg=NONE ctermbg=NONE
]]

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

-- function setup_statusline()
--     local RIGHT_ARROW_CHAR = string.char(0xe0b1)
--     local LEFT_ARROW_CHAR = string.char(0xe0b3)
--     local BAR_CHAR = string.char(0x2502)
--     local MINOR_SLASH_CHAR = string.char(0x2571)
--    
--     function neomake_status()
--         if vim.fn.exists(':Neomake') ~= 0 then
--             return ''
--         end
--        
--         return "Neomake: " .. s:MINOR_SLASH_CHAR  .. ' ' .. vim.fn['neomake#statusline#get'](g:actual_curbuf, {
--           \ 'format_running': '… ({{running_job_names}})',
--           \ 'format_loclist_ok': '✓',
--           \ 'format_quickfix_ok': '',
--           \ 'format_quickfix_issues': '%s',
--           \ })
--     end
-- end
