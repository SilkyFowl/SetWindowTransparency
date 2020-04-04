using assembly ChildWindowHandles.dll
using assembly WindowTransparencyHelper.dll
using namespace Win32.user32

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
    [ChildWindowHandles]::GetChildWindows($process.MainWindowHandle)
    $wl = [WindowTransparencyHelper]::GetWindowLong($process.MainWindowHandle, -20)
    [WindowTransparencyHelper]::SetWindowLong($process.MainWindowHandle, -20, ($wl -bor 0x80000)) | Out-Null
    [WindowTransparencyHelper]::SetLayeredWindowAttributes($process.MainWindowHandle, 0, $transparency, 0x02) | Out-Null
}

function Set-WindowTransparency2 {
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
    [ChildWindowHandles]::GetChildWindows($process.MainWindowHandle).GetEnumerator().ForEach{
        $_ | Set-Transparency $transparency
    }

    $process.MainWindowHandle | Set-Transparency $transparency
}

function Set-Transparency {
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
        [System.IntPtr]
        $WindowHandle
    )

    $wl = [WindowTransparencyHelper]::GetWindowLong($WindowHandle, -20)
    [WindowTransparencyHelper]::SetWindowLong($WindowHandle, -20, ($wl -bor 0x80000)) | Out-Null
    [WindowTransparencyHelper]::SetLayeredWindowAttributes($WindowHandle, 0, $transparency, 0x02) | Out-Null
}

Export-ModuleMember -Function Set-WindowTransparency2, Set-WindowTransparency2