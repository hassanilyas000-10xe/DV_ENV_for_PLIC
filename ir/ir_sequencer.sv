class ir_sequencer extends uvm_sequencer #(ir_seq_item);

    `uvm_component_utils(ir_sequencer);
    
  function new (string name , uvm_component parent=null);
        super.new(name,parent);
    endfunction

    

endclass