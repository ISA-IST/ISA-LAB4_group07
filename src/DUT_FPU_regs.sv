module DUT(dut_if.port_in in_inter, dut_if.port_out out_inter, input logic clk, output enum logic [1:0] {INITIAL,WAIT,SEND} state);
    
    FPmul FPU_under_test(.FP_A(in_inter.A),.FP_B(in_inter.B),.CLK(clk),.FP_Z(out_inter.data));

	shortreal A_tmp,B_tmp,OUT_tmp;
	logic valid_tmp, valid_tmp_1, valid_tmp_2, valid_tmp_3, valid_tmp_4, valid_tmp_5, valid_tmp_6;
	reg [5:0] out;

    always_ff @(posedge in_inter.clk)
    begin
        if(in_inter.rst) begin
            in_inter.ready <= 0;
            //out_inter.data <= 'x;
            //out_inter.valid <= 0;
			valid_tmp <= 0;
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

						// print A and B in decimal, binary and floating form
                        A_tmp = $bitstoshortreal({in_inter.A[31], in_inter.A[30:23], in_inter.A[22:0]});
            			B_tmp = $bitstoshortreal({in_inter.B[31], in_inter.B[30:23], in_inter.B[22:0]});
						/*$display("[%0t] FPU: input A = %d, input B = %d", $time, in_inter.A,in_inter.B);
						$display("[%0t] FPU: input A = %b, input B = %b", $time, in_inter.A,in_inter.B);
			            $display("FPU: input A = %f, input B = %f",A_tmp, B_tmp);*/
		
						//out_inter.valid <= 1;
						valid_tmp <= 1;
						$display("[%0t] START", $time, valid_tmp);
                        state <= SEND;
 						
						// print OUT in decimal, binary and floating form
						/*$display("[%0t] FPU: output OUT = %d", $time, out_inter.data);
                        $display("[%0t] FPU: output OUT = %b", $time, out_inter.data);
            			OUT_tmp = $bitstoshortreal({out_inter.data[31], out_inter.data[30:23], out_inter.data[22:0]});
            			$display("FPU: output OUT = %f", OUT_tmp);*/
                    end
                end
                
                SEND: begin
                    if(out_inter.ready) begin
                        //out_inter.valid <= 0;
						valid_tmp <= 0;
                        in_inter.ready <= 1;
                        state <= WAIT;
                    end
                end
        endcase


    end

	/*always_ff @(posedge in_inter.clk)
    	begin
			valid_tmp_1 <= valid_tmp;
			$display(valid_tmp);
			$display(valid_tmp_1);
	end

	always_ff @(posedge in_inter.clk)
    	begin
			valid_tmp_2 <= valid_tmp_1;
	end

	always_ff @(posedge in_inter.clk)
    	begin
			valid_tmp_3 <= valid_tmp_2;
	end

	always_ff @(posedge in_inter.clk)
    	begin
			valid_tmp_4 <= valid_tmp_3;
	end

 	always_ff @(posedge in_inter.clk)
    	begin
			valid_tmp_5 <= valid_tmp_4;
	end*/

	/*always_ff @(posedge in_inter.clk)
    	begin
			valid_tmp_6 <= valid_tmp_5;
	end*/

	/*always_ff @(posedge in_inter.clk) begin
			out_inter.valid <= valid_tmp_5;
			if(out_inter.valid) begin
				$display("[%0t] FPU: output OUT = %d", $time, out_inter.data);
				$display("[%0t] FPU: output OUT = %b", $time, out_inter.data);
			end
			
	end*/


	always @(posedge in_inter.clk) begin
		if(in_inter.rst) begin
			out <= 0;
		end
		else begin
			out <= {valid_tmp, out[5:1]};
		end
	end
	
	always_comb begin
		out_inter.valid = out[0];
	end

endmodule: DUT
