local cfg = function()
    vim.o.exrc = false

    local opts = {
        files = {
            ".exrc.lua",
        },
    }

    require("exrc").setup(opts)
end

return {
    {
        "MunifTanjim/exrc.nvim",
        config = cfg
    }
}
