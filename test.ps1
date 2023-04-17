$AssetTag =      (wmic SystemEnclosure get SerialNumber, SMBIOSAssetTag)

$AssetTag | Out-File -FilePath 'C:\Users\cblick\Desktop\Projects\DellAssetFix\test.txt'