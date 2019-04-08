function Find-AnalysisServicesDeploymentExeLocations {
    <#
		.SYNOPSIS
        Lists all locations of Microsoft.AnalysisServices.Deployment.exe files on the machine

        .DESCRIPTION
        Finds and lists the location path to every version of Microsoft.AnalysisServices.Deployment.exe on the machine

		Written by (c) Dr. John Tunnicliffe, 2019 https://github.com/DrJohnT/DeployCube
		This PowerShell script is released under the MIT license http://www.opensource.org/licenses/MIT
	#>

    try {
        $AnalysisServicesDeploymentWizExe = "Microsoft.AnalysisServices.Deployment.exe";
        # Get SQL Server locations
        $AnalysisServicesDeploymentExes = @();
        $AnalysisServicesDeploymentExes += Get-Childitem -Path "${env:ProgramFiles(x86)}\Microsoft SQL Server\*\Tools\Binn\" -Recurse -Include $AnalysisServicesDeploymentWizExe -ErrorAction SilentlyContinue;

        # list out the locations found
        foreach ($AnalysisServicesDeploymentExe in $AnalysisServicesDeploymentExes) {
            [string]$ProductVersion = $AnalysisServicesDeploymentExe.VersionInfo.ProductVersion;
            Write-Output "$ProductVersion  $AnalysisServicesDeploymentExe";
        }
    }
    catch {
        Write-Error "Find-AnalysisServicesDeploymentExeLocations failed with error $Error";
    }
}