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
        Write-Host "Install winget or chocolatey first, then re-run this script."
        exit 1
    }
}

# Download vimrc
Invoke-WebRequest -Uri $VimrcUrl -OutFile $VimrcPath
Write-Host "Done. Run 'vim' - plugins will auto-install on first launch."
