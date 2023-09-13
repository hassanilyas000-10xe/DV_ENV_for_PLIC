
`uvm_analysis_imp_decl(_ahb)
`uvm_analysis_imp_decl(_irdrv)
`uvm_analysis_imp_decl(_irmon)



class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard)
	
      uvm_analysis_imp_ahb#(  ahb_seq_item ,scoreboard) ahb_imp;
	uvm_analysis_imp_irdrv#( ir_seq_item  ,scoreboard) irdrv_imp;
	uvm_analysis_imp_irmon#( ir_seq_item  ,scoreboard) irmon_imp;
	
	
	
   
function new(string name,uvm_component parent);
super.new(name,parent);
irdrv_imp=new("irdrv_imp",this);
irmon_imp=new("irmon_imp",this);
ahb_imp=new("ahb_imp",this);
endfunction

    bit [`SOURCES      -1:0] el;
    bit [PRIORITY_BITS-1:0] p  [`SOURCES];
    bit [`SOURCES      -1:0] ie [`TARGETS];
    bit [PRIORITY_BITS-1:0] th [`TARGETS];

    bit [TARGETS      -1:0] claim, complete;
	
    int     received_ahb, received_irdrv, received_irmon;




    localparam PRIORITY_BITS    = $clog2(`PRIORITIES);
    localparam CONFIG_REGS    = 2;
    //How many Edge/Level registers are there?
    localparam EL_REGS        = (`SOURCES + `DATA_SIZE -1) / `DATA_SIZE;
  
    //How many IE registers are there?
    localparam IE_REGS        = EL_REGS * `TARGETS;
  
    //How many nibbles are there in 'PRIORITY_BITS' ?
    //Each PRIORITY starts at a new nibble boundary
    localparam PRIORITY_NIBBLES = (PRIORITY_BITS +3 -1) / 4;
  
    //How many PRIORITY fields fit in 1 register?
    localparam PRIORITY_FIELDS_PER_REG = `DATA_SIZE / (PRIORITY_NIBBLES*4); 
  
    //How many Priority registers are there?
    localparam PRIORITY_REGS  = (`SOURCES + PRIORITY_FIELDS_PER_REG -1) / PRIORITY_FIELDS_PER_REG;
  
    //How many Threshold registers are there?
    localparam THRESHOLD_REGS = 1 == 0 ? 0 : `TARGETS;
  
    //How many ID register are there?
    localparam ID_REGS = `TARGETS;
  
    //How many registers in total?
    localparam TOTAL_REGS = CONFIG_REGS + EL_REGS + IE_REGS + PRIORITY_REGS + THRESHOLD_REGS + ID_REGS;





   //32'h00000008
   virtual function void write_ahb(input ahb_seq_item a_seq);
      received_ahb++;
      
      if(a_seq.h_write)begin
      case (a_seq.h_addr)                                 //FOR SIGNLE SOURCE SINGLE TARGET       // Level TRIGGERED Working
	8: begin
            el=a_seq.h_wdata && 32'h1;
          //  el=a_seq.h_wdata;
            `uvm_info("AHB ", $sformatf("WRITTEN EL IN SCB: %0d",el ) , UVM_LOW)
	end
	12: begin
           // p[0]=a_seq.h_wdata && 32'hF; 4
            p[0]=a_seq.h_wdata;
            `uvm_info("AHB ", $sformatf("WRITTEN P IN SCB: %0d",p[0] ) , UVM_LOW)
	end
	16: begin
            ie[0]=a_seq.h_wdata && 32'h1;
            //ie[0]=a_seq.h_wdata ;
            `uvm_info("AHB ", $sformatf("WRITTEN IE IN SCB: %0d",ie[0] ) , UVM_LOW)
	end
      20: begin
            th[0]=a_seq.h_wdata;
            `uvm_info("AHB ", $sformatf("WRITTEN TH IN SCB: %0d",th[0] ) , UVM_LOW)
      end
      24: begin
            //claim=a_seq.h_wdata;
          //  claim=1;
            complete=1;
            `uvm_info("AHB ", $sformatf("WRITTEN complete IN SCB:: %0d",claim ) , UVM_LOW)
	end

	default: begin
     
      `uvm_info(get_type_name(), " illegal address to write ", UVM_HIGH)
	end
      endcase

      end

      else begin
            case (a_seq.h_addr)
                  8: begin
                        if(el==a_seq.h_rdata)
                        `uvm_info("AHB ", $sformatf("READ AHB EL PASSED  EL=%0d",el ) , UVM_LOW)
                  end
                  12: begin
                        if(p[0]==a_seq.h_rdata)
                        `uvm_info("AHB ", $sformatf("READ AHB P PASSED P=%0d",p[0] ) , UVM_LOW)
                  end
                  16: begin
                        if(ie[0]==a_seq.h_rdata)
                        `uvm_info("AHB ", $sformatf("READ AHB IE PASSED IE=%0d",ie[0]) , UVM_LOW)
                  end
                  20: begin
                        if(th[0]==a_seq.h_rdata)
                        `uvm_info("AHB ", $sformatf("READ AHB TH PASSED TH=%0d",th[0] ) , UVM_LOW)
                  end
                  24: begin
                  //       if(claim==a_seq.h_rdata)
                  //      // complete=a_seq.h_rdata;
                        claim=1;
                        `uvm_info("AHB ", $sformatf("READ AHB claim Written: %0d",claim ) , UVM_LOW)
                  end
            
                  default: begin
                
                  `uvm_info(get_type_name(), " illegal address to read ", UVM_HIGH)
                  end
                  
            endcase

      end
   
   endfunction

   bit local_src;

   virtual function void write_irdrv (input ir_seq_item tr);
      received_irdrv++;
            if(tr.src)begin
                  local_src=tr.src;
            end
   
   endfunction
    


    virtual function void write_irmon (input ir_seq_item transaction);
      received_irmon++;

      if(ie[0])begin

            if(p[0]>th[0])begin

              if (el==1 || el==0) begin              //  after claim src =0 
                  if (local_src==1 )begin
              
                   if( transaction.irq==1 ) begin
                        if(claim)begin              
                              local_src=0;
                                        
                    `uvm_info("compare", {"Test: PASSED!"}, UVM_LOW);
                    //`uvm_info("IE IN SCOREBOARD", $sformatf("IE IN SCOREBOARD: %0d",rc.ie[0] ) , UVM_LOW)
                  //  $display ("The value of driver src= %h ,value of monitor irq=%h",local_src,transaction.irq);
                        end
                end
                else begin
                //`uvm_error("compare", "Test: FAILED!");
                $display ("value of monitor irq=%h",transaction.irq);
                end
                end
              end
            end
            else begin
                  `uvm_error("compare", "Test: FAILED!");
              `uvm_error("Interrupt Priority", "P must be high than Threshold to let it be serve");
                  $display("P: %d , TH: %d ", p[0] , th[0] );
                end

          end
          else begin
            `uvm_error("compare", "Test: FAILED!");
          `uvm_error("IE"," must be Enabled");
          end

      
         
      
   endfunction




   function void report_phase(uvm_phase phase);
     
   `uvm_info(get_type_name(), $sformatf("Scoreboard Statistics:: AHB_MON received %0d   IR_DRV received  %0d  IR_MON received  %0d",received_ahb, received_irdrv , received_irmon), UVM_LOW)
      $display("TOTAL_REGS",TOTAL_REGS);

   endfunction : report_phase

endclass


