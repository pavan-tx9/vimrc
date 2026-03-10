$VimrcUrl = "https://raw.githubusercontent.com/pavan-tx9/vimrc/main/.vimrc"
$VimrcPath = "$HOME\.vimrc"

# Install vim if missing
if (-not (Get-Command vim -ErrorAction SilentlyContinue)) {
    Write-Host "Installing vim..."
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        winget install --id vim.vim --accept-package-agreements --accept-source-agreements
    } elseif (Get-Command choco -ErrorAction SilentlyContinue) {
        choco install vim -y
    } else {
        Write-Host "No package manager found. Installing Chocolatey..."
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        # Refresh PATH so choco is available
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
        choco install vim -y
    }
}

# Download vimrc
Invoke-WebRequest -Uri $VimrcUrl -OutFile $VimrcPath
Write-Host "Done. Run 'vim' - plugins will auto-install on first launch."
