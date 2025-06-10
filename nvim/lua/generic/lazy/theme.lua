local mono_cfg = function()
    vim.cmd("colorscheme monochrome")

    -- transparent background
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })

    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { fg = '#ff5555', bg = nil })
    vim.api.nvim_set_hl(0, 'LspDiagnosticsVirtualTextError', { fg = '#ff5555', bg = nil })
    vim.api.nvim_set_hl(0, 'LspDiagnosticsSignError', { fg = '#ff5555', bg = nil })
    vim.api.nvim_set_hl(0, 'LspDiagnosticsFloatingError', { fg = '#ff5555', bg = nil })
    vim.api.nvim_set_hl(0, 'LspDiagnosticsUnderlineError', { fg = '#ff5555', bg = nil })

    -- inlay hints
    vim.api.nvim_set_hl(0, 'LspInlayHint', { fg = '#494949', italic = true })

    vim.api.nvim_create_autocmd("User", {
        pattern = "LazyDone",
        once = true,
        callback = function()
            -- Set the transparency of floating windows
            vim.cmd[[
                set winblend=20
            ]]	
        end,
    })
end


local rose_pine_cfg = function()
    require("rose-pine").setup({
        styles = {
            transparency = true,
        },
    })

    --vim.cmd("colorscheme rose-pine")

    vim.api.nvim_create_autocmd("User", {
        pattern = "LazyDone",
        once = true,
        callback = function()
            -- Set the transparency of floating windows
            vim.cmd[[
                set winblend=20
            ]]	
        end,
    })
end

return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = rose_pine_cfg,
    },
    {
        "kdheepak/monochrome.nvim",
        name = "monochrome",
        config = mono_cfg,
    }
}

