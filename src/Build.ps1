Remove-Item ..\lib\*.dll

$AddTypeArguments = @(
    @{
        Name             = "WindowSercher"
        Namespace        = "User32"
        usingNamespace   = @(
            "System.Text"
            "System.Collections.Generic"
        )
        MemberDefinition = $(Get-Content .\WndSearcher.cs | Join-String -Separator "`r`n`t")
        OutputType       = "Library"
        OutputAssembly   = "..\lib\WindowSercher.dll"
    },
    @{
        Name             = "LayeredWindowManager"
        Namespace        = "User32"
        MemberDefinition = $(Get-Content .\LayeredWindowManager.cs | Join-String -Separator "`r`n`t")
        OutputType       = "Library"
        OutputAssembly   = "..\lib\LayeredWindowManager.dll"
    }
)
$AddTypeArguments.GetEnumerator().ForEach{ Add-Type @_ }
