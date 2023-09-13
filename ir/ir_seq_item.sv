`define SOURCES 1
 `define TARGETS 1

class ir_seq_item extends uvm_sequence_item;
    
    rand bit   [`SOURCES   -1:0] src;
    bit   [`TARGETS   -1:0]  irq; 
    
    `uvm_object_utils_begin (ir_seq_item)
        `uvm_field_int(src,UVM_DEFAULT);
        `uvm_field_int(irq,UVM_DEFAULT);
    
    `uvm_object_utils_end
     
  
    function new (string name = "ir_seq_item");
        super.new(name);
    endfunction   
  
  endclass