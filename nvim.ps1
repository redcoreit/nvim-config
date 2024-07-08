[CmdletBinding()]
Param()

$Path = $PSScriptRoot
$Cmd = "cd '$Path'; `$ENV:NVIM_PROFILE='sandbox'; nvim -i NONE -u '$Path/nvim/init.lua' --cmd 'set rtp+=$Path/nvim'"
Write-Verbose $Cmd

pwsh -NoProfile -Command $Cmd
