

class ahb_seq_item extends uvm_sequence_item;

    rand bit [31:0] h_addr;     // address 
    rand bit [31:0] h_wdata;    // write data
         bit [31:0] h_rdata;    // read data   //out
    rand bit h_write;           // write/read
    rand bit [2:0]  h_size;     // size (8, 16, 32, 64, 128, 256, 512, 1024) 32-bits fixed atm 
    rand bit [2:0]  h_burst;    // burst type (SINGLE, INC, WRAP_4, INC_4, WRAP_8, INC_8, WRAP_16, INC_16)
    rand bit [1:0]  h_trans;    // transfer type (IDLE, BUSY, NON-SEQ, SEQ)
         bit        h_resp; //out
         bit        h_ready_out;//out

    rand bit h_reset_n;

    rand bit [3:0] h_prot;
    bit        h_sel_0;
    bit        h_ready;
    
    `uvm_object_utils_begin (ahb_seq_item)
        `uvm_field_int(h_addr,UVM_DEFAULT);
        `uvm_field_int(h_wdata,UVM_DEFAULT);
        `uvm_field_int(h_write,UVM_DEFAULT);
        `uvm_field_int(h_rdata,UVM_DEFAULT);
        `uvm_field_int(h_size,UVM_DEFAULT);
        `uvm_field_int(h_burst,UVM_DEFAULT);
         `uvm_field_int(h_trans,UVM_DEFAULT);
    `uvm_field_int(h_prot,UVM_DEFAULT);
        `uvm_field_int(h_reset_n,UVM_DEFAULT);
    `uvm_field_int(h_sel_0,UVM_DEFAULT);
    `uvm_field_int(h_ready,UVM_DEFAULT);
    `uvm_object_utils_end
  
    //constraint h_burst_const {h_burst == 0 || h_burst == 1 || h_burst == 2 || h_burst == 3};
    //constraint burst_trans_1 {};
    constraint h_addr_c {
      h_addr%4==0 && h_addr<256;
    }
     
  
    function new (string name = "ahb_seq_item");
        super.new(name);
    endfunction   
  
  endclass