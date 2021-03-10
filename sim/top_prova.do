vcom -93 ../src_MBE/dadda_tree.vhd
vcom -93 ../src_MBE/FA.vhd
vcom -93 ../src_MBE/HA.vhd
vcom -93 ../src_MBE/MBE_encoder.vhd
vcom -93 ../src_MBE/mux_4to1_nbit.vhd

vcom -93 ../src_MBE/MBE_mult.vhd

vlog -sv ../tb/top_FPU.sv
vsim top_FPU
run 4 us
