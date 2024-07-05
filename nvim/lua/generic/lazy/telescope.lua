local function cfg()
    local telescope = require("telescope")
    local actions = require('telescope.actions')

    local default_opts = {
        layout_strategy = 'vertical',
        layout_config = { width=0.8 },
        mappings = {
            i = {
                ["<C-q>"]   = actions.smart_send_to_qflist, -- move into remap.lua
            },
        }
    }

    local select_opts = {
        layout_strategy = "vertical",
        layout_config = {
            prompt_position = "bottom",
            vertical = {
                width = 0.8,
                height = 0.2,
            },
        },
    }

    local extensions = {
        recent_files = {
            only_cwd  = true,
        },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
                select_opts
            }
        }
    }

    telescope.load_extension("recent_files")
    telescope.load_extension("ui-select")

    telescope.setup({ defaults = default_opts, extensions = extensions })
end

return { 
    { 
        "nvim-telescope/telescope.nvim", 
        config = cfg,
        dependencies = 
        { 
            "plenary", 
            "smartpde/telescope-recent-files",
            "nvim-telescope/telescope-ui-select.nvim",
        }, 
    }, 
}
