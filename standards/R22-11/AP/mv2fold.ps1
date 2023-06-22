# https://blog.51cto.com/timefiles/1855343
# @20230123

$path = "."
Get-ChildItem -path $path "*.pdf" | Where-Object {$_.Name -like "*.pdf"} | Select-Object Name | Out-File file_base.txt

$base_name = Get-Content "file_base.txt" #将file_base.txt内容赋给$base_name
# $base_name -replace "(?m)\s","" > file_base.txt#删除a.txt文件中的空格
$base_name | Foreach {$_.TrimEnd()} | Set-Content file_base.txt
$base_name = Get-Content "file_base.txt"
$file_num = $base_name.count-3
$base_name = $base_name[3..$file_num] | Out-File file_base.txt #删除文件中的前三行描述信息，输出的内容覆盖a.txt文件内容
$base_name = Get-Content "file_base.txt"

foreach ($check in $base_name) {
    $name_num = $check.length-4
    $base_name = $check.Substring(0, $name_num)
    New-Item -Type Directory -Name "$base_name"
    Move-Item -Force $check $base_name
    Write-Host $base_name
}

Get-ChildItem '*/*' '*.pdf' | Rename-Item -Newname 'input.pdf' -Force
