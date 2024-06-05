#!/system/bin/sh

#___________________________
# Copyright © REXX FLOSS™
# Mvast Thermods 
# Zyarexx x Visk44
#___________________________

g() { local l="$1"; shift; echo "$@" > "$l"; }
h() { chmod "$@"; }
j='0'; k='1'; m='0000'; n='000'; o='/sys/kernel/eara_thermal'; p='/sys/devices/virtual/thermal/thermal*'; q='/sys/power/cpufreq_'
r='/proc/mtk-perf/mt_throttle_ms'; s='/proc/perfmgr/boost_ctrl/eas_ctrl'; t='/sys/module'; u='/sys/kernel/tracing'; v='/proc/driver/thermal*'; w='/proc/irq/305/mtk-thermal*'; x='/proc/ppm/policy/thermal_'
y='/sys/module/msm_thermal/core_control'; z='/proc/cpufreq/cpufreq_imax_thermal_protect'; A='/sys/class/thermal'; B='/sys/class/thermal/tz-by-name'; C='/policy'; D='step_wise'

rexx () {
h 0755 $o $o/enable
h $m $p
h $n $q{min,max}_limit
h $m $p/* $p/*/* $v $v/* $v/*/* $w $w/* $w/*/* $x{limit,cur_power}
g $o/enable $j; g $o/fake_throttle $k; g $r $j
for i in debug_schedplus_{up,down}_throttle perfserv_schedplus_{up,down}_throttle; do g $s/$i $j; done
g $t/dm_snapshot/parameters/snapshot_copy_throttle $j
g $u/events/power/powernv_throttle/enable $j
g $u/instances/{wifi,bootreceiver}/events/power/powernv_throttle/enable $j
g $y/{cpus_offlined,enabled} $j; g $z $j

therm_pol_set() {
[[ -d "$therm" ]] && for i in xo skin camera-{f,flash} rf-pa{0,1} modem{0,1}-pa{0,1,2} modem1-{qfe-wtr,modem,mmw{0,1,2,3},skin,pa-{mdm,wtr}} aoss0 cpu-{0,1}-{0,1,2,3} gpu cpuss-{0,1,2} lmh-dcvs-{00,01} quiet sdm charger-skin conn; do
g "$B/$i-therm-adc$C" $D
done
}

[[ "$1" == "$k" ]] && h 644 "$A/thermal_message/board_sensor_temp"
pm enable com.xiaomi.gamecenter.sdk.service/.PidService >/dev/null 2>&1 &
g "$A/thermal_message/board_sensor_temp" "36000"
h $n "$A/thermal_message/board_sensor_temp"
pm clear com.xiaomi.gamecenter.sdk.service
pm disable com.xiaomi.gamecenter.sdk.service/.PidService >/dev/null 2>&1 &

sleep 30
su -lp 2000 -c "cmd notification post -S bigtext -t 'Mvast Thermods' 'Tag' 'Mvast Thermods Installed Successfully'"
}
rexx > /dev/null 2>&1
