# ChandraXCT_ObsID104_data：验证 Krauss et al. (2007) 用的 Chandra/HETGS 数据

本目录是 **Chandra X 射线天文台 ObsID 104** 的归档数据，目标源为 **4U 1626−67**。下载它的唯一用途，是**验证（复现）Krauss et al. 2007（ApJ 660, 605）** 中基于这一次 2000 年 HETGS 观测给出的高分辨率光谱与计时结果，不用于本项目 2023 年后新减速阶段的新结果。

## 1. 对应哪篇论文、要验证什么

**Krauss, M. I., Schulz, N. S., Chakrabarty, D., Juett, A. M., & Cottam, J. 2007, ApJ, 660, 605–614**
*High-Resolution X-Ray Spectroscopy of the Ultracompact LMXB Pulsar 4U 1626−67*（ADS: `2007ApJ...660..605K`；本地 PDF：[paper/Krauss_2007_ApJ_660_605.pdf](../../paper/Krauss_2007_ApJ_660_605.pdf)）

该文用了 4 次观测，其中 **2 次 Chandra HETGS**：`ObsID 104`（2000-09-16，本目录）与 `ObsID 3504`（2003-06-03，未下载）。本目录的验证目标逐项对应论文：

| 论文中的位置 | 内容 | 本目录的复现入口 |
| --- | --- | --- |
| Table 1 第 1 行 | 观测配置、起止时间、曝光 40 ks | 本 README 第 2 节；`primary/*_evt2.fits.gz` 头 |
| Table 2 第 1 行 | 黑体+幂律连续谱：N_H、Γ、kT、R、0.3–10 keV 通量 2.2×10⁻¹⁰ erg cm⁻² s⁻¹ | `primary/*_pha2.fits.gz` + `primary/responses/` |
| Table 3 第 1 列、Table 4 | Ne X 12.13 Å、Ne IX 13.55 Å、O VIII 18.97 Å、O VII 21.80 Å 的线心、线宽（FWHM ≈6000 km s⁻¹）、红/蓝移分量（±1700–1900 km s⁻¹）、线流量、等值宽 | `pha2` 的 ±1 级谱 + 同名 ARF/RMF |
| Table 5 第 1 列 | Ne K、Fe L、O K 吸收边强度（论文结论：不需要 Ne/O 超丰度） | 同上，13.8–14.8 / 16.5–18.0 / 22.2–25.3 Å 区间 |
| Table 6 第 1 行 | 脉冲周期 7.6726(2) s（MJD 51803.6），源在减速 | `primary/*_evt2.fits.gz`（需 `axbary`） |
| Fig. 1、Fig. 3 | 合并连续谱、四条发射线轮廓（含双峰） | `pha2` 各阶谱 |
| Fig. 4 | Ne X / O VIII 等值宽随时间的下降（本文用 2000→2003 四点） | 只需本目录一行数据点 |
| Fig. 6 | XMM-Newton 能量分辨脉冲轮廓（本文第 1 次观测） | 本目录只有 Chandra，做不了；脉冲轮廓需用 XMM 数据 |

另外，本 ObsID 也是 **Schulz et al. 2001（S01）** 的原始数据（论文中称 "we previously presented analysis of the first Chandra observation in S01"），因此同一套数据可同时用于核对 S01 的双峰线结论。

## 2. 数据来源与版本（已核对 FITS 头）

| 项目 | 值 |
| --- | --- |
| 望远镜 / 仪器 | Chandra ACIS-S + HETG（MEG/HEG），`DATAMODE=FAINT` |
| ObsID / 序列号 | **104** / 400017 |
| 观测起止（UTC） | `DATE-OBS = 2000-09-16T14:58:38`，`DATE-END = 2000-09-17T02:36:11` |
| 曝光 | `EXPOSURE` = `LIVETIME` = 39477.7 s（**39.48 ks**）；`ONTIME` = 39984 s |
| 事件数 | `NAXIS2` = 487,277（`EVENTS` 扩展，26 列） |
| 指向 | `RA_NOM` = 248.054°，`DEC_NOM` = −67.470°，`ROLL_NOM` = 254.05° |
| 归档处理版本 | `ASCDSVER` = **10.9.2**，`CALDBVER` = **4.9.4**（2021-03-25 分发） |
| 产品版本 | `evt2` / `pha2` / 响应 = **N005**；`evt1` / `evt1a` = N004 / N005 |
| 归档直链 | <https://cxc.cfa.harvard.edu/cdaftp/byobsid/4/104/> |
| 数据 DOI | [10.25574/104](https://doi.org/10.25574/104) |
| 下载记录 | 2026-11-24，43 个文件，178.5 MB，0 失败；全部 `.gz` 魔数（1f 8b）校验通过 |

- 目录命名规则为 `byobsid/<ObsID 末位数字>/<ObsID>/`，所以同源的 2003 年数据在 `.../byobsid/4/3504/`。
- `00README` 与 `axaff00104N004_VV001_vv2.pdf`（V&V 报告）是归档原件，写报告时应先读 V&V 报告确认无观测异常。

## 3. 目录内容

```text
ChandraXCT_ObsID104_data/
├── README.md                               # 本文件
├── 00README                                # 归档分发说明（CXC 10.9.2 / CALDB 4.9.4、DOI）
├── oif.fits                                # 归档产品索引
├── axaff00104N004_VV001_vv2.pdf            # 观测 V&V / 质量报告
├── primary/                                # Level 2 产品（可直接分析）
│   ├── acisf00104N005_evt2.fits.gz         # 事件表 19.47 MB，计时/成像/自定义筛选
│   ├── acisf00104N005_pha2.fits.gz         # Type II 光栅谱，12 行谱（HEG/MEG × ±1,2,3）
│   ├── acisf00104_002N004_bpix1.fits.gz
│   ├── acisf00104_002N004_fov1.fits.gz
│   ├── orbitf085406700N001_eph1.fits.gz    # 轨道星历，axbary 用
│   ├── pcadf00104_002N001_asol1.fits.gz    # 姿态解 8.72 MB
│   ├── acisf00104N005_cntr_img2.jpg        # 中心区预览图（0 级已堆叠，仅目视）
│   ├── acisf00104N005_full_img2.jpg
│   └── responses/                          # 只含 ±1 级：HEG/MEG × (m1,p1) 的 ARF+RMF，共 8 个
└── secondary/                              # Level 1 产品（重处理用）
    ├── acisf00104_002N004_evt1.fits.gz     # L1 事件表 91.51 MB，chandra_repro 的输入
    ├── acisf00104_002N004_flt1.fits.gz
    ├── acisf00104_002N004_msk1.fits.gz
    ├── acisf00104_002N004_mtl1.fits.gz
    ├── acisf00104_002N004_stat1.fits.gz
    ├── acisf085503191N004_{0..5}_bias0.fits.gz
    ├── acisf085504494N004_pbk0.fits.gz
    ├── aspect/                             # 9 个 osol / aqual 姿态产品
    └── ephem/                              # angles / lunar / solar 星历
```

### 3.1 为什么只有 ±1 级响应

论文明确只使用 ±1 级（"we combined the ±1 spectral orders of the HETGS data, and used the −1 order of the RGS data"），±2/±3 级没有参与拟合。为控制体积，本次只下载了 `Hm1`、`Hp1`、`Mm1`、`Mp1` 四组 ARF/RMF（共 8 个文件，47.7 MB）。

### 3.2 本次未下载、需要时可补的文件

| 文件 | 大小 | 何时需要 |
| --- | --- | --- |
| `secondary/..._evt1a.fits.gz` | 70.0 MB | 想用归档的 1.5 级 grating 事件产物；一般由 `tg_resolve_events` 从 `evt1` 重新生成即可 |
| `secondary/axaff00104N004_VV001_vvref2.pdf.gz` | 78.6 MB | V&V 的重复参考版，正常分析不需要 |
| `primary/responses/*` 的 ±2、±3 级共 16 个文件 | 95.5 MB | 想看高阶级次或做级次交叉检验 |

补齐方式（任一）：

```bash
# 直接抓单文件
curl -fL -O "https://cxc.cfa.harvard.edu/cdaftp/byobsid/4/104/secondary/acisf00104_002N005_evt1a.fits.gz"
```

```powershell
# 或用仓库里的脚本的 full 档（会补齐上述全部）
powershell -ExecutionPolicy Bypass -File .\codespace\download_obs104.ps1 -Profile full
```

## 4. 怎么用

### 4.1 快路径：直接用归档产品（先跑通论文 Table 2/3/4）

1. `pha2` 定义：`TG_PART=1` 为 HEG、`TG_PART=2` 为 MEG；`TG_M=1/−1` 为 ±1 级（其余 ±2/±3 本次无对应响应）。
2. **必须显式配对响应**：本包 `pha2` 的 `RESPFILE`/`ANCRFILE`/`BACKFILE` 均为 `none`，不会自动找到文件。例如 MEG 负一级 → `TG_PART=2, TG_M=-1` 配 `responses/acisf00104N005_Mm1_arf2.fits.gz` + `_Mm1_rmf2.fits.gz`。
3. 拟合前把 `BIN_LO`/`BIN_HI`（单位 Å）当波长轴，不要把计数谱当流量谱。
4. 论文用 **ISIS 1.3.3 + Cash 统计 + tbnew 吸收模型**；差异归因时要记住模型口径不同（例如用 XSPEC 的 `tbabs` 会与 Table 2/5 有系统差）。

Python 快速检查（在仓库主目录执行，需要 astropy）：

```python
from astropy.io import fits
p = "data/astrodata/ChandraXCT_ObsID104_data/primary/acisf00104N005_pha2.fits.gz"
with fits.open(p) as h:
    s = h["SPECTRUM"].data
    print("行数:", len(s))
    for i in range(len(s)):
        print(i, "TG_PART=", s["TG_PART"][i], "TG_M=", s["TG_M"][i],
              "计数=", int(s["COUNTS"][i].sum()), "BIN_LO=", s["BIN_LO"][i][:3])
```

### 4.2 贴近论文的做法：从 evt1 重处理

论文的做法是"取 level 1 事件表，用 CIAO 3.3 + CALDB 3.2.1 重处理（增益、CTI 改正），用 `tgdetect` 定 0 级位置，再把分散事件分到各衍射级次"。现在等价流程（CIAO 4.18，Linux/WSL/conda）：

```bash
# 1) 重处理 L1 → L2（读 secondary/evt1）
chandra_repro indir=. outdir=../repro_104

# 2) 定 0 级（0 级严重堆叠，仅用于定位）
tgdetect2

# 3) 提取 ±1 级谱（或直接用归档 pha2）
tgextract2

# 4) 计时前做质心改正
axbary acisf00104N005_evt2.fits.gz out_evt2_bary.fits.gz \
       ra=248.054 dec=-67.470 ephem=orbitf085406700N001_eph1.fits.gz
```

## 5. 复现论文时的目标值（摘自论文，供对照）

论文 Table 2（ObsID 104 那一行）：

| 参数 | 论文值 |
| --- | --- |
| N_H | 1.3 (+0.4/−0.3) ×10²¹ cm⁻² |
| 幂律光子指数 Γ | 0.88 ± 0.03 |
| 幂律归一（1 keV） | 12.1 ± 0.5 ×10⁻³ erg cm⁻² s⁻¹ keV⁻¹ |
| 黑体 kT / R | 0.21 ± 0.02 keV / 600 (+400/−200) km (d/10 kpc)² |
| 0.3–10 keV 通量 | 2.2 ×10⁻¹⁰ erg cm⁻² s⁻¹ |
| C²/dof | 1.04 (1844) |

论文 Table 3 单高斯线拟合（ObsID 104，90% 置信区间；线流量单位 10⁻⁵ photons cm⁻² s⁻¹）：

| 谱线 | 中心波长 | 线心速度 (km s⁻¹) | FWHM (km s⁻¹) | 线流量 | 等值宽 (Å) |
| --- | --- | --- | --- | --- | --- |
| Ne X（H 类） | 12.13 Å | 510 ± 340 | 6330 (+860/−690) | 41.3 (+4.6/−4.3) | 0.29 |
| Ne IX（He 类，互组合线主导） | 13.55 Å | 210 (+740/−710) | 4200 (+1800/−1200) | 13.2 (+4.5/−4.1) | 0.10 |
| O VIII（H 类） | 18.97 Å | 1000 (+920/−1250) | 7100 (+3200/−1700) | 60 (+17/−15) | 0.56 |
| O VII（He 类） | 21.80 Å | −688 (+1015/−1057) | 6154 (+1974/−1487) | 77.3 (+26.3/−24.3) | 0.87 |

其他可对照的论文值：双高斯红/蓝移成分速度约 ±1840 km s⁻¹（Ne X，2000 年）、He 类三线 i/r ≈ 2、脉冲周期 **7.6726(2) s**（MJD 51803.6）、He 类禁线缺失（高密度盘等离子体证据）。

## 6. 已知差异（复现时不能直接判为"对不上"）

1. **校准版本不同**：论文用 CIAO 3.3 + CALDB 3.2.1（2006–2007 年的处理），本包是 2021 年重处理（CXC 10.9.2 / CALDB 4.9.4）。ACIS CTI 改正、滤光片污染改正（Marshall et al. 2004）与能标都会带来百分之几量级的差异。
2. **曝光口径不同**：论文 Table 1 写 40 ks（批准时间），实际 `EXPOSURE` = 39.48 ks。算计数率、通量时必须用实际曝光。
3. **模型不同**：论文用 `tbnew`（含 Ne K / Fe L / O K 边精细结构）+ Cash 统计；用 `tbabs` + χ² 拟合不能直接和 Table 2/5 比。
4. **级次合并方式**：论文把 HEG/MEG 的 ±1 级合并后拟合；本目录的 `pha2` 是分行的，合并权重需要自己定义并记录。
5. **0 级堆叠**：论文指出 0 级像严重 piled up，只用于定位。本目录的 `*_cntr_img2.jpg` 仅作目视参考，不要用它做测光。
6. **脉冲周期**：论文的 7.6726 s 是对质心改正后的时间序列做超分辨功率谱得到的（Chakrabarty 1998；Ransom et al. 2002 的误差公式）。不先 `axbary` 就折叠/拟合频率，会得到明显偏离的值。
7. **同一 ObsID 的早期结论**：S01 曾据吸收边主张 Ne/O 超丰度，Krauss 2007 用改进校准后**推翻了**这一结论。复现时若得到"需要超丰度"，先检查是不是用了旧的吸收边处理。

## 7. 复现检查清单

- [ ] 读 `00README`、`axaff00104N004_VV001_vv2.pdf`，确认观测无异常
- [ ] 核对 `evt2` 头的 ObsID / 日期 / 曝光 / 事件数与本文第 2 节一致
- [ ] `pha2` 12 行谱与 `responses/` 里的 8 个 ±1 级响应正确配对（不同 ObsID / 臂 / 级次绝不能混用）
- [ ] 连续谱拟合结果 vs Table 2 第 1 行
- [ ] 四条线的线心、线宽、流量、EW vs Table 3（双峰结构 vs Table 4）
- [ ] Ne IX / O VII 三线的 i/r 比与禁线是否缺失 vs 第 5.2 节
- [ ] 吸收边强度 vs Table 5（判断是否仍需要 Ne/O 超丰度）
- [ ] `axbary` 后测周期 vs Table 6（7.6726 s）
- [ ] 差异逐项归因（校准版本 / 模型 / 级次合并 / 统计量），写入分析记录

## 8. 引用与致谢

用于发表时，按 Chandra 归档要求致谢并引用数据 DOI：

> 本工作使用了 Chandra 数据档案（Chandra Data Archive）中 ObsID 104 的数据（DOI: 10.25574/104）。
> *The scientific results reported in this article are based on data obtained from the Chandra Data Archive.*

并引用论文 Krauss et al. 2007, ApJ, 660, 605 与软件 CIAO（"This research has made use of software provided by the Chandra X-ray Center (CXC) in the application packages CIAO, ChIPS, and Sherpa."）。

## 9. 变更记录

| 日期 | 变更 |
| --- | --- |
| 2026-11-24 | 首次下载 43 个文件（178.5 MB），建立本说明；用途确定为验证 Krauss et al. 2007 |
