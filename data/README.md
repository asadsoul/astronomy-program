# data：天文数据与参考文献使用说明

本目录服务于“4U 1626−67 在新自转减速阶段的 X 射线观测研究”。按照[主目录 README](../README.md) 的约定，`astrodata/` 存放天文数据，`paper/` 存放参考文献；新增或更新资料时，需要同步说明来源、用途和使用方式。

本说明根据现有文件、FITS 文件头、归档自带的 `00README` 以及文献标题和摘要整理，最后核对日期：2026-11-24。以下操作示例用于入门，不代表本项目已经完成对应的科学分析。

## 1. 目录与使用入口

```text
data/
├── README.md
├── astrodata/
│   ├── ChandraXCT_ObsID104_data/     # ObsID 104（2000），验证 Krauss 2007 用
│   └── package_350687_261107223325/
│       ├── 24700/
│       ├── 26204/
│       └── 27954/
└── paper/
    ├── *.pdf
    └── Zhou2025.txt
```

- 只想看观测图片：打开各观测 `primary/` 下的 `*_full_img2.jpg`（全视场）或 `*_cntr_img2.jpg`（中心区域）。
- 想看光子位置、做图像和时变分析：从 `primary/*_evt2.fits.gz` 开始。
- 想研究氧、氖发射线：从 `primary/*_pha2.fits.gz` 和同一观测的 `primary/responses/` 开始。
- 想了解观测质量或重新处理：查看观测质量报告、`secondary/` 及 CIAO 文档。
- 想找研究依据和历史结果：查看第 5 节的文献索引。

文献的逐篇阅读说明、建议顺序、分析对照项目及版本管理见 [paper 文献阅读与使用指南](paper/README.md)。

## 2. astrodata：四组 Chandra 观测

数据包来自 Chandra Data Archive，目录名中的数字是 ObsID。四组数据的目标均为 `4U 1626-67`，均使用 ACIS 探测器与 HETG 光栅（`DATAMODE=FAINT`）。

| ObsID / 本地目录 | `DATE-OBS` 原值 | `DATE-END` 原值 | `EXPOSURE`（ks） | 在课题中的用途 |
| --- | --- | --- | --- | --- |
| [104](astrodata/ChandraXCT_ObsID104_data/) | 2000-09-16T14:58:38 | 2000-09-17T02:36:11 | 39.478 | 验证 Krauss et al. 2007 的 2000 年 HETGS 结果；本项目的历史基线 |
| [26204](astrodata/package_350687_261107223325/26204/) | 2021-11-13T07:16:05 | 2021-11-13T12:48:03 | 17.129 | 2023 年反转前的历史对照 |
| [24700](astrodata/package_350687_261107223325/24700/) | 2022-01-05T21:51:52 | 2022-01-06T01:51:37 | 11.757 | 2023 年反转前的历史对照 |
| [27954](astrodata/package_350687_261107223325/27954/) | 2023-07-29T14:56:10 | 2023-07-29T23:50:42 | 29.337 | 新自转减速阶段的主要研究数据 |

表中时间直接抄自各 `EVENTS` 扩展的文件头，未换算为北京时间；曝光量为 `EXPOSURE/1000`，并非起止时间相减。前两组（26204、24700）按文献中的长期演化划分作为第二次加速阶段的对照，具体力矩状态仍应与长期计时资料交叉核对。**不能把 2021–2023 的三组数据当作同一阶段，也不能把它们与 2000 年的 104 混成一组比较。**

前三组归档产品的 `ASCDSVER` 均为 `10.14.1.1`，`CALDBVER` 均为 `4.12.2`；`104` 是 2021 年分发的 `10.9.2` / `4.9.4`，代次更早，跨观测比较时必须记录。归档 `00README` 首页的日期是数据分发说明日期，不是观测日期，也不等于本仓库的下载日期。

| ObsID | 原始归档说明 | 数据引用 / 观测详情 |
| --- | --- | --- |
| 104 | [00README](astrodata/ChandraXCT_ObsID104_data/00README) | [DOI: 10.25574/104](https://doi.org/10.25574/104) · [观测详情](https://cda.cfa.harvard.edu/srservices/ocatDetails?obsid=104) |
| 24700 | [00README](astrodata/package_350687_261107223325/24700/00README) | [DOI: 10.25574/24700](https://doi.org/10.25574/24700) · [观测详情](https://cda.cfa.harvard.edu/srservices/ocatDetails?obsid=24700) |
| 26204 | [00README](astrodata/package_350687_261107223325/26204/00README) | [DOI: 10.25574/26204](https://doi.org/10.25574/26204) · [观测详情](https://cda.cfa.harvard.edu/srservices/ocatDetails?obsid=26204) |
| 27954 | [00README](astrodata/package_350687_261107223325/27954/00README) | [DOI: 10.25574/27954](https://doi.org/10.25574/27954) · [观测详情](https://cda.cfa.harvard.edu/srservices/ocatDetails?obsid=27954) |

### 2.1 每组观测里的文件怎么用

下表路径均相对于单个 ObsID 目录；`*` 表示文件名中的观测号、时间戳或产品版本等可变部分。

| 路径 / 文件类型 | 保存什么 | 使用方式 |
| --- | --- | --- |
| `00README` | 归档分发信息、软件和校准版本、DOI、引用要求 | 先读来源说明，写报告时记录 ObsID 和 DOI |
| `oif.fits` | 观测产品索引 | 查找归档产品及文件关联；不是天体图片 |
| `axaff*vv2.pdf` | 观测验证与质量报告 | 分析前查看异常、质量说明和处理情况 |
| `primary/*_full_img2.jpg`、`*_cntr_img2.jpg` | 归档生成的全场 / 中心预览图 | 图片查看器或 VS Code 直接打开；用于目视检查，不用于精确测量光子数或流量 |
| `primary/*_evt2.fits.gz` | 经过归档流水线处理和筛选的 Level 2 光子事件表，附 GTI 等扩展 | DS9 显示空间分布；CIAO / Astropy 读取后做选区、光变和事件筛选 |
| `primary/*_pha2.fits.gz` | Type II 光栅谱，一个表中保存多个光栅臂和衍射级次的光谱 | 按 `TG_PART`、`TG_M` 选择谱，配合 ARF / RMF 做能谱拟合 |
| `primary/responses/*_arf2.fits.gz` | ARF：有效面积随能量变化的响应 | 与同 ObsID、同光栅臂、同级次的谱和 RMF 配套使用 |
| `primary/responses/*_rmf2.fits.gz` | RMF：真实光子能量到探测通道的再分布响应 | 用于响应卷积和谱线拟合；不能当成观测光谱 |
| `primary/*_bpix1.fits.gz` | 坏像素 / 坏列信息 | 校准、筛选和重处理时使用，不是天体照片 |
| `primary/*_fov1.fits.gz` | 探测器视场范围 | 检查目标、背景区及光栅谱臂是否位于有效视场 |
| `primary/*_asol1.fits.gz` | 姿态解（望远镜指向随时间变化） | 重投影、图像和响应计算的辅助输入 |
| `primary/orbit*_eph1.fits.gz` | 卫星轨道星历 | CIAO 质心时间校正等处理的辅助输入 |
| `secondary/*_evt1.fits.gz`、`*_evt1a.fits.gz` | 归档附带的 Level 1 事件产品 | 重处理时使用；具体差别查文件头和处理历史，日常预览优先用 `evt2` |
| `secondary/*_flt1.fits.gz` | 事件过滤相关信息 / 时间区间 | 检查筛选条件、GTI 或重新处理 |
| `secondary/*_msk1.fits.gz` | 有效像素掩模 | 校准和响应计算的辅助输入 |
| `secondary/*_mtl1.fits.gz`、`*_stat1.fits.gz` | 仪器运行记录和统计信息 | 排查异常和质量问题 |
| `secondary/*_bias0.fits.gz`、`*_pbk0.fits.gz` | 偏置帧、处理参数等低层产品 | 交给校准 / 重处理流程使用 |
| `secondary/aspect/*_osol1.fits.gz`、`*_aqual1.fits.gz` | 姿态解相关产品和姿态质量信息 | 诊断指向、姿态及校准问题 |
| `secondary/ephem/*_eph1.fits.gz` | 太阳、月球、几何角度等辅助星历 | 特定校准或诊断流程使用，不与卫星轨道文件混用 |
| `secondary/*_vvref2.pdf.gz` | 压缩的验证参考报告 | 解压副本后查看，配合 `vv2.pdf` 判断质量 |

`.fits.gz` 是 gzip 压缩的 FITS；DS9、Astropy 和许多 CIAO 工具可以直接读取，无需逐个解压。文件名中的 `N002` 等是产品版本标记，不是观测年份。

### 2.2 evt2：事件表字段

本包的 `evt2` 主 HDU 没有二维图像，科学数据在 `EVENTS` 二进制表扩展中。成像需要按光子位置分箱计数。

| 字段 | 含义 / 单位 | 适合的用途 |
| --- | --- | --- |
| `time` | 事件时间，单位 s；基准和时间系统见文件头 | 光变曲线、脉冲周期、功率谱 |
| `x`、`y` | 天空投影坐标，单位 pixel | 事件成像和天区选区 |
| `chipx`、`chipy`、`ccd_id` | 探测器坐标及 CCD 编号 | 检查坏像素、芯片边界和探测器效应 |
| `energy` | CCD 重建能量，单位 eV | 能段筛选；例如 0.5–8 keV 对应 500–8000 eV |
| `tg_lam` | 光栅波长，单位 Å | 光栅谱线分析；应同时选择有效的光栅臂和级次 |
| `tg_part`、`tg_m` | 光栅臂编号、带正负号的衍射级次 | 区分 HEG / MEG 以及正、负级次 |
| `grade`、`status` | 事件等级与状态 | 按校准流程检查事件筛选；不要随意改动筛选条件 |

`GTI` 是有效观测时间区间，本包每组事件文件包含多个 CCD 对应的同名 GTI 扩展。计算计数率、功率谱或相位曝光时，需要使用与所选事件对应的 GTI 和活时间，不能直接用文件起止时间当作连续曝光。

### 2.3 pha2 与响应的配对

每组 `pha2` 含 12 行谱，对应 HEG、MEG 各自的 ±1、±2、±3 级；每组 `responses/` 有 24 个文件，即每条谱各一份 ARF 和 RMF。

| 文件名标记 | 光栅臂 / 级次 | `pha2` 选择条件 |
| --- | --- | --- |
| `H` | HEG（高能光栅） | `TG_PART=1` |
| `M` | MEG（中能光栅） | `TG_PART=2` |
| `p1`、`p2`、`p3` | 正 1、2、3 级 | `TG_M=1, 2, 3` 中对应的一个值 |
| `m1`、`m2`、`m3` | 负 1、2、3 级 | `TG_M=-1, -2, -3` 中对应的一个值 |

例如，27954 的 MEG 负一级谱选择 `TG_PART=2`、`TG_M=-1`，配套 `acisf27954N002_Mm1_arf2.fits.gz` 和 `acisf27954N002_Mm1_rmf2.fits.gz`。不要混用不同 ObsID、光栅臂或级次的响应。

本包 `pha2` 的 `RESPFILE`、`ANCRFILE`、`BACKFILE` 为 `none`，不能假定拟合软件会自动找到响应和背景；需要在载入后显式配对，或按 CIAO 的光栅谱提取流程生成配套产品。表内有 `BACKGROUND_UP`、`BACKGROUND_DOWN` 和相关缩放信息，背景处理应按工具文档进行。

`BIN_LO`、`BIN_HI` 的单位为 Å，`COUNTS` 为计数；不要把波长轴直接标成 keV，也不要把计数谱直接当作物理流量谱。初步可分别检查 HEG / MEG 的正负一级谱，再决定联合拟合或合并，记录相应的响应和背景处理。

### 2.4 ChandraXCT_ObsID104_data：验证 Krauss 2007 用的数据

`astrodata/ChandraXCT_ObsID104_data/` 是 Krauss et al. 2007（ApJ 660, 605）所用 **Chandra HETGS 2000-09-16 观测（ObsID 104）** 的归档数据，用途是**逐项核对论文中的谱线与计时结果**，不是本项目的新观测；它同时也是 Schulz et al. 2001（S01）的原始数据。完整说明、论文目标值对照表、已知差异与复现检查清单见该目录下的 [README](astrodata/ChandraXCT_ObsID104_data/README.md)。

与第 2 节前三组的区别：

- **只有 ±1 级响应**（8 个 ARF/RMF）。论文只使用 ±1 级（"combined the ±1 spectral orders"），未用 ±2/±3 级。
- 未下载 `evt1a`（70 MB）与 `vvref2`（79 MB）；需要时用 `codespace/download_obs104.ps1 -Profile full` 或按该目录 README 3.2 小节的直链补齐。
- 分析目标不是新结果，而是**复现论文数值**；对不上的地方要归因到校准版本（论文为 CIAO 3.3 + CALDB 3.2.1，本包为 CXC 10.9.2 / CALDB 4.9.4）、模型（`tbnew` + Cash）或级次合并方式，不能直接当作新物理结论。
- 论文另一组 HETGS 数据 `ObsID 3504`（2003-06-03）尚未下载；要做 2000→2003 的线流量 / 等值宽演化（Fig. 4），需补 <https://cxc.cfa.harvard.edu/cdaftp/byobsid/4/3504/>。

## 3. 从打开文件到开展分析

### 3.1 看观测图像

27954 的直接入口：

- [全视场预览 JPG](astrodata/package_350687_261107223325/27954/primary/acisf27954N002_full_img2.jpg)
- [中心区域预览 JPG](astrodata/package_350687_261107223325/27954/primary/acisf27954N002_cntr_img2.jpg)
- [Level 2 事件文件](astrodata/package_350687_261107223325/27954/primary/acisf27954N002_evt2.fits.gz)

需要交互查看事件图像时，用 [SAOImage DS9](https://sites.google.com/cfa.harvard.edu/saoimageds9) 打开 `evt2`，选择 `Scale → Log`、`Zoom → Fit`。光栅观测可能出现零级亮源和分散的谱臂，不能把所有延展结构都直接解释为天体的真实形态。

VS Code 中，只支持二维 FITS 图像的扩展（如本机此前使用的 Simple FITS viewer）不能直接把 `EVENTS` 变成观测图片。表格查看器可以检查列和行；要成像，需使用事件分箱功能，或先生成二维计数 FITS 再打开。

### 3.2 用 Python 查看事件表

需要 Python、Astropy 和 NumPy；缺少依赖时运行 `python -m pip install astropy numpy`。下面代码从**仓库主目录**执行，可直接读取压缩文件，仅查看数据，不修改归档产品：

```python
from pathlib import Path
from astropy.io import fits

base = Path("data/astrodata/package_350687_261107223325")
path = base / "27954/primary/acisf27954N002_evt2.fits.gz"

with fits.open(path) as hdul:
    hdul.info()
    events = hdul["EVENTS"]
    print("观测时间：", events.header["DATE-OBS"])
    print("曝光量（s）：", events.header["EXPOSURE"])
    print("各列及单位：", events.columns)
    print("前 5 个光子：")
    for row in events.data[:5]:
        print({name: row[name] for name in ("time", "x", "y", "energy")})
```

### 3.3 时变与能谱分析的顺序

1. **质量与校准**：先看 `vv2.pdf` 和事件头。正式比较多期观测时，核对 CIAO / CALDB 版本；如需重处理，保留输入目录，输出到独立位置，并记录版本、命令和参数。三个 `evt2` 是归档产品，不等同于完全未经处理的原始探测记录。
2. **时变分析**：从 `evt2` 选源区、背景区和能段；记录所用光栅臂与级次。三组头部均为 `TIMESYS=TT`、`TIMEREF=LOCAL`、`MJDREF=50814.0`，尚不是太阳系质心时间。精确计时前用 CIAO `axbary` 等工具结合卫星轨道星历和准确源坐标做质心校正；转移 GTI 时同步处理时间基准。
3. **时间分箱**：本包 `TIMEDEL=1.74104 s`，是选择时间分辨率的重要依据。约 7.7 s 的脉冲每周期只有约 4.4 个这样的时间间隔，限制精细脉冲轮廓；更细的绘图分箱不会产生新的时间分辨率。计算光变、周期和功率谱时，记录分箱、曝光修正、归一化、背景及噪声处理。
4. **高分辨率能谱**：从 `pha2` 选定光栅臂 / 级次并配对 ARF、RMF；需要自定义筛选或相位分辨谱时，从校准后的事件重新提取并使用相匹配的响应与背景。用 Sherpa / XSPEC 等工具拟合连续谱与氧、氖谱线，记录模型、拟合范围、统计量、分组方式和误差定义。
5. **跨观测比较**：将 27954 与 26204、24700 分别比较；保持选区、能段、级次和模型口径一致，并处理曝光、响应和校准差异。不要只凭总光子数比较源亮度，也不要未经检查就把反转前后的数据合成一条谱。

CIAO 处理命令应在已经安装和初始化 [CIAO](https://cxc.cfa.harvard.edu/ciao/) 的环境中执行（Windows 用户可使用配好的 Linux / WSL 环境）；Astropy 示例可在本地 Python 运行。CIAO 数据说明和分析入口见 [Chandra 数据产品指南](https://cxc.cfa.harvard.edu/ciao/data_products_guide/) 与 [CIAO 分析线程](https://cxc.cfa.harvard.edu/ciao/threads/)；在其中查找 ACIS/HETG 重处理、光栅谱提取和 `axbary` 的具体用法。

## 4. 分析产物放哪里、记录什么

归档下载包保留原有目录、文件名和 `00README`，重处理、筛选、质心校正及谱提取生成的文件使用独立输出目录，不覆盖归档输入。以下是建议组织方式，尚不表示这些目录或产物已经存在：

```text
data/astrodata/processed/<ObsID>/<处理任务>/
├── README.md
└── <处理后的事件、光变、光谱、响应等>
```

处理代码放在主目录约定的 `codespace/`，未完成的分析文字放在 `draft/`，供 Markdown 引用的图放在 `picture/`。每个处理任务至少记录输入路径和 ObsID、输出文件含义、软件 / 校准版本、执行步骤和筛选参数；表格记录列名及单位，图片记录对应的数据和绘图脚本。派生谱需记录与其对应的背景、ARF、RMF，时变产物需记录时间系统和是否做过质心校正。

## 5. paper：参考文献索引与用途

目前有 18 份 PDF 和 1 份 TXT。下表按现存文件逐一说明用途；它们提供研究依据和方法参考，不代表仓库已经包含文中使用的全部望远镜数据，也不代表文献中的数值是本项目的测量结果。

### 5.1 高分辨率光谱与观测对照

| 文件 | 内容与建议用途 |
| --- | --- |
| [Schulz2001_4U1626_HETGS.pdf](paper/Schulz2001_4U1626_HETGS.pdf) | *Double-Peaked X-Ray Lines from the Oxygen/Neon-Rich Accretion Disk in 4U 1626−67*。了解早期 HETGS 氧、氖双峰谱线及盘起源解释，作为谱线识别和历史线型对照。 |
| [Krauss_2007_ApJ_660_605.pdf](paper/Krauss_2007_ApJ_660_605.pdf) | *High-Resolution X-Ray Spectroscopy of the Ultracompact LMXB Pulsar 4U 1626−67*。比较 Chandra / XMM 多次观测的线强、线宽、吸收边和时变性质，注意其对早期丰度解释的修订。 |
| [Schulz2019_collisional.pdf](paper/Schulz2019_collisional.pdf) | *Collisional Ionization in the X-ray Spectrum of the Ultracompact Binary 4U 1626−67*。研究碰撞电离、内盘发射与力矩反转前后线型，作为等离子体模型和盘半径解释的参考；本地为 2019 年 arXiv 预印本。 |
| [Hemphill_2021_ApJ_920_142.pdf](paper/Hemphill_2021_ApJ_920_142.pdf) | *Chandra/LETGS Studies of the Collisional Plasma in 4U 1626−67*。参考双温碰撞等离子体、O / Ne 发射线及丰度约束；使用的是 LETGS，不能直接套用本包 HETG 的响应或分辨率。 |
| [HRXS-Schulz.pdf](paper/HRXS-Schulz.pdf) | *The Hot Inner Disk Environment and Torque Reversals in 4U 1626−67*，2023 年 Chandra HiRes Workshop 报告幻灯片。用于了解近期高分辨率观测与内盘问题，引用时注明报告属性，不当作期刊论文。 |
| [aa19656-12_billingual.pdf](paper/aa19656-12_billingual.pdf) | Camero-Arranz 等，2012，*4U 1626–67 as seen by Suzaku before and after the 2008 torque reversal*。用于对照 2008 年反转前后的软 X 射线线复合体、宽带谱和回旋特征；正式引用原文，不以文件名判断文献性质。 |
| [X射线偏振探测.pdf](paper/X射线偏振探测.pdf) | Marshall 等，2022，*Observations of 4U 1626–67 with the Imaging X-Ray Polarimetry Explorer*。了解 IXPE 偏振、NICER 计时及同期 Chandra 光谱的联合约束；本目录未收录对应 IXPE / NICER 观测文件。 |

### 5.2 力矩反转、脉冲与 QPO

| 文件 | 内容与建议用途 |
| --- | --- |
| [Chakrabarty1997_torque_reversal.pdf](paper/Chakrabarty1997_torque_reversal.pdf) | *Torque Reversal and Spin-Down of the Accretion-Powered Pulsar 4U 1626−67*。了解早期加速转减速的长期计时证据和力矩问题。 |
| [CameroArranz2010_reversal.pdf](paper/CameroArranz2010_reversal.pdf) | *New Torque Reversal and Spin-Up of 4U 1626–67 Observed by Fermi/GBM and Swift/BAT*。用于 2008 年反转的长期计时、流量和硬度比较；本地 PDF 为 2009 年 arXiv 版本，正式引用时核对出版信息。 |
| [流量增强相关的光谱和时变变化.pdf](paper/流量增强相关的光谱和时变变化.pdf) | Jain、Paul、Dutta，2010，*Spectral and temporal changes associated with flux enhancement in 4U 1626−67*。参考流量增强、脉冲轮廓及功率谱变化的分析方式。 |
| [Sharma2023_spindown.pdf](paper/Sharma2023_spindown.pdf) | *4U 1626-67 Returns to Spin-Down: Timing features toe the line*，2023 年 arXiv 版本。新减速阶段的重要背景，涉及 NuSTAR 脉冲、约 47 mHz QPO 及宽带谱。 |
| [恢复自转：计时特征.pdf](paper/恢复自转：计时特征.pdf) | 与上一项同一篇研究的 MNRAS 2023 期刊版本（526，L35–L40）；标题实际为“回到自转减速”。两份是同一研究的不同版本，不能作为两项独立观测结论重复统计；正式引用优先核对期刊版本。 |
| [Zhou2025.txt](paper/Zhou2025.txt) | *QPOs in a highly magnetized ultra-compact X-ray binary 4U 1626−67* 的文本，文内草稿日期为 2025-10-14。参考 HHT、QPO 相位分辨计时和能谱分析；文本存在提取乱码，公式、图表和数值需回到原始论文核对，本地未附对应 PDF。 |
| [Pottschmidt2026_pulseprofiles.pdf](paper/Pottschmidt2026_pulseprofiles.pdf) | *Pulse profiles of accreting neutron stars – A review of analysis methods, observations, and theoretical models*。脉冲轮廓方法综述，可用于能量依赖、轮廓比较和模型背景；本地为 2026 年 arXiv 版本。 |

### 5.3 理论模型与综述

| 文件 | 内容与建议用途 |
| --- | --- |
| [Gencali2022_reversals.pdf](paper/Gencali2022_reversals.pdf) | *On the torque reversals of 4U 1626–67*。对照内盘半径、共转半径和力矩变化模型；文件名虽写 2022，本地首页为 2021 年 arXiv 版本，引用前核对。 |
| [vanKerkwijk1998_warp.pdf](paper/vanKerkwijk1998_warp.pdf) | *Warped Disks as a Possible Origin of Torque Reversals in Accretion-Powered Pulsars*。了解盘翘曲及逆行内盘解释，作为模型假说而非已经确定的本源结构。 |
| [OLeary2026_4U1626_retrograde.pdf](paper/OLeary2026_4U1626_retrograde.pdf) | *Is there a retrograde accretion disk around 4U 1626−67? Tracking torque reversals with a state-space model*。参考状态空间模型及顺行 / 逆行盘模型比较；文件名虽写 2026，本地为 2025 年 arXiv 版本，结论需按其统计证据强度理解。 |
| [Bildsten1997_review.pdf](paper/Bildsten1997_review.pdf) | *Observations of Accreting Pulsars*。吸积脉冲星长期监测、频率与力矩的基础综述，用于研究背景及计时概念。 |
| [MushtukovTsygankov2022_review.pdf](paper/MushtukovTsygankov2022_review.pdf) | 强磁场吸积中子星 / X 射线脉冲星综述。用于补充吸积柱、磁场、辐射转移和宽带谱物理背景。 |

建议先读 Sharma 2023 的期刊版本了解本课题所处阶段，再读 Krauss 2007、Schulz 2019 和 Hemphill 2021 建立高分辨率谱分析思路；LETGS、Suzaku、NuSTAR、IXPE 等工作用于方法或历史对照，比较时注明仪器、能段和自转阶段。

## 6. 新增和更新资料的记录规则

根据主目录“放入资料时写 README 说明用途”的要求，本目录采用以下维护约定：

1. 天文观测放 `astrodata/`，文献放 `paper/`；新增批次可在子目录另写 README，同时在本文件添加索引。
2. 天文数据至少记录望远镜 / 仪器、目标、ObsID、实际观测时间、曝光量、来源链接或 DOI、下载日期（已知时）、处理级别和用途。不要从压缩包名、修改时间或说明文件日期推断观测日期。
3. 派生数据补充输入路径、生成步骤、软件 / 校准版本、筛选条件、单位、时间系统和输出含义，使其他成员能够复现。
4. 文献至少记录作者、实际版本 / 年份、题目、来源 DOI / ADS / arXiv（已知时）、与课题的关系；中文译名、预印本、期刊版、报告和重复版本需注明。现有索引未提供的 DOI 或出版信息，待核对后补充，不按文件名猜测。
5. 数据或文献被替换、补充、重新处理时，同步更新用途、文件路径和版本说明；正文引用已发表结果时标注文献，项目测量结果注明输入与分析步骤。
6. 发表或提交正式报告时，按各 `00README` 的说明引用实际使用的 ObsID / DOI，并注明 Chandra 数据来源及所用 CIAO 等软件。

后续新增记录可使用以下模板：

```text
文件或目录：
类型：天文观测 / 派生数据 / 文献
来源链接或 DOI：
ObsID 或作者、题目与版本：
观测时间 / 文献年份：
下载或更新日期：
用途：
打开方式或复现步骤：
输入、依赖和处理参数（如适用）：
输出、列名和单位（如适用）：
注意事项及版本关系：
```
