# codespace：分析代码

更新时间：2026-11-24

| 脚本 | 用途 | 说明 |
| --- | --- | --- |
| `download_obs104.ps1` | 下载 Chandra ObsID 104（4U 1626−67，2000-09-16，ACIS-S/HETG）档案数据 | Windows PowerShell 脚本；对应 Krauss et al. 2007 的 Table 1 第 1 行，作为 2000 年历史谱线基线 |

## download_obs104.ps1

数据源：Chandra Data Archive 固定直链目录 <https://cxc.cfa.harvard.edu/cdaftp/byobsid/4/104/>
（目录规则 `byobsid/<ObsID 末位数字>/<ObsID>/`；归档版本 `axaff00104N004`，evt2/pha2 为 `N005`，CXC 10.9.2 / CALDB 4.9.4）。

用法（在仓库主目录执行）：

```powershell
# 默认 recommended 档（≈179 MB，含 secondary/evt1，可重处理）
powershell -ExecutionPolicy Bypass -File .\codespace\download_obs104.ps1

# 最小档（≈78 MB，只到谱线拟合）
powershell -ExecutionPolicy Bypass -File .\codespace\download_obs104.ps1 -Profile minimal

# 全量档（≈423 MB，含 evt1a、vvref2、±2/±3 级响应）
powershell -ExecutionPolicy Bypass -File .\codespace\download_obs104.ps1 -Profile full

# 自定义目标目录
powershell -ExecutionPolicy Bypass -File .\codespace\download_obs104.ps1 -Dest D:\data\obs104
```

- 默认输出到 `data/astrodata/ChandraXCT_ObsID104_data/`（已于 2026-11-24 用同一清单下载 43 个文件 / 178.5 MB），保持档案原有 `primary/`、`secondary/` 层级。
- 可重复执行：已存在且大小正常的文件会跳过；失败文件重跑即续传。
- 脚本内置关键文件大小核对（evt2 19.47 MB、pha2 1.05 MB、evt1 91.51 MB 等），下载不完整会给出警告/失败退出。

## 下载后核对

1. `00README` 应显示 ObsId 104、CXC 10.9.2、CalDB 4.9.4、DOI `10.25574/104`。
2. `axaff00104N004_VV001_vv2.pdf`（V&V 报告）先读一遍，确认有无观测异常。
3. `evt2/pha2` 版本为 N005、`evt1` 为 N004 属正常（L2 比 L1 多一次重处理），不是下错文件。

## 注意

- 论文使用 CIAO 3.3 + CALDB 3.2.1 时代的处理结果，与归档当前版本存在校准差异，复现时需在记录里写明所用 CIAO/CALDB 版本，不追求逐位一致。
- 该源 0 级像严重堆叠，谱线分析应使用 ±1 级分散谱（`TG_PART` / `TG_M` 选谱，配同名 ARF/RMF）。
- 2000 年数据必须使用含时间依赖 ACIS 滤光片污染改正的响应（现代 CALDB 已包含）。
