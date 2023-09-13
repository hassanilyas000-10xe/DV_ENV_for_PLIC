class ahb_sequencer extends uvm_sequencer #(ahb_seq_item);

    `uvm_component_utils(ahb_sequencer);
    
  function new (string name , uvm_component parent=null);
        super.new(name,parent);
    endfunction

    uvm_tlm_analysis_fifo #(ahb_seq_item) input_flow_f;
    

    function void build_phase(uvm_phase phase);
        input_flow_f = new("input_flow_f", this);
    endfunction


    

endclass