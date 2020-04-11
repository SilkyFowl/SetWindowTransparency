Remove-Item $PSScriptRoot\..\lib\*.dll

$AddTypeArguments = @(
    @{
        Name             = "WindowSercher"
        Namespace        = "User32"
        usingNamespace   = @(
            "System.Text"
            "System.Collections.Generic"
        )
        MemberDefinition = $(Get-Content $PSScriptRoot\WndSearcher.cs | Join-String -Separator "`r`n`t")
        OutputType       = "Library"
        OutputAssembly   = "$PSScriptRoot\..\lib\WindowSercher.dll"
    },
    @{
        Name             = "LayeredWindowManager"
        Namespace        = "User32"
        MemberDefinition = $(Get-Content $PSScriptRoot\LayeredWindowManager.cs | Join-String -Separator "`r`n`t")
        OutputType       = "Library"
        OutputAssembly   = "$PSScriptRoot\..\lib\LayeredWindowManager.dll"
    }
)
$AddTypeArguments.GetEnumerator().ForEach{ Add-Type @_ }
