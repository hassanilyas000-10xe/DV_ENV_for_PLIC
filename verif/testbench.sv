import uvm_pkg::*;
`include "uvm_macros.svh"

// `define SOURCES 1
// `define TARGETS 1
// `define PRIORITIES 1
// `define MAX_PENDING_COUNT 0
// `define HAS_THRESHOLD 0
// `define HAS_CONFIG_REG 1

//`include "define.sv"

//`include "ahb_interface.sv"
`include "ahb_seq_item.sv"
`include "ahb_sequencer.sv"
`include "ahb_sequence.sv"
`include "ahb_driver.sv"
`include "ahb_monitor.sv"
`include "ahb_agent.sv"


//`include "ir_interface.sv"
`include "ir_seq_item.sv"
`include "ir_sequencer.sv"
`include "ir_sequence.sv"
`include "ir_driver.sv"
`include "ir_monitor.sv"
`include "ir_agent.sv"

`include "virtual_seqr.sv"
`include "virtual_seq.sv"

//`include "register_config.sv"
`include "scoreboard.sv"
`include "env.sv"

`include "test.sv"

parameter SOURCES=1;
parameter TARGETS=1;
parameter PRIORITIES=8;
parameter MAX_PENDING_COUNT=8;
parameter HAS_THRESHOLD=1;
parameter HAS_CONFIG_REG=1;

module testbench;
// Global siganl
   logic h_clk;
   logic h_rst;
 

   initial begin
      h_clk=0;
   end
  
 

    //Generate a clock
   always begin
      #10 h_clk = ~h_clk;
   end

   initial begin
    h_rst = 0;
    #10;
    h_rst = 1;
  
  end
 
   //Instantiate a physical interface for APB interface
  ahb_if  ahb_if(.h_clk(h_clk));
  ir_if ir_if(.h_clk(h_clk));
  
  
ahb3lite_plic_top #(
      //AHB Parameters
      .HADDR_SIZE (  32  ),
      .HDATA_SIZE (  32 ),
    
        //PLIC Parameters
        .SOURCES               (     SOURCES             ),//35,  //Number of interrupt sources
        .TARGETS               (     TARGETS            ),   //Number of interrupt targets
        .PRIORITIES            (     PRIORITIES          ),   //Number of Priority levels
        .MAX_PENDING_COUNT     (     MAX_PENDING_COUNT   ),   //Max. number of 'pending' events
        .HAS_THRESHOLD         (     HAS_THRESHOLD    ),   //Is 'threshold' implemented?
        .HAS_CONFIG_REG        (     HAS_CONFIG_REG     )   //Is the 'configuration' register implemented?
    )
    pl_top
    (
            .HRESETn(h_rst),
            .HCLK(h_clk),
        
        //AHB Slave Interface
            .HSEL(ahb_if.h_sel_0),
            .HADDR(ahb_if.h_addr),
            .HWDATA(ahb_if.h_wdata),
            .HRDATA(ahb_if.h_rdata),
            .HWRITE(ahb_if.h_write),
            .HSIZE(ahb_if.h_size),
            .HBURST(ahb_if.h_burst),
            .HPROT(ahb_if.h_prot),                  //not decl
            .HTRANS(ahb_if.h_trans),
            .HREADYOUT(ahb_if.h_ready_out),
            .HREADY(ahb_if.h_ready),
            .HRESP(ahb_if.h_resp),
        
            .src(ir_if.src),       //Interrupt sources
            .irq(ir_if.irq)        //Interrupt Requests
    );
    
    initial begin
      $dumpfile("dump.vcd");
    $dumpvars;
    end



  initial begin
    //Pass this physical interface to test top (which will further pass it down to env->agent->drv/sqr/mon
    uvm_config_db#(virtual ahb_if)::set( null, "*", "vif", ahb_if);
    uvm_config_db#(virtual ir_if)::set( null, "*", "ir_vif", ir_if);

    //run_test("ahb_model_base_test");
    run_test();
  end
  
  
endmodule