class packet_in extends uvm_sequence_item;
    rand integer A, min, max;
    rand integer B;

	constraint my_constA { A inside {[100 : 1000]}; }
	constraint my_constB { B < A*10 ;
							B > 1000 ;}

    `uvm_object_utils_begin(packet_in)
        `uvm_field_int(A, UVM_ALL_ON|UVM_HEX)
        `uvm_field_int(B, UVM_ALL_ON|UVM_HEX)
    `uvm_object_utils_end

    function new(string name="packet_in");
        super.new(name);
    endfunction: new
endclass: packet_in
