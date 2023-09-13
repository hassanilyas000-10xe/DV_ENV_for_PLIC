class virtual_seqr extends uvm_sequencer;

    ahb_sequencer                   ahb_seqr;
    ir_sequencer                   ir_seqr;
                                              
    uvm_tlm_analysis_fifo #(ir_seq_item) fifo;
   // uvm_analysis_export #(ir_seq_item) exporte;
    `uvm_component_utils(virtual_seqr)
   function new(string name ,uvm_component parent);
        super.new(name,parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        fifo = new("fifo", this);
    endfunction
    
endclass