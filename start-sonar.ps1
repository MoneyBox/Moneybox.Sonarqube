# Define variables
$SonarQubeVersion = "10.8.0.100206" # Replace with latest version and build
# Replace with latest download url from https://www.sonarsource.com/products/sonarqube/downloads/success-download-developer-edition/
$SonarQubeUrl = "https://binaries.sonarsource.com/CommercialDistribution/sonarqube-developer/sonarqube-developer-10.8.0.100206.zip?_gl=1*8cqi2i*_up*MQ..*_gs*MQ..&gclid=Cj0KCQiAsOq6BhDuARIsAGQ4-zhy3nsVvkDASIv5thpI5qCX_MoCmHsXSZ9oZhkY0TV92UBr5AhmvUMaAkL6EALw_wcB"
$InstallDir = "D:\home\site\wwwroot\sonarqube"
$SonarQubeHome = "$InstallDir\sonarqube-10.8.0.100206" # Replace with latest version and build
$DataDir = "$InstallDir\data"
$LogsDir = "$InstallDir\logs"

Write-Host "Starting SonarQube setup..."

# Create necessary directories
Write-Host "Creating directories..."
New-Item -ItemType Directory -Force -Path $InstallDir, $DataDir, $LogsDir | Out-Null


# Download SonarQube if not already downloaded
if (-Not (Test-Path "$InstallDir\sonarqube-$SonarQubeVersion.zip")) {
    Write-Host "Downloading SonarQube..."
    Invoke-WebRequest -Uri $SonarQubeUrl -OutFile "$InstallDir\sonarqube-$SonarQubeVersion.zip"
} else {
    Write-Host "SonarQube already downloaded."
}

# Extract SonarQube if not already extracted
if (-Not (Test-Path $SonarQubeHome)) {
    Write-Host "Extracting SonarQube..."
    Expand-Archive -Path "$InstallDir\sonarqube-$SonarQubeVersion.zip" -DestinationPath $InstallDir
} else {
    Write-Host "SonarQube already extracted."
}

# Start SonarQube
Write-Host "Starting SonarQube..."
Start-Process -FilePath "$SonarQubeHome\bin\windows-x86-64\StartSonar.bat" -NoNewWindow

Write-Host "SonarQube setup and startup complete."
