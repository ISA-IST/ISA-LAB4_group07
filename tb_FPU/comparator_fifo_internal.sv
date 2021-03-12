class comparator #(type T = packet_out) extends uvm_scoreboard; // creazione di una classe parametrizzata
  typedef comparator #(T) this_type; //creazione di un alias con parametro T
  `uvm_component_param_utils(this_type)

  const static string type_name = "comparator #(T)";

  uvm_put_imp #(T, this_type) from_refmod;
  uvm_analysis_imp #(T, this_type) from_dut;

  uvm_tlm_analysis_fifo #(packet_out) before_fifo;
  uvm_tlm_analysis_fifo #(packet_out) after_fifo;

  //alternativa
  //  uvm_tlm_analysis_fifo #(packet_out) before_fifo;
  //  uvm_tlm_analysis_fifo #(packet_out) after_fifo;

  typedef uvm_built_in_converter #( T ) convert;

  int m_matches, m_mismatches;
  T exp;
  bit free;
  event compared, end_of_simulation;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    from_refmod = new("from_refmod", this);
    from_dut = new("from_dut", this);
    before_fifo = new("before_fifo", this);
    after_fifo = new("after_fifo", this);
    m_matches = 0;
    m_mismatches = 0;
    exp = new("exp");
    free = 1;
  endfunction

  virtual function string get_type_name();
    return type_name;
  endfunction

//  task run_phase(uvm_phase phase);  // original run_phase
//    phase.raise_objection(this);
//    @(end_of_simulation);
//    phase.drop_objection(this);
//  endtask

task run_phase(uvm_phase phase);     // new run_phase
 packet_out before_tx;
 packet_out after_tx;

 forever begin
$display("before");
 before_fifo.get(before_tx);
//‘uvm_info("before_fifo", $sformatf("RES=%0h", before_tx.data), UVM_MEDIUM);
$display("before_fifo");
 phase.raise_objection(this);

$display("obj");//questo non viene stampato

 after_fifo.get(after_tx);
//‘uvm_info("after_fifo", $sformatf("RES=%0h", after_tx.data), UVM_MEDIUM);

$display("after fifo");

if( !after_tx.compare(before_tx) ) begin
 uvm_report_warning("Comparator Mismatch", "");
 m_mismatches++;
 end
 else begin
 uvm_report_info("Comparator Match", "");
 m_matches++;
 end

if(m_matches+m_mismatches > 100) begin
		$display("end");
      -> end_of_simulation;
end

    -> compared;

 phase.drop_objection(this);

 end // forever begin

endtask


 virtual task put(T t);
    if(!free) @compared; // '@' triggera l'azione quando compared cambia, credo come '@' posedge.
    before_fifo.try_put(t);
    free = 0;

    @compared;
    free = 1;
  endtask

  virtual function bit try_put(T t);
    if(free) begin
      before_fifo.try_put(t);
      free = 0;
      return 1;
    end
    else return 0;
  endfunction

  virtual function bit can_put();
    return free;
  endfunction

  virtual function void write(T rec);
    /*if (free)
      uvm_report_fatal("No expect transaction to compare with", "");

    if(!(exp.compare(rec))) begin
      uvm_report_warning("Comparator Mismatch", "");
      m_mismatches++;
    end
    else begin
      uvm_report_info("Comparator Match", "");
      m_matches++;
    end

    if(m_matches+m_mismatches > 100)
      -> end_of_simulation;

    -> compared;*/

	after_fifo.try_put(rec);
  endfunction
endclass
