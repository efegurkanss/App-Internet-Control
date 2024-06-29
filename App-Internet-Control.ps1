function Block-AppInternet {
    param (
        [string]$exePath
    )
    $ruleName = "Block $exePath"
    
    if (Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue) {
        Remove-NetFirewallRule -DisplayName $ruleName
    }

    New-NetFirewallRule -DisplayName $ruleName -Direction Outbound -Program $exePath -Action Block
    Write-Host "$exePath internet baglantisi kesildi."
}

function Unblock-AppInternet {
    param (
        [string]$exePath
    )
    $ruleName = "Block $exePath"
    
    if (Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue) {
        Remove-NetFirewallRule -DisplayName $ruleName
        Write-Host "$exePath internet baglantisi acildi."
    } else {
        Write-Host "Internet baglantisi zaten acik."
    }
}

function Test-AppInternetBlocked {
    param (
        [string]$exePath
    )
    $ruleName = "Block $exePath"
    
    if (Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue) {
        Write-Host "$exePath internet baglantisi kesik."
        return $false
    } else {
        Write-Host "$exePath internet baglantisi acik."
        return $true
    }
}

$exePath = Read-Host "Lutfen internet baglantisini kontrol etmek istediginiz exe dosyasinin tam yolunu girin"

while ($true) {
    Write-Host "Secenekler:"
    Write-Host "1. Uygulamanin internet baglantisini kes"
    Write-Host "2. Uygulamanin internet baglantisini ac"
    Write-Host "3. Uygulamanin internet baglantisi durumunu kontrol et"
    Write-Host "4. Cikis"
    
    $choice = Read-Host "Seciminiz"
    
    switch ($choice) {
        1 { Block-AppInternet -exePath $exePath }
        2 { Unblock-AppInternet -exePath $exePath }
        3 { Test-AppInternetBlocked -exePath $exePath }
        4 { exit }
        default { Write-Host "Gecersiz secenek, lutfen tekrar deneyin." }
    }
}
