local function fuzzy_regex_pattern(term)
  return term:gsub(".", function(c)
    return vim.pesc(c) .. ".*"
  end)
end

-- Usage:
local regex = fuzzy_regex_pattern("executor")  --> "e.*x.*e.*c.*u.*t.*o.*r"
local function multigrep()
    local pickers = require "telescope.pickers"
    local finders = require "telescope.finders"
    local make_entry = require "telescope.make_entry"
    local conf = require "telescope.config".values

    local M = {}

    local live_multigrep = function(opts)
        opts = opts or {}
        opts.cwd = opts.cwd or vim.uv.cwd()

        local finder = finders.new_async_job {
            command_generator = function(prompt)
                if not prompt or prompt == "" then
                    return nil
                end

                local pieces = vim.split(prompt, "  ")
                local name_filter = pieces[1]
                local content_filter = pieces[2]

                if not pieces[1] or pieces[1] == "" then
                    return nil
                end

                -- Base: file matching part
                local cmd = string.format(
                    'rg --files  --color=never --no-heading --with-filename --smart-case | rg "%s" --color=never --no-heading --no-line-number --no-column --smart-case',
                    pieces[1]
                    --fuzzy_regex_pattern(pieces[1])
                )

                -- If second part is present, filter file list by content
                if pieces[2] and pieces[2] ~= "" then
                    cmd = string.format(
                        '%s | rg "%s" --color=never --no-heading --no-line-number --no-column --smart-case',
                        cmd,
                        pieces[2]
                    )
                end

                -- Only file filter
                return { "pwsh", "-NoProfile", "-Command", cmd }
            end,
            entry_maker = make_entry.gen_from_file(opts),
            cwd = opts.cwd,
        }

        pickers.new(opts, {
            debounce = 100,
            prompt_title = "Multi Grep",
            finder = finder,
            previewer = conf.file_previewer(opts),
            sorter = require("telescope.sorters").empty(),
        }):find()
    end

    M.setup = function()
        vim.keymap.set("n", "<leader>\\", live_multigrep)
    end

    return M
end

-----------

local function cfg()
    local telescope = require("telescope")
    local actions = require('telescope.actions')
    local multigrep = multigrep()
    multigrep.setup()

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
