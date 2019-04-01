transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {TurboInterleaver_min_1200mv_0c_fast.vo}

vcom -93 -work work {C:/Users/gdc9/Google Drive/SharedDocuments/ECE559/TurboInterleaver/TurboInterleaver_quartus/TurboInterleaver_tb.vhd}
vcom -93 -work work {C:/Users/gdc9/Google Drive/SharedDocuments/ECE559/TurboInterleaver/TurboInterleaver_quartus/test_input.vhd}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  TurboInterleaver_tb

add wave *
view structure
view signals
run -all
