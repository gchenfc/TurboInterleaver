transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/gdc9/Google Drive/SharedDocuments/ECE559/TurboInterleaver/TurboInterleaver_quartus/TurboInterleaver_Interleaver.vhd}

vcom -93 -work work {C:/Users/gdc9/Google Drive/SharedDocuments/ECE559/TurboInterleaver/TurboInterleaver_quartus/TurboInterleaver_Interleaver_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneive -L rtl_work -L work -voptargs="+acc"  TurboInterleaver_Interleaver_tb

add wave *
view structure
view signals
run -all
