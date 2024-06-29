#!/system/bin/sh

#___________________________
# Copyright © REXX FLOSS™
# Mvast Thermods 
# Zyarexx x Visk44
#___________________________

Z1='chmod'
Z2='find'
Z3='grep'
Z4='ps -eo args'
Z5='resetprop'
Z6='setprop'
Z7='stop'
Z8='write'
Z9='/sys/devices/virtual/thermal/thermal_zone*/'
ZA='mode'
ZB='type'
ZC='echo'
ZD='date'
ZE='/storage/emulated/0/MvastThermods.log'

touch /storage/emulated/0/MvastThermods.log

f1() { $Z1 644 $($Z2 $Z9 -name $ZB); }
f2() { for s in $($Z4 | $Z3 thermal | sed '/grep thermal/d'); do $Z7 $s; $Z5 ctl.$Z7 $s; $Z6 ctl.$Z7 $s; done; }
f3() { for m in $Z9$ZA; do $Z8 $m "disabled"; done; }
f4() { $ZC "0" > /sys/class/kgsl/kgsl-3d0/throttling; $ZC "performance" > /sys/class/devfreq/mmc0/governor; $ZC "performance" > /sys/class/devfreq/mmc1/governor; }
f5() { $ZC "N" > /sys/module/msm_thermal/parameters/enabled; $ZC "0" > /sys/module/msm_thermal/core_control/enabled; $ZC "0" > /sys/module/msm_thermal/vdd_restriction/enabled; }
f6() { for t in $($Z2 $Z9 -name $ZB); do $Z1 -R 000 $t; done; }
f7() { $ZC "Thermal patched, executed on $($ZD)" >> $ZE; }

f1; f2; f3; f4; f5; f6; f7;
