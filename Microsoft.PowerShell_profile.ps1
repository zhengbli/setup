cd C:\github

# Load Jump-Location profile
Import-Module PSColor
Import-Module ZLocation
Import-Module posh-git

# $ErrorView="CategoryView"

function gs() {git status -uno}
function glog() {git log --pretty=format:"%h %s [%an @ %ad]" --graph --date=short}
function reloadEnv() { $env:Path=[System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") }

New-Alias c code.cmd
New-Alias ci code-insiders.cmd
#New-Alias code C:\Users\lizhe\Documents\github\vscode\scripts\code.bat

function fixCode () 
{
    Copy-Item "C:\Users\lizhe\Documents\WindowsPowerShell\code-insiders.cmd" -Destination "C:\Program Files (x86)\Microsoft VS Code Insiders\bin\code-insiders.cmd";
}

function updateTmlanguage() {
    Copy-Item "C:\Github\TypeScript-Tmlizheguage\TypeScript.tmlanguage" -Destination "C:\Github\TypeScript-Sublime-Plugin\TypeScript.tmlanguage"
    Copy-Item "C:\Github\TypeScript-Tmlizheguage\TypeScriptReact.tmlanguage" -Destination "C:\Github\TypeScript-Sublime-Plugin\TypeScriptReact.tmlanguage"
}

$env:PATH=$env:PATH + ";" + "C:\Program Files\Sublime Text 3;" + "C:\Program Files\Beyond Compare 4;"

function CsDebugJs($file)
{
    cscript "/E:{16d51579-a30b-4c8b-a276-0ff4dc41e755}" /x "C:\Users\lizhe\Documents\github\TypeScript\built\local\tsc.js" $file --allowJs
}
function CsDebug($file, $config)
{
    cscript "/E:{16d51579-a30b-4c8b-a276-0ff4dc41e755}" /x "C:\Users\lizhe\Documents\github\TypeScript\built\local\tsc.js" $file $config
}
function j-cl ()
{
	jake clean local
}
function j-r($t)
{
	jake runtests t=$t
}
function j-rb($t)
{
	jake runtests-browser t=$t
}
function j-lint()
{
	jake lint
}
function tsclocal()
{
	node "C:\github\TypeScript\built\local\tsc.js" $args
}
function updateTs() 
{
	npm install typescript@next -g
}

Enable-GitColors
$global:GitPromptSettings.BeforeText = '§'
$global:GitPromptSettings.AfterText = '§'


function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    # Reset color, which can be messed up by Enable-GitColors
    # $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    Write-Host "$ENV:USERNAME" -NoNewline -ForegroundColor Yellow
    Write-Host "@" -NoNewline -ForegroundColor DarkGray
    Write-Host "$ENV:COMPUTERNAME" -NoNewline -ForegroundColor Magenta

    # if (Test-Administrator) {  # Use different username if elevated
    #     # Write-Host "(!)" -NoNewline -ForegroundColor White
    # }

    # if ($s -ne $null) {  # color for PSSessions
    #     Write-Host " (`$s: " -NoNewline -ForegroundColor DarkGray
    #     Write-Host "$($s.Name)" -NoNewline -ForegroundColor Yellow
    #     Write-Host ") " -NoNewline -ForegroundColor DarkGray
    # }

    Write-Host " : " -NoNewline -ForegroundColor DarkGray
    # Write-Host (Get-Date -Format T) -NoNewline -ForegroundColor DarkGray
    # Write-Host " : " -NoNewline -ForegroundColor DarkGray
    Write-Host $($(Get-Location) -replace "C:\\Users\\lizhe", "~") -NoNewline -ForegroundColor Gray
    Write-Host " " -NoNewline -ForegroundColor DarkGray

    $global:LASTEXITCODE = $realLASTEXITCODE

    Write-VcsStatus
    Write-Host ""

    return "> "
}
cls
# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

function power() { control powercfg.cpl }