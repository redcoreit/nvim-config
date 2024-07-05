local cfg = function()
    require("rose-pine").setup({
        styles = {
            transparency = true,
        },
    })

    vim.cmd("colorscheme rose-pine")

    -- Set the transparency of floating windows
	vim.cmd([[
        set winblend=20
    ]])	
end

return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = cfg,
    }
}

