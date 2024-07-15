require("generic.set")

if os.getenv("NVIM_PROFILE") == "bare" then
    require("bare.init")
elseif os.getenv("NVIM_PROFILE") == "sandbox" then
    vim.env.XDG_CONFIG_HOME = os.getenv("XDG_CONFIG_HOME")

    print ("Sandbox mode: ".. vim.fn.getcwd())
    print ("Config: ".. vim.env.XDG_CONFIG_HOME)

    -- Get the current runtime paths
    local rtp = vim.api.nvim_list_runtime_paths()

    -- Filter out paths that start with '~' or 'C:\\Users'
    local filtered_rtp = {}
    for _, path in ipairs(rtp) do
        if not path:match("^~") and not path:match("^C:\\Users") then
            table.insert(filtered_rtp, path)
        end
    end

    table.insert(filtered_rtp, vim.env.XDG_CONFIG_HOME)
    table.insert(filtered_rtp, vim.env.XDG_CONFIG_HOME .. "\\nvim\\lua")

    -- Rebuild the runtime path
    vim.o.runtimepath = table.concat(filtered_rtp, ",")

    vim.env.XDG_DATA_HOME = vim.env.XDG_CONFIG_HOME .. "/.sandbox/local/share"
    vim.env.XDG_STATE_HOME = vim.env.XDG_CONFIG_HOME .. "/.sandbox/.local/state"
    vim.env.XDG_CACHE_HOME = vim.env.XDG_CONFIG_HOME .. "/.sandbox/.cache"

    local package_path = os.getenv("XDG_CONFIG_HOME") .. "\\nvim\\"
    package.path = package.path .. ';'
    package.path = package.path .. package_path .. '?.lua;'
    package.path = package.path .. package_path .. '?\\init.lua'

    require("generic.bootstrap_lazy")
else
    require("generic.bootstrap_lazy")
end

require("generic.remap")
require("generic.cmds")
require("system.hiyank")
