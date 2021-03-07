vcom -93  ./src_FPU/common/fpnormalize_fpnormalize.vhd
vcom -93  ./src_FPU/common/fpround_fpround.vhd
vcom -93  ./src_FPU/common/packfp_packfp.vhd
vcom -93  ./src_FPU/common/unpackfp_unpackfp.vhd  
vcom -93  ./src_FPU/common/clk_gen.vhd  

vcom -93 ./src_FPU/multiplier/fpmul_stage1_struct.vhd
vcom -93 ./src_FPU/multiplier/fpmul_stage2_struct_modified_extra_regs.vhd
vcom -93 ./src_FPU/multiplier/fpmul_stage3_struct.vhd
vcom -93 ./src_FPU/multiplier/fpmul_stage4_struct.vhd
vcom -93 ./src_FPU/multiplier/regnbit.vhd

vcom -93 ./src_FPU/multiplier/fpmul_pipeline.vhd

vlog -sv ../tb_FPU/top_FPU.sv
vsim top_FPU
run 4 us
