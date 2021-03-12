import uvm_pkg::*;
`include "uvm_macros.svh"
//`include "../src/adder.sv"
`include "../src/dut_if_FPU.sv"
`include "../src/DUT_FPU.sv"
`include "../tb_FPU/packet_in.sv"
`include "../tb_FPU/packet_out.sv"
`include "../tb_FPU/sequence_in.sv"
`include "../tb_FPU/sequencer.sv"
`include "../tb_FPU/driver.sv"
`include "../tb_FPU/driver_out.sv"
`include "../tb_FPU/monitor.sv"
`include "../tb_FPU/monitor_out.sv"
`include "../tb_FPU/agent.sv"
`include "../tb_FPU/agent_out.sv"
`include "../tb_FPU/refmod_shortreal_fifo2.sv"
`include "../tb_FPU/comparator_fifo2.sv"
`include "../tb_FPU/env_fifo2.sv"
//`include "../tb_FPU/refmod.sv"
//`include "../tb_FPU/comparator_fifo_internal.sv"
//`include "../tb_FPU/env.sv"
`include "../tb_FPU/simple_test.sv"

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
