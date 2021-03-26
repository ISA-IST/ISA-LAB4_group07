class comparator #(type T = packet_out) extends uvm_scoreboard;
  typedef comparator #(T) this_type;
  `uvm_component_param_utils(this_type)

  const static string type_name = "comparator #(T)";

   uvm_analysis_export  #( T ) expected_analysis_export;
   uvm_analysis_export  #( T )   actual_analysis_export;
   uvm_tlm_analysis_fifo#( T ) expected_refmod_fifo;
   uvm_tlm_analysis_fifo#( T )   actual_DUT_fifo;

  typedef uvm_built_in_converter #( T ) convert;

  int m_matches, m_mismatches;
  T exp;
  bit free;
  event compared, end_of_simulation;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    expected_analysis_export = new( "expected_analysis_export", this );
    actual_analysis_export = new( "actual_analysis_export", this );
    expected_refmod_fifo = new( "expected_refmod_fifo", this );
    actual_DUT_fifo = new(   "actual_DUT_fifo", this );
    m_matches = 0;
    m_mismatches = 0;
    exp = new("exp");
    free = 1;
  endfunction

  virtual function void connect_phase( uvm_phase phase );
	super.connect_phase( phase );
	// connect ports receiving data to FIFOs in charge of storing it
	expected_analysis_export.connect( expected_refmod_fifo.analysis_export );
    actual_analysis_export.connect(   actual_DUT_fifo.analysis_export );
  endfunction: connect_phase


  virtual function string get_type_name();
    return type_name;
  endfunction

  task run_phase(uvm_phase phase);
	
    packet_out before_tx;
    packet_out after_tx;

    super.run_phase(phase);

	phase.raise_objection(this);
    forever begin
				
		// get item from refmod FIFO
		expected_refmod_fifo.get_peek_export.get(before_tx);		
		
		phase.raise_objection(this);
		
		// get item from DUT FIFO
		actual_DUT_fifo.get_peek_export.get(after_tx);

		
		// print data to be compared
		$display("COMPARE BETWEEN:");
		$display("RES_ref = %b", before_tx.data);
		$display("RES_dut = %b", after_tx.data);
			
			
		// comparison
		if( !after_tx.compare(before_tx) ) begin
		   uvm_report_warning("Comparator Mismatch", "");
		   m_mismatches++;
		end
		else begin
		   uvm_report_info("Comparator Match", "");
		   m_matches++;
		end

		phase.drop_objection(this);

		// loop exit condition
		if(m_matches+m_mismatches > 100) begin
			break;
		end
	end
	
    phase.drop_objection(this);
    
  endtask


endclass
