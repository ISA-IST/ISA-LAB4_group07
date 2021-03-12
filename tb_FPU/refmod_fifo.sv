class refmod extends uvm_component;
    `uvm_component_utils(refmod)

    packet_in tr_in;
    packet_out tr_out;
    uvm_get_port #(packet_in) in;
    //uvm_put_port #(packet_out) out; // no more needed
    uvm_analysis_port #(packet_out) analysis_port; //new

    function new(string name = "refmod", uvm_component parent);
        super.new(name, parent);
        in = new("in", this);
        //out = new("out", this);
        analysis_port = new("analysis_port", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tr_out = packet_out::type_id::create("tr_out", this);
    endfunction: build_phase

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        forever begin
            in.get(tr_in);
            tr_out.data = tr_in.A * tr_in.B;
            $display("refmod: input A = %d, input B = %d, output OUT = %d",tr_in.A, tr_in.B, tr_out.data);
			      $display("refmod: input A = %b, input B = %b, output OUT = %b",tr_in.A, tr_in.B, tr_out.data);
            //out.put(tr_out); previous method
              analysis_port.write(tr_out); // new
        end
        phase.drop_objection(this);
    endtask: run_phase
endclass: refmod
