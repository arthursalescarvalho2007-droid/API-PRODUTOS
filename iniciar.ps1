$ErrorActionPreference = 'Stop'
$projectRoot = $PSScriptRoot
$localMaven = Join-Path $projectRoot '..\..\.tools\apache-maven-3.9.11\bin\mvn.cmd'
$javaHome = 'C:\Program Files\Eclipse Adoptium\jdk-21.0.11.10-hotspot'

if (Test-Path (Join-Path $javaHome 'bin\java.exe')) {
    $env:JAVA_HOME = $javaHome
    if (($env:Path -split ';') -notcontains (Join-Path $javaHome 'bin')) {
        $env:Path = "$(Join-Path $javaHome 'bin');$env:Path"
    }
}

if (Get-Command mvn -ErrorAction SilentlyContinue) {
    mvn spring-boot:run
} elseif (Test-Path $localMaven) {
    & $localMaven spring-boot:run
} else {
    Write-Error 'Maven não foi encontrado. Configure o PATH ou instale o Maven 3.9.11.'
    exit 1
}
