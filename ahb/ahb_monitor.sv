//-----------------------------------------
// AHB Monitor class  
//-----------------------------------------
`define MIF this.vif.monitor.monitor_cb


class ahb_monitor extends uvm_monitor;

  virtual ahb_if vif;
 
  uvm_analysis_port #(ahb_seq_item) p_port;
  uvm_analysis_port #(ahb_seq_item) ahb_m_to_scb_port;

  `uvm_component_utils(ahb_monitor);

   function new(string name, uvm_component parent = null);
     super.new(name, parent);
  
   endfunction: new

   virtual function void build_phase(uvm_phase phase);

       if (!uvm_config_db#(virtual ahb_if)::get(this, "", "vif", vif)) 
       begin
         `uvm_fatal("ahb/MON/NOVIF", "No virtual interface specified for this monitor instance");
       end
       p_port = new("p_port",this);
       ahb_m_to_scb_port=new("ahb_m_to_scb_port",this);
   endfunction

  ahb_seq_item tr;
  int i;
  
   virtual task run_phase(uvm_phase phase);
     super.run_phase(phase);
     @(posedge vif.monitor.h_clk);           //sync
      forever begin
     
        tr = ahb_seq_item::type_id::create("tr", this);
    
        tr.h_addr  <= `MIF.h_addr;
        tr.h_burst <=  `MIF.h_burst;
        tr.h_trans <= `MIF.h_trans;
        tr.h_write <= `MIF.h_write;
        
        tr.h_resp <= `MIF.h_resp;
        tr.h_ready_out <=`MIF.h_ready_out;

        tr.h_size <=`MIF.h_size;
        tr.h_prot <=`MIF.h_prot;

        tr.h_sel_0<=`MIF.h_sel_0;
        tr.h_ready <=  `MIF.h_ready;
        tr.h_prot <= `MIF.h_prot;
        
        
        if(`MIF.h_write) begin
          @(posedge vif.monitor.h_clk);
          tr.h_wdata = `MIF.h_wdata;
        end
        else begin
          @(posedge vif.monitor.h_clk);
        tr.h_rdata = `MIF.h_rdata;
        
        $display("HRDATA IN MON::",tr.h_rdata);
        if(tr.h_addr==24 && tr.h_rdata>0)begin                                       //ID>0 single irq check
        p_port.write(tr);
        end
      
// for(i=48;i<=60;i=i+4)begin
//         if(tr.h_addr==i && tr.h_rdata>0)begin                                       //ID>0 multiple irq check
//           p_port.write(tr);
//           end
//         end 

        end
        `uvm_info("Monitor Printing",{": OK!"},UVM_LOW);

        tr.print();
        ahb_m_to_scb_port.write(tr);
        

      end

   endtask: run_phase
  
  
endclass: ahb_monitor

