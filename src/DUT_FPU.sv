module DUT(dut_if.port_in in_inter, dut_if.port_out out_inter, input logic clk, output enum logic [1:0] {INITIAL,WAIT,SEND} state);
    
    FPmul FPU_under_test(.FP_A(in_inter.A),.FP_B(in_inter.B),.CLK(clk),.FP_Z(out_inter.data));

    always_ff @(posedge in_inter.clk)
    begin
        if(in_inter.rst) begin
            in_inter.ready <= 0;
            out_inter.data <= 'x;
            out_inter.valid <= 0;
            state <= INITIAL;
        end
        else case(state)
                INITIAL: begin
                    in_inter.ready <= 1;
                    state <= WAIT;
                end
                
                WAIT: begin
                    if(in_inter.valid) begin
                        in_inter.ready <= 0;
                        //out_inter.data <= in_inter.A + in_inter.B;
                        $display("[%0t] FPU: input A = %d, input B = %d", $time, in_inter.A,in_inter.B);
						$display("[%0t] FPU: input A = %b, input B = %b", $time, in_inter.A,in_inter.B);
                        #45 
						out_inter.valid <= 1;
                        state <= SEND;
 						//$display("[%0t] FPU: input A = %d, input B = %d, output OUT = %d", $time, in_inter.A,in_inter.B,out_inter.data);
                        //$display("[%0t] FPU: input A = %b, input B = %b, output OUT = %b",$time, in_inter.A,in_inter.B,out_inter.data);
						$display("[%0t] FPU: output OUT = %d", $time, out_inter.data);
                        $display("[%0t] FPU: output OUT = %b", $time, out_inter.data);
                    end
                end
                
                SEND: begin
                    if(out_inter.ready) begin
                        out_inter.valid <= 0;
                        in_inter.ready <= 1;
                        state <= WAIT;
                    end
                end
        endcase
    end
endmodule: DUT
