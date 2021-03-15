vcom -93  ../src_FPU_base/common/fpnormalize_fpnormalize.vhd
vcom -93  ../src_FPU_base/common/fpround_fpround.vhd
vcom -93  ../src_FPU_base/common/packfp_packfp.vhd
vcom -93  ../src_FPU_base/common/unpackfp_unpackfp.vhd   

vcom -93 ../src_FPU_base/multiplier/fpmul_stage1_struct.vhd
vcom -93 ../src_FPU_base/multiplier/fpmul_stage2_struct.vhd
vcom -93 ../src_FPU_base/multiplier/fpmul_stage3_struct.vhd
vcom -93 ../src_FPU_base/multiplier/fpmul_stage4_struct.vhd

vcom -93 ../src_FPU_base/multiplier/fpmul_pipeline.vhd

vlog -sv ../tb_FPU/top_FPU_senzafifo.sv
vsim top_FPU
run 10 us
