[CmdletBinding()]
Param()

$Path = "$PSScriptRoot"
$Cmd = "cd '$Path\nvim'; `$ENV:NVIM_PROFILE='sandbox'; nvim -i NONE -u 'init.lua' --cmd 'set rtp+=$Path/nvim'"
Write-Verbose $Cmd

pwsh -NoProfile -Command $Cmd
