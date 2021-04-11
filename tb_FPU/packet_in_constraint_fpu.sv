class packet_in extends uvm_sequence_item;
    rand integer A;
    rand integer B;

constraint my_constA { 
						//A > 469762048; // originale
						A == 469762048; // 4.2e-22
						//A > 0 ; 
						
						//A > -1677721600;
						//A < 0; 
						 }
constraint my_constB {
						//B > 469762048;
						B < 636756992; //4.2e-16
						B > 524812288; //4.2e-20
						//B > -1677721600; 
						//B < 0; 
						 }
 

   `uvm_object_utils_begin(packet_in)
        `uvm_field_int(A, UVM_ALL_ON|UVM_HEX)
        `uvm_field_int(B, UVM_ALL_ON|UVM_HEX)
    `uvm_object_utils_end


    function new(string name="packet_in");
        super.new(name);
    endfunction: new
endclass: packet_in
