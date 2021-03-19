class packet_in extends uvm_sequence_item;
    shortreal A;
	rand bit sign_A;
	rand bit[7:0] exp_A;
	rand bit[22:0] mant_A;
	shortreal B;
	rand bit sign_B;
	rand bit[7:0] exp_B;
	rand bit[22:0] mant_B;
	

    `uvm_object_utils_begin(packet_in)
        `uvm_field_int(A, UVM_ALL_ON|UVM_HEX)
        `uvm_field_int(B, UVM_ALL_ON|UVM_HEX)
    `uvm_object_utils_end

    function new(string name="packet_in");
        super.new(name);
		A = $bitstoshortreal(sign_A, exp_A, mant_A);
		B = $bitstoshortreal(sign_B, exp_B, mant_B);
    endfunction: new
endclass: packet_in
