

class ahb_agent extends uvm_agent;

    ahb_sequencer sqr;
    ahb_driver drv;
    ahb_monitor mon;
  
    virtual ahb_if vif;

    `uvm_component_utils_begin(ahb_agent)
        `uvm_field_object(sqr, UVM_ALL_ON)
        `uvm_field_object(drv, UVM_ALL_ON)
        `uvm_field_object(mon, UVM_ALL_ON)
    `uvm_component_utils_end

    function new (string name, uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        sqr = ahb_sequencer::type_id::create("sqr", this);
        drv = ahb_driver::type_id::create("drv", this);
        mon = ahb_monitor::type_id::create("mon", this);
      
      if (!uvm_config_db#(virtual ahb_if)::get(this, "*", "vif", vif)) 
      begin
        `uvm_fatal("AHB/AGT/NOVIF", "No virtual interface specified for this agent instance")
      end

//        uvm_config_db#(virtual ahb_if)::set( this, "sqr", "vif", vif);
        uvm_config_db#(virtual ahb_if)::set( this, "drv", "vif", vif);
        uvm_config_db#(virtual ahb_if)::set( this, "mon", "vif", vif);

   endfunction: build_phase

   virtual function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(sqr.seq_item_export);
        mon.p_port.connect(sqr.input_flow_f.analysis_export);
        uvm_report_info("ahb_agent::", "connect_phase, Connected driver to sequencer");
   endfunction

    

endclass
