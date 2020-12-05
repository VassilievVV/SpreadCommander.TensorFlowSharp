using namespace TensorFlow;

$schost           = Get-SCHost;
$assemblyFileName = $schost.MapPath('~\bin\TensorFlowSharp.dll');

Add-Type -Path:$assemblyFileName | Out-Null;

$schost.Silent = $true;

Clear-Book;
Clear-Spreadsheet;

Invoke-SCScript '~\InitBookStyles.ps1';

Set-BookSectionHeader '<b>Spread Commander</b> - <i>Examples: TensorFlow</i>' -Html;
Set-BookSectionFooter 'Page {PAGE} of {NUMPAGES}' -ExpandFields;

Write-Text -ParagraphStyle:'Header1' 'TENSORFLOW';

Write-Html -ParagraphStyle:'Description' @'
<p align=justify><b>PowerShell</b> script allows to reference .Net (Core) assemblies.
This example shows how to use .Net Core <b>Tensorflow</b> engine. 
After executing script look also tab <b>Spreadsheet</b>.</p>
'@;

Write-Html -ParagraphStyle:'Description' @'
Download last <b>TensorFlowSharp</b> libraries from <a href="https://www.nuget.org/packages/TensorFlowSharp/">Nuget,
https://www.nuget.org/packages/TensorFlowSharp//</a> and unpack in folder <b>bin</b> of then <b>SpreadCommander</p> project.
'@;

$session = [TFSession]::new();
try
{
    $graph = $session.Graph;
    
    $a = $graph.Const(2);
    $b = $graph.Const(3);
    Write-Host 'a = 2; b = 3';

    $addingResults = $session.GetRunner().Run($graph.Add($a, $b));
    $addingValue   = $addingResults.GetValue();
    Write-Host "a + b = $addingValue";
    
    $multiplyResults = $session.GetRunner().Run($graph.Mul($a, $b));
    $multiplyValue   = $multiplyResults.GetValue();
    Write-Host "a * b = $multiplyValue";
}
finally
{
    $session.Dispose();
}