local cfg = function()
    -- https://github.com/ThePrimeagen/harpoon/issues/523
    local harpoon = require("harpoon")
    local Path = require("plenary.path")
    local function normalize_path(buf_name, root)
        return Path:new(buf_name):make_relative(root)
    end

    local opts = {
        default = {
            create_list_item = function(config, name)
                name = name
                or normalize_path(
                vim.api.nvim_buf_get_name(
                vim.api.nvim_get_current_buf()
                ),
                config.get_root_dir()
                )

                local bufnr = vim.fn.bufnr(name, false)
                local pos = { 1, 0 }
                if bufnr ~= -1 then
                    pos = vim.api.nvim_win_get_cursor(0)
                end

                return {
                    value = vim.fn.expand('%:p'),
                    context = {
                        row = pos[1],
                        col = pos[2],
                        name = name
                    },
                }
            end,
            display = function(list_item)
                local name = list_item.context.name

                local windowWidth = vim.api.nvim_win_get_width(0)
                local ui_fallback_width = 69;
                local ui_width_ratio = 0.62569;

                local truncateAt = math.floor(windowWidth * ui_width_ratio)

                if truncateAt < ui_fallback_width then
                    truncateAt = ui_fallback_width
                end

                if (string.len(name) >= truncateAt) then
                    name = Path:new(name):shorten(2)
                end

                return name
            end,

        }
    }

    harpoon:setup(opts)
end

return {
    {
        'ThePrimeagen/harpoon',
        branch = "harpoon2",
        config = cfg,
    },
}
