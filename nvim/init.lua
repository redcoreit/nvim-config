require("generic.set")
require("generic.remap")
require("generic.cmds")
require("system.hiyank")

local profile = os.getenv("NVIM_PROFILE")

if profile == "bare" then
    require("bare.init")
elseif profile == "local" then
    vim.env.XDG_CONFIG_HOME = os.getenv("XDG_CONFIG_HOME")
    vim.env.XDG_DATA_HOME = vim.env.XDG_CONFIG_HOME .. "/.sandbox/local/share"
    vim.env.XDG_STATE_HOME = vim.env.XDG_CONFIG_HOME .. "/.sandbox/.local/state"
    vim.env.XDG_CACHE_HOME = vim.env.XDG_CONFIG_HOME .. "/.sandbox/.cache"

    require("generic.bootstrap_lazy")
elseif profile == "default" then
    vim.env.XDG_CONFIG_HOME = os.getenv("XDG_CONFIG_HOME")
    vim.env.XDG_DATA_HOME = vim.env.XDG_CONFIG_HOME .. "/.sandbox/local/share"
    vim.env.XDG_STATE_HOME = vim.env.XDG_CONFIG_HOME .. "/.sandbox/.local/state"
    vim.env.XDG_CACHE_HOME = vim.env.XDG_CONFIG_HOME .. "/.sandbox/.cache"

    require("generic.bootstrap_lazy")
else
    require("generic.bootstrap_lazy")
end

-- https://github.com/gbprod/yanky.nvim
