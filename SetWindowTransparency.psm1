using assembly .\lib\LayeredWindowManager.dll
using assembly .\lib\WindowSercher.dll
using namespace User32

[int]$GWL_EXSTYLE = -20
[int]$WS_EX_LAYERED = 0x80000
[int]$LWA_ALPHA = 0x2

function Set-WindowTransparency {
	[CmdletBinding()]
	param (
		# Specifies a path to one or more locations.
		[Parameter(
			Position = 0,
			ValueFromPipeline = $false,
			ValueFromPipelineByPropertyName = $true,
			HelpMessage = "Transparency")]
		[Alias("tran")]
		[ValidateRange(0, 255)]
		[int] $transparency = 200,
		[Parameter(Mandatory = $true,
			Position = 1,
			ValueFromPipeline = $true,
			ValueFromPipelineByPropertyName = $true,
			HelpMessage = "Target")]
		[Alias("proc")]
		[ValidateNotNullOrEmpty()]
		[System.Diagnostics.Process]
		$process
	)

	process{
		[WindowSercher]::SearchForWindow($process.id).GetEnumerator().foreach{
			$wl = [LayeredWindowManager]::GetWindowLong($_, $GWL_EXSTYLE)
			[LayeredWindowManager]::SetWindowLong($_, $GWL_EXSTYLE, ($wl -bor $WS_EX_LAYERED)) | Out-Null
			[LayeredWindowManager]::SetLayeredWindowAttributes($_, 0, $transparency, $LWA_ALPHA) | Out-Null
		}
	}
}

Export-ModuleMember -Function Set-WindowTransparency
