import uvm_pkg::*;
`include "uvm_macros.svh"
//`include "../src/adder.sv"
`include "../src/dut_if_MBE.sv"
`include "../src/DUT_MBE.sv"
`include "../tb_MBE/packet_in_MBE.sv"
`include "../tb_MBE/packet_out_long.sv"
`include "../tb_MBE/sequence_in.sv"
`include "../tb_MBE/sequencer.sv"
`include "../tb_MBE/driver.sv"
`include "../tb_MBE/driver_out.sv"
`include "../tb_MBE/monitor.sv"
`include "../tb_MBE/monitor_out.sv"
`include "../tb_MBE/agent.sv"
`include "../tb_MBE/agent_out.sv"
`include "../tb_MBE/refmod.sv"
`include "../tb_MBE/comparator.sv"
`include "../tb_MBE/env.sv"
`include "../tb_MBE/simple_test.sv"

//Top
module top_MBE;
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
  
  DUT sum(in, out, state);

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
