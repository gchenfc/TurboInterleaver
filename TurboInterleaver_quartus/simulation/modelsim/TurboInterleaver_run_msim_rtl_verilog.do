transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/gdc9/Google\ Drive/SharedDocuments/ECE559/TurboInterleaver/TurboInterleaver_quartus {C:/Users/gdc9/Google Drive/SharedDocuments/ECE559/TurboInterleaver/TurboInterleaver_quartus/TurboInterleaver_shiftRegOut.v}
vlog -vlog01compat -work work +incdir+C:/Users/gdc9/Google\ Drive/SharedDocuments/ECE559/TurboInterleaver/TurboInterleaver_quartus {C:/Users/gdc9/Google Drive/SharedDocuments/ECE559/TurboInterleaver/TurboInterleaver_quartus/TurboInterleaver_shiftRegIn.v}
vcom -93 -work work {C:/Users/gdc9/Google Drive/SharedDocuments/ECE559/TurboInterleaver/TurboInterleaver_quartus/bytes_to_bits.vhd}
vcom -93 -work work {C:/Users/gdc9/Google Drive/SharedDocuments/ECE559/TurboInterleaver/TurboInterleaver_quartus/TurboInterleaver.vhd}
vcom -93 -work work {C:/Users/gdc9/Google Drive/SharedDocuments/ECE559/TurboInterleaver/TurboInterleaver_quartus/TurboInterleaver_Interleaver.vhd}
vcom -93 -work work {C:/Users/gdc9/Google Drive/SharedDocuments/ECE559/TurboInterleaver/TurboInterleaver_quartus/TurboInterleaver_shiftRegOutFlags.vhd}
vcom -93 -work work {C:/Users/gdc9/Google Drive/SharedDocuments/ECE559/TurboInterleaver/TurboInterleaver_quartus/TurboInterleaver_shiftRegInFlags.vhd}
vcom -93 -work work {C:/Users/gdc9/Google Drive/SharedDocuments/ECE559/TurboInterleaver/TurboInterleaver_quartus/delay1.vhd}
vcom -93 -work work {C:/Users/gdc9/Google Drive/SharedDocuments/ECE559/TurboInterleaver/TurboInterleaver_quartus/delay3.vhd}

vcom -93 -work work {C:/Users/gdc9/Google Drive/SharedDocuments/ECE559/TurboInterleaver/TurboInterleaver_quartus/TurboInterleaver_tb.vhd}
vcom -93 -work work {C:/Users/gdc9/Google Drive/SharedDocuments/ECE559/TurboInterleaver/TurboInterleaver_quartus/test_input.vhd}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  TurboInterleaver_tb

add wave *
view structure
view signals

radix signal sim:/turbointerleaver_tb/counter_tmp unsigned
radix signal sim:/turbointerleaver_tb/counter_output unsigned
radix signal sim:/turbointerleaver_tb/q_tmp hexadecimal
radix signal sim:/turbointerleaver_tb/q_out hexadecimal
radix signal sim:/turbointerleaver_tb/q_out2 hexadecimal

add wave -position 4 	sim:/turbointerleaver_tb/u1/bit_dataIn

add wave -position end  sim:/turbointerleaver_tb/u1/shiftin_shiftRegInLook
add wave -position end  sim:/turbointerleaver_tb/u1/shiftout_shiftRegInLook
add wave -position end  sim:/turbointerleaver_tb/u1/shiftin_shiftRegOutLook
add wave -position end  sim:/turbointerleaver_tb/u1/shiftout_shiftRegOutLook

add wave -position end  sim:/turbointerleaver_tb/u1/q_shiftRegIn
add wave -position end  sim:/turbointerleaver_tb/u1/dataBufferIn_interleaver
add wave -position end  sim:/turbointerleaver_tb/u1/dataBufferOut_interleaver
add wave -position end  sim:/turbointerleaver_tb/u1/dataBufferOut2_interleaver
radix signal sim:/turbointerleaver_tb/u1/q_shiftRegIn hexadecimal
radix signal sim:/turbointerleaver_tb/u1/dataBufferIn_interleaver hexadecimal
radix signal sim:/turbointerleaver_tb/u1/dataBufferOut_interleaver hexadecimal
radix signal sim:/turbointerleaver_tb/u1/dataBufferOut2_interleaver hexadecimal

run -all
