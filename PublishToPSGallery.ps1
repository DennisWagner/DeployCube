param (
    [Parameter(Mandatory)]
    [string] $ApiKey
)


$VerbosePreference = 'Continue';
$ErrorActionPreference = 'Stop';
$baseDir = $PSScriptRoot;

.\UpdateHelp.ps1

try {
    $buildDir = "$baseDir\DeployCube";
    Write-Information $buildDir;
    Write-Verbose 'Importing PowerShellGet module'
    $psGet = Import-Module PowerShellGet -PassThru -Verbose:$false
    & $psGet { [CmdletBinding()] param () Install-NuGetClientBinaries -CallerPSCmdlet $PSCmdlet -BootstrapNuGetExe -Force }

    Write-Host 'Publishing module using PowerShellGet'
    $null = Publish-Module -Path $buildDir -NuGetApiKey $ApiKey -Confirm:$true;
}
catch {
    Write-Error -ErrorRecord $_
    exit 1
}
