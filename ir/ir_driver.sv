
`define DIF this.ir_vif.driver.driver_cb

class ir_driver extends uvm_driver #(ir_seq_item);
    
    virtual ir_if ir_vif;
    `uvm_component_utils(ir_driver);
    uvm_analysis_port #(ir_seq_item) d_to_scb_port;

  function new (string name, uvm_component parent=null);
        super.new(name,parent);
    endfunction


    function void build_phase (uvm_phase phase);

     super.build_phase(phase);

        if (!uvm_config_db #(virtual ir_if)::get(this,"", "ir_vif",ir_vif))
          begin
          `uvm_fatal("No VIF", {"Virtual interface must be set for:",get_full_name(),".vif"});
          end
          d_to_scb_port=new("d_to_scb_port",this);

    endfunction

    virtual task run_phase (uvm_phase phase);
      super.run_phase(phase);
      
        `DIF.src <= 0;
      
      repeat(3) begin @(`DIF); end
      
        forever begin
          	ir_seq_item tr;
            
            seq_item_port.get_next_item(tr);
   
          `DIF.src  <= tr.src;
            $display("IR DRV finished");
            tr.print();
            d_to_scb_port.write(tr);
            seq_item_port.item_done();
           
        end

    endtask

 
endclass