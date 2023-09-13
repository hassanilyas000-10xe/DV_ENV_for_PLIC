
 `define SOURCES 1
 `define TARGETS 1
// `define PRIORITIES 1
// `define MAX_PENDING_COUNT 0
// `define HAS_THRESHOLD 0
// `define HAS_CONFIG_REG 1


interface ir_if(input bit h_clk);

    
       bit   [`SOURCES   -1:0] src;
       bit   [`TARGETS   -1:0]  irq;    
    
          //driver Clocking block - used for Drivers
       clocking driver_cb @(posedge h_clk);
          output #1 src;
          input  #1 irq;
       endclocking: driver_cb
    
       
    
       //Monitor Clocking block - For sampling by monitor components
       clocking monitor_cb @(posedge h_clk);
          input #1 src,irq;
       endclocking: monitor_cb
    
       modport driver(clocking driver_cb);
      modport monitor(clocking monitor_cb);
      
    
    endinterface: ir_if