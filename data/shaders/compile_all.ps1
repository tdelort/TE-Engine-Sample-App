$shaders = @(
    [pscustomobject]@{FilePath="spectrum_init.slang";       EntryPoint="cs_spectrum_init";      ShaderStage="compute"}
    [pscustomobject]@{FilePath="spectrum_animate.slang";    EntryPoint="cs_spectrum_animate";   ShaderStage="compute"}
    [pscustomobject]@{FilePath="fft.slang";                 EntryPoint="cs_fft_radix_8_main";   ShaderStage="compute"}
    [pscustomobject]@{FilePath="fft.slang";                 EntryPoint="cs_fft_radix_8_last";   ShaderStage="compute"}
    [pscustomobject]@{FilePath="blit.slang";                EntryPoint="vs_blit";               ShaderStage="vertex"}
    [pscustomobject]@{FilePath="blit.slang";                EntryPoint="ps_blit";               ShaderStage="pixel"}
    [pscustomobject]@{FilePath="placeholder.slang";         EntryPoint="vs_placeholder";        ShaderStage="vertex"}
    [pscustomobject]@{FilePath="placeholder.slang";         EntryPoint="ps_placeholder";        ShaderStage="pixel"}
    [pscustomobject]@{FilePath="water.slang";               EntryPoint="vs_water";              ShaderStage="vertex"}
    [pscustomobject]@{FilePath="water.slang";               EntryPoint="ps_water";              ShaderStage="pixel"}
)

$tools_path = "..\..\libraries\TE-Engine\tools\"
$slangc_path = "$tools_path\slangc.exe"

foreach($shader in $shaders)
{
    Write-Host "Compiling " $shader.EntryPoint " from file " $shader.FilePath
    $args = @( 
        $shader.FilePath, 
        "-entry", $shader.EntryPoint, 
        "-stage", $shader.ShaderStage,
        "-target", "dxil", 
        "-profile", "sm_6_6",
        "-dxc-path", $tools_path,
        "-matrix-layout-row-major",
        "-g",
        "-o", ".\dx12\$($shader.EntryPoint).bin"
    )
    Write-Host "slangc.exe" @args 
    Write-Host ""
    & $slangc_path $args
}

$app_shaders_path = "..\..\build\data\shaders\dx12\"

# Write-Host "Copying all .bin to  " $app_shaders_path
# Copy-Item -Path ".\dx12\*" -Filter "*.bin" -Destination $app_shaders_path -Recurse