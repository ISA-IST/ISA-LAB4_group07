class refmod extends uvm_component;
    `uvm_component_utils(refmod)

    packet_in tr_in;
    packet_out tr_out;
    uvm_get_port #(packet_in) in;
    uvm_put_port #(packet_out) out;
    shortreal A_tmp,B_tmp,OUT_tmp;

    function new(string name = "refmod", uvm_component parent);
        super.new(name, parent);
        in = new("in", this);
        out = new("out", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tr_out = packet_out::type_id::create("tr_out", this);
    endfunction: build_phase

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);

        forever begin
            in.get(tr_in);
            A_tmp = $bitstoshortreal(tr_in.A[31], tr_in.A[30:23], tr_in.A[22:0]);
            B_tmp = $bitstoshortreal(tr_in.B[31], tr_in.B[30:23], tr_in.B[22:0]);
            OUT_tmp = A_tmp * B_tmp;
            // tr_out.data[31:0] $shortrealtobits(OUT_tmp) ;
            {tr_out.data[31],tr_out.data[30:23],tr_out.data[22:0]} = $shortrealtobits(OUT_tmp);
            $display("refmod: input A = %d, input B = %d, output OUT = %d",tr_in.A, tr_in.B, tr_out.data);
			$display("refmod: input A = %b, input B = %b, output OUT = %b",tr_in.A, tr_in.B, tr_out.data);
            out.put(tr_out);
        end
    endtask: run_phase
endclass: refmod
