<# Extensis API #>
<#
user: martintest
token: TOKEN-fa28eaed-b572-4454-8a97-76c1297df0b1

Reference: http://doc.extensis.com/api/portfolio/rest/index.html#/
invoke-restmethod
#>
#requires -version 6

$urlbase = "http://portfolio1.emp.ads.morainevalley.edu:8090/api/v1"
$authparam = "session=TOKEN-fa28eaed-b572-4454-8a97-76c1297df0b1"
$auth = "?" + "$authparam"
$contentType = 'application/json'


$url = "$urlbase/catalog$auth"
$catalogs = invoke-restmethod -uri $url -method get

$catalog = $catalogs | where-object {$_.name -eq "Digital Photos 2013-"}
$catid = $catalog.id

$galleriesurl = "$urlbase/catalog/$catid/galleries$auth" 

$gallerylist = invoke-restmethod -uri $galleriesurl -method get

$joburi = $urlbase + '/job/_status' + $auth

invoke-restmethod -uri $joburl -method get

invoke-restmethod -uri $galleriesurl -method get -headers $headers


$uri = "https://portfolio.morainevalley.edu/api/v1/catalog/2694C2D9-2D8A-4817-9546-8A1EDC7B12D1/asset?session=TOKEN-fa28eaed-b572-4454-8a97-76c1297df0b1&catalog_id=2694C2D9-2D8A-4817-9546-8A1EDC7B12D1"

$body = @{
    "galleryId" = "10"
    "pageSize" = "100"
}

$jsonbody = $body | convertto-json
$assets2 = irm -uri $uri -method get -body $jsonbody -ContentType "application/json"

$assetsnum = $assets2.totalNumberOfAssets
# used in download body to set the gallery page size

$assetarray = $assets2.assets.attributes | where {$null -ne $_.username} | select username, filename, 'directory path', 'file description'



$downloadbody = @{

    "assetQuery" = @{
        "galleryId" = "10"
        "pagesize" = "$assetsnum"
    }
    "job" = @{
        "description" = "JOB_TYPE_EDIT_ON_DISK"
        "sourceImage" = "original"
        tasks = @(@{
                "destination" = "C:\workspace\assets.zip"
                type = "download"
            },
            @{
                "catalogId" = "$catid"
                settings = @(@{
                        "name"= "outputFileFormat"
                        "value"= "JPEG"
                    },
                    @{
                        "name" = "colorMode"
                        "value" = "RGB"
                    },
                    @{
                        "name" = "compressionQuality"
                        "value" = "75"
                    },
                    @{
                        "name" = "resizeHeight"
                        "value" = "500"
                    },
                    @{
                        "name" = "resizeType"
                        "value" = "fitWithin"
                    },
                    @{
                        "name" = "resizeUnits"
                        "value" = "pixels"
                    },
                    @{
                        "name" = "resizeWidth"
                        "value" = "400"
                    }
                )
                "type" = "convert"
            }
        )
    }
    "query" = @{
        "term" = @(@{
            "operator" = "equalValue"
            "field" = "Keywords"
            "values" = "New Employees"
            }
        )
    }
}

$jsondownload = $downloadbody | ConvertTo-Json -Depth 6

irm -uri "$urlbase/job/run/$auth&$catid" -method post -ContentType $contentType -body $jsondownload

<#
foreach($asset in $assetarray){
    
}
#>


<#
$portfoliopics = import-clixml C:\workspace\directoryphotos.xml

$portfoliopics
$path1 = ($portfoliopics[0].'Directory Path').replace(':','\')
$path1
[string]$pic1 = $portfoliopics[0].Filename
$pic1
$getfile = join-path -path $path1 -ChildPath $pic1
#>
