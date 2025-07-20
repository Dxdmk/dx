#!/usr/bin/env bash
#
# Hardware Info Report Script (Minimalist Edition)
# 版本: 1.0.0 (无额外依赖)
#

# --- 样式定义 ---
header_line="════════════════════════════════════════════════════════════════════════════════"
title_text="系统硬件信息报告 (精简版)"

print_header() {
    local title="$1"
    echo "┌─ $title"
    echo "├──────"
}
print_footer() { echo "└──────────────────────────────────────────────────"; }
print_kv() { printf "│ %-20s: %s\n" "$1" "$2"; }

# --- 功能函数 ---

get_system_info() {
    print_header "系统信息"
    print_kv "主机名" "$(cat /proc/sys/kernel/hostname)"
    print_kv "操作系统" "$(grep PRETTY_NAME /etc/os-release | cut -d'=' -f2 | tr -d '"')"
    print_kv "内核版本" "$(cat /proc/sys/kernel/osrelease)"
    local uptime_sec=$(cut -d' ' -f1 < /proc/uptime)
    local uptime_str=$(awk -v T=$uptime_sec 'BEGIN{T=int(T);S=T%60;M=int(T/60)%60;H=int(T/3600)%24;D=int(T/86400);printf("%d 天, %d 小时, %d 分钟, %d 秒",D,H,M,S)}')
    print_kv "运行时间" "$uptime_str"
    print_footer
}

get_cpu_info() {
    print_header "处理器信息"
    local cpu_info=$(cat /proc/cpuinfo)
    print_kv "型号" "$(echo "$cpu_info" | grep 'model name' | uniq | cut -d: -f2- | sed 's/^[ \t]*//')"
    print_kv "物理核心数" "$(echo "$cpu_info" | grep 'cpu cores' | uniq | cut -d: -f2- | sed 's/^[ \t]*//')"
    print_kv "逻辑核心数(线程)" "$(grep -c 'processor' /proc/cpuinfo)"
    print_kv "频率" "$(echo "$cpu_info" | grep 'cpu MHz' | head -n1 | cut -d: -f2- | sed 's/^[ \t]*//') MHz"
    print_kv "缓存" "$(echo "$cpu_info" | grep 'cache size' | uniq | cut -d: -f2- | sed 's/^[ \t]*//')"
    print_footer
}

get_mem_info() {
    print_header "内存信息"
    local mem_info=$(cat /proc/meminfo)
    local mem_total=$(grep 'MemTotal' <<< "$mem_info" | awk '{printf "%.2f GiB", $2/1024/1024}')
    local mem_free=$(grep 'MemFree' <<< "$mem_info" | awk '{printf "%.2f GiB", $2/1024/1024}')
    local mem_available=$(grep 'MemAvailable' <<< "$mem_info" | awk '{printf "%.2f GiB", $2/1024/1024}')
    print_kv "总计" "$mem_total"
    print_kv "剩余" "$mem_free"
    print_kv "可用" "$mem_available"
    echo "│"
    echo "│ Memory Modules: (需要 dmidecode 工具才能获取详细信息)"
    print_footer
}

get_disk_info() {
    print_header "硬盘信息"
    df -hT | grep -E "^/dev/(sd|nvme|vd)" | awk '{printf "│ %-15s %-5s %-5s %-5s %-4s %-s\n", $1, $3, $4, $5, $7, $8}'
    echo "│"
    echo "│ Physical Disks Details:"
    for disk_path in /sys/block/sd* /sys/block/nvme*; do
        if [ -d "$disk_path" ]; then
            local disk_name=$(basename "$disk_path")
            echo "││ ═══ /dev/$disk_name ═══"
            local model=$(cat "$disk_path/device/model" 2>/dev/null || echo "N/A")
            local size_sectors=$(cat "$disk_path/size" 2>/dev/null || echo 0)
            local size_gb=$(awk "BEGIN {printf \"%.2f GB\", $size_sectors*512/1000/1000/1000}")
            print_kv "  型号" "$model"
            print_kv "  大小" "$size_gb"
            echo "│   SMART健康信息: (需要 smartctl 工具才能获取)"
        fi
    done
    print_footer
}

get_net_info() {
    print_header "网卡信息"
    for iface_path in /sys/class/net/e* /sys/class/net/en*; do
        if [ -d "$iface_path" ]; then
            local iface=$(basename "$iface_path")
            echo "│"
            echo "│ ═══ $iface ═══"
            print_kv "状态" "$(cat "$iface_path/operstate" 2>/dev/null | tr '[:lower:]' '[:upper:]')"
            # 使用 `ip` 命令，因为它是核心网络工具集的一部分
            print_kv "IPv4" "$(ip -4 addr show "$iface" | grep "inet" | awk '{print $2}' | tr '\n' ' ')"
            print_kv "IPv6" "$(ip -6 addr show "$iface" | grep "inet6" | awk '{print $2}' | tr '\n' ' ')"
            print_kv "MAC地址" "$(cat "$iface_path/address" 2>/dev/null)"
            print_kv "速度" "$(cat "$iface_path/speed" 2>/dev/null) Mbps"
            local rx_bytes=$(cat "$iface_path/statistics/rx_bytes" 2>/dev/null)
            local tx_bytes=$(cat "$iface_path/statistics/tx_bytes" 2>/dev/null)
            print_kv "RX" "$(awk -v B=$rx_bytes 'BEGIN{iec="BKBMBGBTB"; for(i=5; B>1024 && i>1; i--) B/=1024; printf "%.2f %s", B, substr(iec,i,2)}')"
            print_kv "TX" "$(awk -v B=$tx_bytes 'BEGIN{iec="BKBMBGBTB"; for(i=5; B>1024 && i>1; i--) B/=1024; printf "%.2f %s", B, substr(iec,i,2)}')"
        fi
    done
    print_footer
}


# --- 主程序 ---
clear
echo "$header_line"
printf "%*s\n" $(( (${#header_line} + ${#title_text}) / 2 )) "$title_text"
echo "$header_line"

# 依次调用函数
get_system_info
get_cpu_info
get_mem_info
get_disk_info
get_net_info

echo "报告生成完成！"
echo "Generated on: $(date)"
