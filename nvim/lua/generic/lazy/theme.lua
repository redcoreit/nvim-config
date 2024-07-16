local cfg = function()
    require("rose-pine").setup({
        styles = {
            transparency = true,
        },
    })

    vim.cmd("colorscheme rose-pine")

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
        config = cfg,
    }
}

