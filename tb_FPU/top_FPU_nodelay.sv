import uvm_pkg::*;
`include "uvm_macros.svh"
`include "../src/dut_if_FPU.sv"
`include "../src/DUT_FPU_nodelay.sv"
`include "../tb_FPU_attempts/packet_in.sv"
`include "../tb_FPU_attempts/packet_out.sv"
`include "../tb_FPU_attempts/sequence_in.sv"
`include "../tb_FPU_attempts/sequencer.sv"
`include "../tb_FPU_attempts/driver.sv"
`include "../tb_FPU_attempts/driver_out.sv"
`include "../tb_FPU_attempts/monitor.sv"
`include "../tb_FPU_attempts/monitor_out_nodelay.sv"
`include "../tb_FPU_attempts/agent.sv"
`include "../tb_FPU_attempts/agent_out.sv"
`include "../tb_FPU_attempts/refmod_shortreal_FPU.sv"
`include "../tb_FPU_attempts/comparator_FPU.sv"
`include "../tb_FPU_attempts/env_FPU.sv"
`include "../tb_FPU_attempts/simple_test.sv"

//Top
module top_FPU;
  logic clk;
  logic rst;
  
  initial begin
    clk = 0;
    rst = 1;
    #22 rst = 0;
    
  end
  
  always #5 clk = !clk;
  
  logic [1:0] state;
  
  dut_if in(clk, rst);
  dut_if out(clk, rst);
  
  DUT sum(in, out, clk, state);

  initial begin
    `ifdef INCA
      $recordvars();
    `endif
    `ifdef VCS
      $vcdpluson;
    `endif
    `ifdef QUESTA
      $wlfdumpvars();
      set_config_int("*", "recording_detail", 1);
    `endif
    
    uvm_config_db#(input_vif)::set(uvm_root::get(), "*.env_h.mst.*", "vif", in);
    uvm_config_db#(output_vif)::set(uvm_root::get(), "*.env_h.slv.*",  "vif", out);
    
    run_test("simple_test");
  end
endmodule