# ================================================
# FAIRUZ PRO POWERShell PROFILE - SIMPLE EDITION (NO HEX COLOR ERROR)
# ================================================

# 1. Modules
Import-Module Terminal-Icons
Import-Module PSReadLine

# 2. Oh My Posh (tetep pakai config lu, warna default aja)
oh-my-posh init pwsh --config "C:\Users\Fairuz\themesps\japan.omp.json" | Invoke-Expression

# 3. PSReadLine – warna default (no custom hex biar aman)
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

Set-PSReadLineKeyHandler -Key Ctrl+r     -Function ReverseSearchHistory
Set-PSReadLineKeyHandler -Key UpArrow    -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow  -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab        -Function MenuComplete

# 4. Combo Counter
$env:COMBO_COUNT = 0
function global:Increment-Combo {
    $env:COMBO_COUNT = [int]$env:COMBO_COUNT + 1
}
$ExecutionContext.InvokeCommand.PreCommandLookupAction = {
    param($CommandName)
    if ($CommandName -ne 'clear' -and $CommandName -ne 'cls') {
        Increment-Combo
    }
}
function clear {
    Clear-Host
    $env:COMBO_COUNT = 0
    Write-Host "『Combo reset... 桜散る...』"
}

# 5. Alias
Set-Alias -Name g     -Value git
Set-Alias -Name ll    -Value Get-ChildItem
Set-Alias -Name la    -Value Get-ChildItem
Set-Alias -Name ls    -Value Get-ChildItem
Set-Alias -Name clr   -Value clear
Set-Alias -Name which -Value Get-Command
Set-Alias -Name touch -Value New-Item
Set-Alias -Name grep  -Value Select-String
Set-Alias -Name cat   -Value Get-Content
Set-Alias -Name open  -Value Invoke-Item

# 6. Functions
function uptime {
    $boot = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
    $up = (Get-Date) - $boot
    "$($up.Days)d $($up.Hours)h $($up.Minutes)m"
}
function pubip { try { (Invoke-RestMethod -Uri "https://api.ipify.org").Trim() } catch { "Offline" } }
function localip {
    (Get-NetIPAddress -AddressFamily IPv4 | Where-Object {
        $_.InterfaceAlias -notlike "*Loopback*" -and $_.PrefixOrigin -in 'Dhcp','Manual'
    }).IPAddress
}
function ports { Get-NetTCPConnection | Select LocalAddress,LocalPort,RemoteAddress,RemotePort,State | Sort LocalPort }
function ff { param($name) Get-ChildItem -Recurse -Include "*$name*" -ErrorAction SilentlyContinue }

# 7. Sakura Quotes
$sakura_quotes = @(
    "『血と桜が舞う…』",
    "『貴方のcombo、まだまだね…』",
    "『サイバー・スマッシュ！』",
    "『ハッカーの桜は散らない』",
    "『Rootを取れ、桜の下で』"
)
function sq { $sakura_quotes | Get-Random }

# 8. STARTUP MESSAGE DENGAN CHIBI GIRL (NO COLOR)
if (-not $env:PROFILE_LOADED) {
    Clear-Host
    Write-Host @"
⠀⠀⠀⡠⠀⡠⠊⠁⠀⠀⣠⡴⠛⠉⣠⡶⠟⠋⣥⣠⣤⡀⠀⠀⠀⠀⠀⠀⠈⠑⢦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢶⡄⠀⠀⠀⠀⠀
⠀⢀⣜⣴⠟⢀⠄⢀⠴⠊⡁⠀⣠⠞⢁⠆⢀⠜⠋⠀⠈⠛⢦⡀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣷⣄⣀⠀⠀⠀⠀⠀⠀⠈⠂⠈⠢⡀⠀⠀⠀
⠀⣾⠟⠁⠐⠁⠀⠀⡠⠊⠀⠔⠁⠀⡜⠀⠀⢀⠀⢀⠀⠀⠀⠑⣄⠀⠀⠀⠀⠀⠀⢢⣀⠈⢻⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⡀⠈⠂⡀⠀
⣼⠃⠀⠀⠀⠀⣠⢞⣠⠄⢲⢂⡔⣸⠀⠀⣠⡇⠀⠘⡇⠀⠀⠀⠈⢦⠀⠀⠀⠀⢸⠀⠈⠉⢀⣍⣈⢻⣦⠀⠀⠀⠀⠀⠀⠱⡀⠀⠘⢦
⠁⠀⠀⠀⢀⡴⠋⢘⡇⢠⡾⠋⠀⡇⠀⢠⠃⠀⠀⠀⠻⡄⠀⠀⠀⠈⠳⡀⠀⠀⠈⡆⠀⢰⡟⠁⠈⠳⣿⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠐⠁⠀⢴⡞⣡⠋⠀⠀⢸⠁⠀⠏⠀⠀⠀⠀⠀⢱⠀⠀⠀⠀⠀⠱⡄⠀⠀⠘⣄⠀⠹⡗⢤⡀⠈⠳⡄⠀⢹⡀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣠⠋⡴⠃⡄⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠹⡄⠀⠀⠈⢦⡀⠙⣄⠙⢦⣤⣾⡆⠀⣇⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣿⡞⠁⠀⡇⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠘⡄⠀⠀⠀⠀⠀⠀⢰⡀⠀⣆⠀⠱⣄⣸⡇⠀⠘⠿⢻⠀⢸⠀⠀⠀⠀⠀⠀
⠀⠀⢳⠀⣠⠟⠀⠀⠀⡇⠀⢠⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⢱⠀⠀⠀⠀⠀⠀⢸⡇⠀⡿⡄⠀⠈⢛⢧⣀⡀⠂⣸⠀⢸⠀⠀⡄⠀⠀⠀
⠀⠀⠀⠻⣏⡀⠀⠀⠀⣷⠀⢸⣿⣿⡀⢢⠀⠀⡀⠀⠀⠀⠀⢧⠀⠀⠀⡇⠀⣼⡇⢠⠇⢹⣄⠀⠘⡆⢈⠉⠛⠁⠀⢸⠀⠀⠟⢆⠀⠀
⡇⠀⣤⠀⠹⣷⡀⠀⠀⣿⡄⢸⣿⠻⣧⠈⢧⠀⠹⡀⠀⠀⠀⠈⣆⠀⠀⣧⢰⠇⡇⣸⠀⠀⠹⣆⠀⣿⣼⡄⠀⠀⠀⢸⡆⢸⠀⠘⣆⠀
⢹⡀⣿⣧⡀⠹⣷⡀⠀⢹⣷⢸⣿⡆⠹⣧⡘⣧⠀⠱⡄⠀⡀⠀⠸⡆⠀⢹⡏⢀⣿⣧⡠⠤⠴⢿⡇⣻⣿⣇⠀⠀⠀⢸⡇⡜⠀⢀⡏⠀
⠘⣧⠀⢸⣷⣄⢻⣷⣄⠈⣿⣿⣿⣉⡛⢻⡷⣿⣇⠀⢹⣦⣱⡄⠀⢹⡖⢻⠋⣹⣿⣥⣴⣶⣶⣶⣿⣿⣉⣿⡄⠀⠀⢸⣵⠃⠀⣸⡇⠀
⠀⠹⡆⢸⠻⣿⠮⢿⣿⣷⣾⣿⡿⠋⢛⣻⣿⣿⣿⣧⠈⣿⣿⣿⣦⡀⢻⣼⠘⣿⠟⠉⢴⣾⣿⣿⡟⠻⡇⢹⣧⠀⠀⣾⡏⡰⢰⡇⠀⣠
⠀⠀⠹⣼⡄⠘⣷⡀⠙⢿⣿⡿⣇⠀⠈⢻⣿⣿⡿⠻⣷⣼⡏⢻⣟⠻⣾⣿⡄⠁⠀⠀⠈⠛⠛⠋⠁⠀⢠⣿⣿⡀⢠⣿⠟⢡⣿⠃⣾⠃
⠀⠀⠀⠙⣧⠀⣿⢷⣄⢀⣹⣿⣿⣅⠀⠈⠁⠀⠀⠀⠈⣿⣿⡄⠙⠦⠘⢿⣿⣄⠀⠀⠀⠀⠀⠀⢀⣴⣫⡾⣿⡇⣼⠋⣴⣿⣿⡞⠁⠀
⠀⠀⠀⠀⠈⠀⣿⣤⣝⠋⠛⢿⣿⣿⣿⣷⡂⠀⠀⠀⠀⠀⠁⠙⢆⠀⠀⠀⠙⢌⠂⠀⠀⠀⣠⡴⢻⡿⠋⣰⣿⣷⣧⣾⣿⡿⠋⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣿⣿⣿⣧⡀⠈⠛⣿⣍⡛⠛⠓⠢⠤⠀⠀⢀⣷⠈⠀⠀⠀⠀⠀⠀⠠⠔⠋⠁⣠⣏⣴⠞⢋⣸⣿⣯⣿⣏⣀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢸⣿⣿⣷⡹⣷⣤⣽⣾⣽⣢⢤⣀⠀⠀⠀⠊⢾⣄⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⠭⠔⠒⠛⠛⠛⠿⣿⣿⡟⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣿⡟⣿⣿⣌⠻⣍⠉⠛⢿⣟⠛⠛⠓⠀⠀⢀⣈⣀⣀⡀⠀⢀⣠⡶⣿⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣆⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠘⣇⠘⣿⣿⠳⣜⢷⣄⠀⢿⣿⣦⣄⡀⠀⠀⠈⠉⠉⠉⠁⠈⣀⣴⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠂⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠈⢿⣇⠈⠳⢿⣷⣼⣿⣿⣽⣿⣶⣄⠀⠀⠀⠀⠀⠈⢨⢿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢄
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠂⠀⠀⠑⠿⣿⡎⠛⢧⠈⠙⠙⠦⣄⣠⣤⣴⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⡆⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣤⣀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⣰⡟⠋⠚⢳⡿⠻⡄⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣷⠀⠀⠀⠀⠀⠀⠀⠀⣿⠁⠀⣴⠟⠃⠀⣷⠀⡀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⡟⣧⠀⠀⠀⠀⠀⠀⠀⠘⢧⣾⠃⠀⢀⣼⠃⢠⡇
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣶⠏⣿⢷⡟⠢⡀⠀⠀⠀⠀⠀⠠⠄⠉⠛⠛⢭⣴⠇⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠔⢊⢀⡟⢸⡟⢸⣷⡄⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠄⠊⠁⠀⠀⠎⣸⡇⣿⢇⠏⠹⣿⡄⠱⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠜⠁⠀⠀⠀⠀⢀⡴⣿⠟⣡⠋⠀⠀⢹⣷⡀⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠎⠀⠀⠀⠀⢀⡴⠋⣼⠏⠀⣿⠀⢀⠔⠉⠙⠳⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡎⠀⠀⠀⠀⠀⣿⠀⠀⣿⠀⠀⢿⠀⡎⠀⠀⠀⠀⢸⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢇⠀⠀⠀⠀⢀⣿⣤⣤⣿⡆⠀⢸⣦⢃⡴⠀⠀⠀⠘⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⣀⣀⣀⣀⠘⣄⠀⠀⢠⣿⣿⠻⣿⣿⠇⢀⣼⠿⠋⠀⠀⠀⠀⠀⠈⢿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⡞⠁⠀⠀⠀⠀⠀⠀⠈⠳⣿⣈⡶⠋⣹⣿⣧⡈⡿⠀⣠⣷⡾⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⡆⠀⠀⠀⠀⠀⣀⣤⠴
⠀⠀⠀⠀⠀⠀⠀⡸⠀⠀⢲⣤⣠⣤⣄⣠⡀⠀⠙⢯⡀⠀⢸⣿⣿⡿⠁⣰⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⡄⠀⢠⣶⡿⠏⠀⠀
⠀⠀⠀⠀⠀⠀⠰⠁⠀⠀⣾⣿⠠⠀⠀⠈⠻⣶⣄⠀⠙⠲⣿⡹⠏⠀⣰⣿⠿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢱⣴⠟⠁⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⡠⠦⠚⠉⠀⠀⠀⠐⠀⠀⠈⢿⡷⢤⠴⠛⠁⠀⠀⢈⣀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡄⠀⠀⠀⠀⠀
"@

    Write-Host "$(sq)"
    Write-Host "PowerShell $( $PSVersionTable.PSVersion ) | Combo: $env:COMBO_COUNT | $(Get-Date -Format 'dddd, dd MMMM yyyy')"
    $env:PROFILE_LOADED = "true"
}