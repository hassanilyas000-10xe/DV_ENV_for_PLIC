
class ir_agent extends uvm_agent;

    ir_sequencer sqr;
    ir_driver drv;
    ir_monitor mon;
  
    virtual ir_if ir_vif;

    `uvm_component_utils_begin(ir_agent)
        `uvm_field_object(sqr, UVM_ALL_ON)
        `uvm_field_object(drv, UVM_ALL_ON)
        `uvm_field_object(mon, UVM_ALL_ON)
    `uvm_component_utils_end

    function new (string name, uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        sqr = ir_sequencer::type_id::create("sqr", this);
        drv = ir_driver::type_id::create("drv", this);
        mon = ir_monitor::type_id::create("mon", this);
      
      if (!uvm_config_db#(virtual ir_if)::get(this, "", "ir_vif", ir_vif)) 
      begin
        `uvm_fatal("ir/AGT/NOir_vif", "No virtual interface specified for this agent instance")
      end

        uvm_config_db#(virtual ir_if)::set( this, "drv", "ir_vif", ir_vif);
        uvm_config_db#(virtual ir_if)::set( this, "mon", "ir_vif", ir_vif);

   endfunction: build_phase

   virtual function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(sqr.seq_item_export);
        uvm_report_info("ir_agent::", "connect_phase, Connected driver to sequencer");
   endfunction

    

endclass
