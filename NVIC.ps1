set-executionpolicy remotesigned

clear

#Json generated @ url https://www.protectinghealthandautonomyinthe21stcentury.com/conference-live
#with this javascript in the console:
#
#let jsonArray = [];
#let divs = document.getElementsByClassName('s_BIwzIGroupSkin');
#
#divs.forEach( (div, i) => {
#    jsonArray[i] = {
#        "video": div.getElementsByTagName('video')[0].src, //video url 
#        "thumbnail":  div.getElementsByTagName('wix-image')[0].getAttribute('data-src') //video webp thumbnail
#    }
#})
#console.log(JSON.stringify(jsonArray);
#

$json = Get-Content -Path "c:\ps scripts\vaccine.convention.json" | ConvertFrom-JSON

$ffmpegLocation = "c:\FFmpeg\ffmpeg.exe"

#net use Z: "\\Win-cjjhip9hkbd\z"

$dest      = "Z:\Convention\"
$videoType = "mp4"
$i         = 0;
new-item -Force -Path "$dest" -ItemType directory | Out-Null

$json | ForEach-Object {
    $i++
    #Write-Host($i)
    [string]$url  = $_.video
    [string]$thumbnail = $_.thumbnail
    #Write-Host($url)
    #Write-Host($thumbnail)

    $outFile = "$dest$i.$videoType"

    Invoke-WebRequest -Uri $url -OutFile $outFile

    #Convert webp thumbnail to jpg for Plex

    & $ffmpegLocation -y -i "$thumbnail" -pix_fmt yuvj422p "$dest$i.jpg"

}

