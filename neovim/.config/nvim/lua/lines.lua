require 'config_module'.register(...)

---@type string
local module_name = ...
local M = {
    module_name = module_name
}

local function neomake_status()
    if vim.fn.exists(':Neomake') == 0 then
        return ''
    end
    local res = 'Neomake: ' .. vim.fn['neomake#statusline#get'](vim.g.actual_curbuf, {
        format_running = '… ({{running_job_names}})',
        format_loclist_ok = '✓',
        format_quickfix_ok = '',
        format_quickfix_issues = '%s',
    })
    print(res)
    return res
end

-- print(neomake_status())

require('lualine').setup {
    options = {
        globalstatus = true,
        always_divide_middle = false,
        theme = 'OceanicNext',
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { neomake_status },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    winbar = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = { function() return ' ' end },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    inactive_winbar = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = { function() return ' ' end },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    }
}

function M.custom_tabline()
    local result = {}
    local prv_active = true
    local current_tabpage_id = vim.fn.tabpagenr()
    local separator_char = '▎'
    for i = 1,vim.fn.tabpagenr('$') do
        local is_active = i == current_tabpage_id
        if not prv_active and not is_active then
            table.insert(result, separator_char)
        end
        prv_active = is_active
        if is_active then
            table.insert(result, '%#TabLineSel#')
        else
            table.insert(result, '%#TabLine#')
        end
    end

    return table.concat(result)
end

--[[
Old vim script tabline. Too lazy to port it to lua. 
--]]
vim.cmd [[
set tabline=%!MyTabLine()

hi! TabLine ctermbg=NONE guibg=NONE cterm=NONE gui=NONE ctermfg=232 guifg=#aaaaaa
hi! TabLineSel guifg=#d8dee9 guibg=#65737e gui=bold
hi! TabLineFill guibg=#1b2b34

function! MyTabLine()
    let s = ''
    let prv_active = 1
    let separator_char = '▎'
    for i in range(tabpagenr('$'))
        let is_active = (i + 1) == tabpagenr()
        let l:prv_active = l:is_active
        " select the highlighting
        if l:is_active
            let s ..= '%#TabLineSel#'
        else
            let s ..= '%#TabLine#'
        endif
        " if !l:prv_active && !l:is_active
            let s ..= l:separator_char
        " endif

        " set the tab page number (for mouse clicks)
        let s ..= '%' .. (i + 1) .. 'T'

        " the label is made by MyTabLabel()
        let s ..= ' %{MyTabLabel(' .. (i + 1) .. ')}'
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s ..= separator_char
    let s ..= '%#TabLineFill#%T'

    " No closing button needed
    " right-align the label to close the current tab page
    " if tabpagenr('$') > 1
        " let s ..= '%=%#TabLine#%999Xclose'
    " endif

    return s
endfunction

function! MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let bufname = bufname(buflist[winnr - 1])
    
    " No NERD_tree as name, fallback to abitary buffer's name
    if stridx(l:bufname, 'NERD_tree') != -1
        for buf in buflist
            let bufname = bufname(buf)
            if stridx(l:bufname, 'NERD_tree') == -1
                break
            endif
        endfor
    endif
    
    let bufname = l:bufname->pathshorten()
    if l:bufname->empty()
        let l:bufname = '[untitled]'
    endif
    return '[' .. a:n .. ']:' .. l:bufname .. '  '
endfunction
]]

return M
