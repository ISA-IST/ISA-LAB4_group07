vcom -93 ../src_FPU/common/fpnormalize_fpnormalize.vhd
vcom -93 ../src_FPU/common/fpround_fpround.vhd
vcom -93 ../src_FPU/common/packfp_packfp.vhd
vcom -93 ../src_FPU/common/unpackfp_unpackfp.vhd    
vcom -93 ../src_FPU/multiplier/regnbit.vhd

vcom -93 ../src_FPU/multiplier/dadda_tree.vhd
vcom -93 ../src_FPU/multiplier/FA.vhd
vcom -93 ../src_FPU/multiplier/HA.vhd
vcom -93 ../src_FPU/multiplier/MBE_encoder.vhd
vcom -93 ../src_FPU/multiplier/mux_4to1_nbit.vhd

vcom -93 ../src_FPU/multiplier/fpmul_stage1_struct.vhd
vcom -93 ../src_FPU/multiplier/fpmul_stage2_MBE.vhd
vcom -93 ../src_FPU/multiplier/fpmul_stage3_struct.vhd
vcom -93 ../src_FPU/multiplier/fpmul_stage4_struct.vhd

vcom -93 ../src_FPU/multiplier/fpmul_pipeline.vhd

vlog -sv ../tb_FPU/top_FPU_nodelay.sv
vsim top_FPU
run 10 us
