interface ahb_if(input bit h_clk);

    //Master signal
       //wire h_reset_n;
       wire [31:0] h_addr;
       wire [2:0]  h_burst;
    //  wire        hmastlock;
       wire [3:0]  h_prot;
       wire [2:0]  h_size;
       wire [1:0]  h_trans;
       wire [31:0] h_wdata;
       wire        h_write;
    //slave signal
       wire [31:0] h_rdata;
       wire        h_ready_out;
       wire        h_resp;
    
       wire        h_ready;
       wire	       h_sel_0;
       wire        apb_slverr;
      // $monitor("debug DIF :: %h",h_wdata);
    
          //Master Clocking block - used for Drivers
       clocking driver_cb @(posedge h_clk);
          output #2 h_addr, h_burst,h_size,h_trans,h_wdata,h_write,h_ready,h_sel_0,apb_slverr,h_prot;
        
          input  #3 h_rdata,h_ready_out,h_resp;
       endclocking: driver_cb
    
       
      
    
       //Monitor Clocking block - For sampling by monitor components
       clocking monitor_cb @(posedge h_clk);
          input #3 h_addr, h_burst,h_size,h_trans,h_wdata,h_write,h_rdata,h_ready_out,h_resp,h_ready,h_sel_0,apb_slverr,h_prot;
       endclocking: monitor_cb
    
    
      modport monitor(clocking monitor_cb,input h_clk);
      modport driver(clocking driver_cb,input h_clk);
    
    endinterface: ahb_if