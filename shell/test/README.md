
# Server Hardware Info Report Script (服务器硬件信息报告脚本)

这是一个功能强大的Bash脚本，用于检测物理服务器或VPS的详细硬件信息，并生成一份美观、易于阅读的报告。它特别适合服务器管理员、运维工程师以及所有需要在Linux环境下快速了解硬件配置的用户。


---
> AI制作的脚本跟文档,自用
## ✨ 功能特性 (Features)

* **全面的硬件检测**:
    * **系统**: 主机名、操作系统版本、内核、运行时间。
    * **处理器**: 型号、核心数、线程数、频率、缓存、实时使用率。
    * **内存**: 总量、已用、可用，并能详细列出每个物理内存条的型号、制造商、频率、序列号等。
    * **硬盘**: 磁盘分区使用情况，并能深入检测每块物理硬盘的型号、容量、SMART健康状态、通电时间、总读写量、磨损度及温度。
    * **RAID**: 检测硬件RAID控制器。
    * **网络**: 列出所有物理网卡的型号、状态、IP地址(IPv4/IPv6)、MAC地址、速度和实时流量。
    * **显卡**: 检测VGA兼容的图形控制器。
    * **主板**: 显示主板和BIOS的制造商、型号及版本。
* **美观的报告格式**: 仿 `neofetch` 风格，使用box-drawing字符将信息分块展示，清晰直观。
* **智能依赖处理**: 脚本会自动检测运行所需的命令。**从v1.2.0版本开始，如果检测到依赖缺失，它会提示用户并可自动安装**，极大提升了便利性。
* **跨发行版支持**: 自动检测并支持主流的Linux发行版，如 Debian, Ubuntu, CentOS, RHEL, Fedora 等。

## 🚀 使用方法 (Usage)

### 完全版本(自动安装依赖)

您只需要在您的服务器上以 `root` 权限运行一行命令即可。

**通过 `curl` 运行:**
```bash
bash <(curl -sL https://raw.githubusercontent.com/Dxdmk/dx/refs/heads/main/shell/test/test.sh)
```

**通过 `WGET` 运行:**
```bash
bash <(wget -qO- https://raw.githubusercontent.com/Dxdmk/dx/refs/heads/main/shell/test/test.sh)
```


### 精简版本(无依赖)
**通过 `curl` 运行:**
```bash
bash <(curl -sL https://raw.githubusercontent.com/Dxdmk/dx/refs/heads/main/shell/test/test2.sh)
```

**通过 `WGET` 运行:**
```bash
bash <(wget -qO- https://raw.githubusercontent.com/Dxdmk/dx/refs/heads/main/shell/test/test2.sh)
```


## 📋 报告预览 (Preview)

```
════════════════════════════════════════════════════════════════════════════════
                    系统硬件信息报告
════════════════════════════════════════════════════════════════════════════════
┌─ 系统信息
├──────
│ 主机名           : HZ001
│ 操作系统        : Debian GNU/Linux 12 (bookworm)
│ 内核版本        : 6.1.0-37-amd64
│ 运行时间        : 9 days
└──────────────────────────────────────────────────
┌─ 处理器信息
├──────
│ 型号              : AMD Ryzen 9 5950X 16-Core Processor
│ 核心数           : 16
│ 线程数           : 32
│ 频率              : 3400.0000 MHz
│ 缓存              : 64MiB
│ 使用率           : 2.9%
└──────────────────────────────────────────────────
┌─ 内存信息
├──────
│ 总计              : 125Gi
│ 已用              : 25Gi
│ 可用              : 100Gi
│
│ Memory Modules:
├────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ │ 大小   │ 类型 │ 频率       │ 制造商    │ 序列号       │ 型号               │
├────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ │ 32 GB    │ DDR4   │ 2666 MT/s    │ Samsung      │ 01DFAF94        │ M391A4G43AB1-CWE     │
│ │ 32 GB    │ DDR4   │ 2666 MT/s    │ Samsung      │ 01DFAF11        │ M391A4G43AB1-CWE     │
│ │ 32 GB    │ DDR4   │ 2666 MT/s    │ Samsung      │ 01DFAE6E        │ M391A4G43AB1-CWE     │
│ │ 32 GB    │ DDR4   │ 2666 MT/s    │ Samsung      │ 01DFAC97        │ M391A4G43AB1-CWE     │
└────────────────────────────────────────────────────────────────────────────────────────────────────┘
└──────────────────────────────────────────────────
┌─ 硬盘信息
├──────
│
│ Physical Disks Details:
││ ═══ /dev/nvme1n1 ═══
│   Basic Info:     3.5TB SAMSUNG MZQL23T8HCLS-00A07
│   SMART状态:    PASSED
│   通电时间:   32567 hours
│   Data Transfer Statistics:
│     总读取量:   925.798TB (SMART硬件累计)
│     总写入量:   109.138TB (SMART硬件累计)
│   磨损程度:   3%
│   温度:         38°C
││ ═══ /dev/nvme0n1 ═══
│   Basic Info:     3.5TB SAMSUNG MZQL23T8HCLS-00A07
│   SMART状态:    PASSED
│   通电时间:   26712 hours
│   Data Transfer Statistics:
│     总读取量:   908.172TB (SMART硬件累计)
│     总写入量:   85.028TB (SMART硬件累计)
│   磨损程度:   2%
│   温度:         40°C
└──────────────────────────────────────────────────
┌─ 网卡信息
├──────
│
│ ═══ enp7s0 ═══
│ 型号              : Intel Corporation I210 Gigabit Network Connection (rev 03)
│ 状态              : UP
│ IPv4                : xx/26
│ IPv6                : 2a01:4f8:xxx:xxx::2/64
│                       fe80::7e10:xxx:xxx:xxx64
│ MAC地址           : 7c:10:c9:21:f1:c3
│ 速度              : 1000Mb/s
│ 双工模式        : Full
│ 链接检测        : yes
│ RX                  : 36.91TB
│ TX                  : 72.93TB
└──────────────────────────────────────────────────
┌─ 显卡信息
├──────
│ Graphics Cards (PCI):
│   06:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family (rev 41)
│
│ Display Hardware Summary:
│   ============================================================
│          description: VGA compatible controller
│          product: ASPEED Graphics Family
│          vendor: ASPEED Technology, Inc.
│          physical id: 0
│          bus info: pci@0000:06:00.0
│          width: 32 bits
│          clock: 33MHz
│          capabilities: pm msi vga_controller bus_master cap_list rom fb
│          configuration: depth=32 driver=ast latency=0 resolution=1280,1024
│          resources: irq:34 memory:f8000000-fbffffff memory:fc000000-fc01ffff ioport:f000(size=128) memory:c0000-dffff
└──────────────────────────────────────────────────
┌─ 主板信息
├──────
│ 厂商              : ASUSTeK COMPUTER INC.
│ 型号              : Pro WS 565-ACE
│ Version             : Rev X.0x
│
│ BIOS Vendor         : American Megatrends Inc.
│ BIOS Version        : 3606
└──────────────────────────────────────────────────
报告生成完成！
```

## 📜 版本历史 (Changelog)

### `v1.2.0` - 2025-07-19 (最新版)
* **[功能] 新增依赖自动安装**:
    * 脚本在启动时会检查所有必需的命令。
    * 如果发现依赖缺失，会提示用户并在倒计时后，根据当前系统（Debian/Ubuntu/CentOS等）调用相应的包管理器（`apt-get`, `dnf`, `yum`）进行自动安装。
    * 安装后会进行二次验证，确保所有依赖都已成功安装。

### `v1.1.0`
* **[修复] 改进硬件兼容性**:
    * **CPU**: 修正了在AMD Ryzen等平台上，处理器型号、线程数和频率解析错误的问题。
    * **内存**: 重写了`dmidecode`的解析逻辑，使其能更稳定地识别不同主板和DMI布局下的物理内存条信息。
    * **硬盘**: 修复了`numfmt`命令在某些系统版本上因不兼容的格式化参数而报错的问题，确保硬盘容量能正确显示。
    * **网络**: 优化了IPv6地址的显示，当一个网卡拥有多个IPv6地址时，会自动换行对齐，使输出更整洁。

### `v1.0.0`
* **[功能] 初始版本**:
    * 实现了所有核心信息的检测与报告生成。
    * 包含了美观的格式化输出。
    * 实现了手动的依赖检查，如果缺少依赖会提示用户手动安装。

## 🛠️ 依赖 (Dependencies)

为了获取详尽的硬件信息，本脚本依赖于以下命令行工具。在 `v1.2.0` 及更高版本中，脚本会尝试自动安装它们。

* `coreutils`
* `procps`
* `util-linux`
* `dmidecode`
* `smartmontools` (`smartctl`)
* `pciutils` (`lspci`)
* `ethtool`
* `iproute2` (`ip`)
* `lshw`
* `jq`


