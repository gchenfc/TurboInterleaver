transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/sl362/Documents/GitHub/TurboInterleaver/TurboInterleaver_quartus {C:/Users/sl362/Documents/GitHub/TurboInterleaver/TurboInterleaver_quartus/TurboInterleaver_shiftRegOut.v}
vlog -vlog01compat -work work +incdir+C:/Users/sl362/Documents/GitHub/TurboInterleaver/TurboInterleaver_quartus {C:/Users/sl362/Documents/GitHub/TurboInterleaver/TurboInterleaver_quartus/TurboInterleaver_shiftRegIn.v}
vlog -vlog01compat -work work +incdir+C:/Users/sl362/Documents/GitHub/TurboInterleaver/TurboInterleaver_quartus {C:/Users/sl362/Documents/GitHub/TurboInterleaver/TurboInterleaver_quartus/HardwareTesting.v}
vcom -93 -work work {C:/Users/sl362/Documents/GitHub/TurboInterleaver/TurboInterleaver_quartus/TurboInterleaver_shiftRegOutFlags.vhd}
vcom -93 -work work {C:/Users/sl362/Documents/GitHub/TurboInterleaver/TurboInterleaver_quartus/TurboInterleaver_shiftRegInFlags.vhd}
vcom -93 -work work {C:/Users/sl362/Documents/GitHub/TurboInterleaver/TurboInterleaver_quartus/TurboInterleaver_Interleaver.vhd}
vcom -93 -work work {C:/Users/sl362/Documents/GitHub/TurboInterleaver/TurboInterleaver_quartus/TurboInterleaver.vhd}
vcom -93 -work work {C:/Users/sl362/Documents/GitHub/TurboInterleaver/TurboInterleaver_quartus/delay1.vhd}
vcom -93 -work work {C:/Users/sl362/Documents/GitHub/TurboInterleaver/TurboInterleaver_quartus/bytes_to_bits.vhd}

vlog -vlog01compat -work work +incdir+C:/Users/sl362/Documents/GitHub/TurboInterleaver/TurboInterleaver_quartus {C:/Users/sl362/Documents/GitHub/TurboInterleaver/TurboInterleaver_quartus/HardwareTesting_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  HardwareTesting_tb

add wave *
view structure
view signals
run -all
