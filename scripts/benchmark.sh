#!/usr/bin/env bash
#
# benchmark.sh - design.md 用のリソース測定スクリプト
#
# 使い方:
#   起動から5分以上経過後、通常利用状態（Firefox + ターミナル起動）で実行する
#   ./scripts/benchmark.sh
#
# 出力:
#   CPU使用率とメモリ使用率のサンプル値・平均値、および起動時間
#

set -euo pipefail

SAMPLES=5    # サンプリング回数
INTERVAL=10  # サンプリング間隔（秒）

# CPU使用率を /proc/stat の差分から計算する
# /proc/stat の1行目: cpu user nice system idle iowait irq softirq steal ...
# 1秒空けて2回読み、(1 - idle増分 / 全体増分) を使用率とする
measure_cpu() {
	local -a a b
	local idle_a idle_b total_a total_b v
	read -ra a < /proc/stat
	sleep 1
	read -ra b < /proc/stat
	idle_a=$(( a[4] + a[5] ))  # idle + iowait
	idle_b=$(( b[4] + b[5] ))
	total_a=0
	total_b=0
	for v in "${a[@]:1}"; do total_a=$(( total_a + v )); done
	for v in "${b[@]:1}"; do total_b=$(( total_b + v )); done
	awk -v i=$(( idle_b - idle_a )) -v t=$(( total_b - total_a )) \
		'BEGIN { printf "%.1f", (1 - i / t) * 100 }'
}

# メモリ使用率を free から計算する（used / total）
measure_mem() {
	free | awk '/^Mem:/ { printf "%.1f", $3 / $2 * 100 }'
}

echo "=== Resource benchmark ==="
echo "date: $(date '+%Y-%m-%d %H:%M')"
echo "samples: ${SAMPLES}, interval: ${INTERVAL}s"
echo

cpu_sum=0
mem_sum=0
for i in $(seq 1 "$SAMPLES"); do
	cpu=$(measure_cpu)
	mem=$(measure_mem)
	echo "sample ${i}: CPU ${cpu}%  MEM ${mem}%"
	# bash は整数演算しかできないため、小数の加算は awk で行う
	cpu_sum=$(awk -v s="$cpu_sum" -v c="$cpu" 'BEGIN { print s + c }')
	mem_sum=$(awk -v s="$mem_sum" -v m="$mem" 'BEGIN { print s + m }')
	if [ "$i" -lt "$SAMPLES" ]; then
		sleep "$INTERVAL"
	fi
done

echo "---"
awk -v s="$cpu_sum" -v n="$SAMPLES" 'BEGIN { printf "CPU average: %.1f%%\n", s / n }'
awk -v s="$mem_sum" -v n="$SAMPLES" 'BEGIN { printf "MEM average: %.1f%%\n", s / n }'
echo

echo "=== Boot time ==="
# systemd-analyze: firmware / loader / kernel / userspace の各所要時間を表示
# コンテナ等 systemd が PID 1 でない環境では失敗するため、その場合はスキップ
if systemd-analyze 2>/dev/null; then
	:
else
	echo "systemd-analyze unavailable in this environment (skipped)"
fi
