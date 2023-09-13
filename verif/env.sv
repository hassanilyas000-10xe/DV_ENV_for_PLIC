class my_env extends uvm_env;
    `uvm_component_utils(my_env)

    ahb_agent ahb_a;
    ir_agent ir_a;

    virtual ir_if ir_vif;
    virtual ahb_if vif;
   
    scoreboard scb;

    virtual_seqr vsr;

    function new (string name, uvm_component parent=null);
        super.new(name, parent);
      endfunction : new

      function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ahb_a = ahb_agent::type_id::create("ahb_a", this);
        ir_a = ir_agent::type_id::create("ir_a", this);
        scb = scoreboard::type_id::create("scb", this);
      
        vsr = virtual_seqr ::type_id ::create("vsr",this);

        if (!uvm_config_db#(virtual ahb_if)::get(this, "*", "vif", vif)) 
      begin
        `uvm_fatal("AGENT", "No virtual interface specified for this agent instance")
      end
      if (!uvm_config_db#(virtual ir_if)::get(this, "*", "ir_vif", ir_vif)) 
      begin
        `uvm_fatal("AGENT", "No virtual interface specified for this agent instance")
      end
    

    uvm_config_db#(virtual ahb_if)::set( this, "ahb_a", "vif", vif);
     uvm_config_db#(virtual ir_if)::set( this, "ir_a", "ir_vif", ir_vif);

      endfunction


    virtual function void connect_phase(uvm_phase phase);
      vsr.ahb_seqr = ahb_a.sqr;
      vsr.ir_seqr = ir_a.sqr;

      ir_a.mon.i_port.connect(vsr.fifo.analysis_export);

      ir_a.mon.i_port.connect(scb.irmon_imp);

      ir_a.drv.d_to_scb_port.connect(scb.irdrv_imp);

      ahb_a.mon.ahb_m_to_scb_port.connect(scb.ahb_imp);


    endfunction : connect_phase


endclass