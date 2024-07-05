local cfg = function()
    local opts = {
        menu = {
            width = 100,
        },
    }

    require("harpoon").setup(opts)
end

return {
    {
        'ThePrimeagen/harpoon',
        config = cfg,
    },
}
