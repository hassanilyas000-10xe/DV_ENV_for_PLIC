
`define DIF this.vif.driver.driver_cb


class ahb_driver extends uvm_driver #(ahb_seq_item);
    logic [31:0] store_data_new;
    logic [31:0] store_data_pre;
    virtual ahb_if vif;
    `uvm_component_utils(ahb_driver);
  
    //uvm_analysis_port #(ahb_seq_item) ap;

  function new (string name, uvm_component parent=null);
        super.new(name,parent);
    //ap = new("ap", this);
    endfunction


    function void build_phase (uvm_phase phase);

     super.build_phase(phase);

        if (!uvm_config_db #(virtual ahb_if)::get(this,"", "vif",vif))
          begin
          `uvm_fatal("No VIF", {"Virtual interface must be set             for:",get_full_name(),".vif"});
          end

    endfunction

    virtual task run_phase (uvm_phase phase);
      super.run_phase(phase);
      
      @(`DIF);

        forever begin
          	ahb_seq_item tr;
            tr = ahb_seq_item::type_id::create("tr", this);
            seq_item_port.get_next_item(tr);
            $display("IN AHB DRIVER");
      //    ap.write(tr); //pass to scoreboard

            `DIF.h_sel_0  <= 1;
            `DIF.h_ready  <= 1;
            `DIF.h_prot  <= 1;

            `DIF.h_trans <= tr.h_trans;
            `DIF.h_size  <= tr.h_size;
            `DIF.h_burst <= tr.h_burst;
            
            `DIF.h_write <= tr.h_write;
            `DIF.h_addr <= tr.h_addr;    
    
            @(posedge vif.driver.h_clk); 
            if(tr.h_write) begin
            `DIF.h_wdata <= tr.h_wdata;
            end




          `uvm_info("Driver Printing",{": OK!"},UVM_LOW);
             tr.print();
             
          $display("IN AHB DRIVER DONE");
          //@(`DIF);
          
          seq_item_port.item_done();
           
        end

    endtask

endclass