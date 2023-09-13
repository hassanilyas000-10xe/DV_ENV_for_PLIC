`define MIF this.ir_vif.monitor.monitor_cb


class ir_monitor extends uvm_monitor;

  `uvm_component_utils(ir_monitor);
  virtual ir_if ir_vif;

  uvm_analysis_port #(ir_seq_item) i_port;
  
   function new(string name, uvm_component parent = null);
     super.new(name, parent);
   endfunction: new

   virtual function void build_phase(uvm_phase phase);

       if (!uvm_config_db#(virtual ir_if)::get(this, "", "ir_vif", ir_vif)) 
       begin
         `uvm_fatal("ir/MON/NOVIF", {"No virtual interface specified for this monitor instance",get_full_name(),".vif"});
       end
       i_port = new("i_port",this);
      
   endfunction

  ir_seq_item tr;
  
   virtual task run_phase(uvm_phase phase);
     super.run_phase(phase);
  
     repeat(1) begin @(`MIF); end
     
     forever begin
      @(`MIF);
       tr = ir_seq_item::type_id::create("tr", this);
       tr.src = `MIF.src;
       tr.irq = `MIF.irq;
      
       if(tr.irq>=1) begin
       i_port.write(tr);
       $display("IR fifo written");
       end
       $display("IR MON finished");
       tr.print();
      end
   endtask: run_phase
  
  
endclass