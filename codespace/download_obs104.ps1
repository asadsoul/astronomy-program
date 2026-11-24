<#
.SYNOPSIS
    下载 Chandra ObsID 104 的档案数据（4U 1626-67，2000-09-16，ACIS-S + HETG）。

.DESCRIPTION
    对应论文 Krauss et al. 2007, ApJ 660, 605 的 Table 1 第 1 行。
    数据源为 Chandra Data Archive 的固定直链目录：
        https://cxc.cfa.harvard.edu/cdaftp/byobsid/4/104/
    归档版本：axaff00104N004；evt2 / pha2 为 N005（CXC 10.9.2 / CALDB 4.9.4）。
    三档下载量（实测）：
        minimal      ≈  78 MB  primary + ±1 级响应，够做 O/Ne 谱线拟合
        recommended  ≈ 179 MB  另加 secondary/evt1，够跑 chandra_repro 重处理
        full         ≈ 423 MB  另加 evt1a、vvref2、±2/±3 级响应

.PARAMETER Profile
    minimal | recommended | full，默认 recommended。

.PARAMETER Dest
    本地目标目录，默认 D:\4U 1626-67\data\astrodata\ChandraXCT_ObsID104_data

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\download_obs104.ps1

.EXAMPLE
    .\download_obs104.ps1 -Profile minimal
    .\download_obs104.ps1 -Profile full -Dest D:\data\obs104
#>
param(
    [ValidateSet('minimal', 'recommended', 'full')]
    [string]$Profile = 'recommended',
    [string]$Dest = 'D:\4U 1626-67\data\astrodata\ChandraXCT_ObsID104_data'
)

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ErrorActionPreference = 'Stop'
$BASE = 'https://cxc.cfa.harvard.edu/cdaftp/byobsid/4/104/'

# ---------- 文件清单 ----------
$top = @(
    '00README',
    'oif.fits',
    'axaff00104N004_VV001_vv2.pdf'
)
$primary = @(
    'primary/acisf00104N005_evt2.fits.gz',
    'primary/acisf00104N005_pha2.fits.gz',
    'primary/acisf00104_002N004_bpix1.fits.gz',
    'primary/acisf00104_002N004_fov1.fits.gz',
    'primary/orbitf085406700N001_eph1.fits.gz',
    'primary/pcadf00104_002N001_asol1.fits.gz',
    'primary/acisf00104N005_cntr_img2.jpg',
    'primary/acisf00104N005_full_img2.jpg'
)
$resp1 = @(foreach ($a in 'H', 'M') {
        foreach ($o in 'm1', 'p1') {
            foreach ($k in 'arf', 'rmf') {
                "primary/responses/acisf00104N005_${a}${o}_${k}2.fits.gz"
            }
        }
    })
$respAll = @(foreach ($a in 'H', 'M') {
        foreach ($o in 'm1', 'm2', 'm3', 'p1', 'p2', 'p3') {
            foreach ($k in 'arf', 'rmf') {
                "primary/responses/acisf00104N005_${a}${o}_${k}2.fits.gz"
            }
        }
    })
$secSmall = @(
    'secondary/acisf00104_002N004_flt1.fits.gz',
    'secondary/acisf00104_002N004_msk1.fits.gz',
    'secondary/acisf00104_002N004_mtl1.fits.gz',
    'secondary/acisf00104_002N004_stat1.fits.gz',
    'secondary/acisf085503191N004_0_bias0.fits.gz',
    'secondary/acisf085503191N004_1_bias0.fits.gz',
    'secondary/acisf085503191N004_2_bias0.fits.gz',
    'secondary/acisf085503191N004_3_bias0.fits.gz',
    'secondary/acisf085503191N004_4_bias0.fits.gz',
    'secondary/acisf085503191N004_5_bias0.fits.gz',
    'secondary/acisf085504494N004_pbk0.fits.gz',
    'secondary/aspect/pcadf085503387N004_osol1.fits.gz',
    'secondary/aspect/pcadf085504302N004_aqual1.fits.gz',
    'secondary/aspect/pcadf085509947N004_osol1.fits.gz',
    'secondary/aspect/pcadf085516507N004_osol1.fits.gz',
    'secondary/aspect/pcadf085517032N004_osol1.fits.gz',
    'secondary/aspect/pcadf085523592N004_osol1.fits.gz',
    'secondary/aspect/pcadf085530152N004_osol1.fits.gz',
    'secondary/aspect/pcadf085536712N004_osol1.fits.gz',
    'secondary/aspect/pcadf085543272N004_osol1.fits.gz',
    'secondary/ephem/anglesf00104_002N004_eph1.fits.gz',
    'secondary/ephem/lunarf085406700N001_eph1.fits.gz',
    'secondary/ephem/solarf085406700N001_eph1.fits.gz'
)
$evt1 = 'secondary/acisf00104_002N004_evt1.fits.gz'        # 91.5 MB，重处理必需
$evt1a = 'secondary/acisf00104_002N005_evt1a.fits.gz'       # 70.0 MB，可省
$vvref2 = 'secondary/axaff00104N004_VV001_vvref2.pdf.gz'    # 78.6 MB，可省

$files = @($top) + @($primary) + @($resp1)
if ($Profile -in @('recommended', 'full')) { $files += @($secSmall) + @($evt1) }
if ($Profile -eq 'full') {
    $files = @($files | Where-Object { $_ -notin $resp1 }) + @($respAll) + @($evt1a) + @($vvref2)
}

# ---------- 关键文件大小核对表（MB，实测值）----------
$expect = @{
    'primary/acisf00104N005_evt2.fits.gz'               = 19.47
    'primary/acisf00104N005_pha2.fits.gz'               = 1.05
    'primary/pcadf00104_002N001_asol1.fits.gz'          = 8.72
    'primary/responses/acisf00104N005_Mp1_rmf2.fits.gz' = 17.71
    'secondary/acisf00104_002N004_evt1.fits.gz'         = 91.51
}

Write-Host ("ObsID 104 | 档位: {0} | {1} 个文件 | 目标: {2}" -f $Profile, $files.Count, $Dest) -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $Dest | Out-Null

$fail = @()
$bytes = 0
$i = 0
foreach ($f in $files) {
    $i++
    $out = Join-Path $Dest ($f -replace '/', '\')
    New-Item -ItemType Directory -Force -Path (Split-Path $out) | Out-Null

    if (Test-Path $out) {
        $bytes += (Get-Item $out).Length
        Write-Host ("  [{0}/{1}] 跳过 {2}" -f $i, $files.Count, $f) -ForegroundColor DarkGray
        continue
    }

    $ok = $false
    for ($try = 1; $try -le 3 -and -not $ok; $try++) {
        try {
            Write-Host ("  [{0}/{1}] {2} ... " -f $i, $files.Count, $f) -NoNewline
            Invoke-WebRequest -Uri ($BASE + $f) -OutFile $out -UseBasicParsing -TimeoutSec 300
            $ok = $true
        }
        catch {
            Write-Host ("重试 {0}/3: {1}" -f $try, $_.Exception.Message) -ForegroundColor Yellow
            Start-Sleep -Seconds (2 * $try)
        }
    }

    if (-not $ok) {
        $fail += $f
        Write-Host ("  失败: {0}" -f $f) -ForegroundColor Red
        continue
    }

    $mb = (Get-Item $out).Length / 1MB
    $msg = "  -> {0:N2} MB" -f $mb
    if ($expect.ContainsKey($f)) {
        $d = $expect[$f]
        if ([math]::Abs($mb - $d) -gt 0.05) { $msg += ("  [警告: 期望 {0:N2} MB]" -f $d) }
    }
    $bytes += (Get-Item $out).Length
    Write-Host $msg -ForegroundColor Green
}

Write-Host ("`n合计 {0:N1} MB" -f ($bytes / 1MB)) -ForegroundColor Cyan
if ($fail.Count -gt 0) {
    Write-Host ("失败 {0} 个（重跑脚本会自动续传）:" -f $fail.Count) -ForegroundColor Red
    $fail | ForEach-Object { Write-Host ("  {0}" -f $_) }
    exit 1
}
Write-Host '完成。下一步：先看 00README 和 V&V 报告；需要重处理就进 CIAO 环境对 secondary/evt1 跑 chandra_repro。' -ForegroundColor Green
