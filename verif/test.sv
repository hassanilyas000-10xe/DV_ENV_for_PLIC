class my_test extends uvm_test;

    `uvm_component_utils(my_test)
    
    my_env env;
   
    
    virtual ahb_if vif;
    virtual ir_if ir_vif;

    virtual_seq seq;
    
    virtual_seq_claim seq_cl;
    
    virtual_seq_int seq_int;
  

    function new(string name = "my_test",uvm_component parent=null);
      super.new(name,parent);
    endfunction : new
  
    
    function void build_phase(uvm_phase phase);
      
      env = my_env::type_id::create("env", this);
      seq = virtual_seq::type_id::create("seq");
      seq_cl= virtual_seq_claim::type_id::create("seq_cl");
      seq_int= virtual_seq_int::type_id::create("seq_int");

      if (!uvm_config_db#(virtual ahb_if)::get(this, "*", "vif", vif)) 
      begin
        `uvm_fatal("AGENT", "No virtual interface specified for this agent instance")
      end
      if (!uvm_config_db#(virtual ir_if)::get(this, "*", "ir_vif", ir_vif)) 
      begin
        `uvm_fatal("AGENT", "No virtual interface specified for this agent instance")
      end
      uvm_config_db#(virtual ahb_if)::set( this, "env.*", "vif", vif);
      uvm_config_db#(virtual ir_if)::set( this, "env.*", "ir_vif", ir_vif);
    
      //set_type_override_by_type(random_test::get_type(),multiple_src_test_config::get_type());
    
    endfunction
    
    //---------------------------------------
    // end_of_elobaration phase
    //---------------------------------------  
    virtual function void end_of_elaboration();
      //print's the topology
        uvm_top.print_topology();
    endfunction
    
    task run_phase( uvm_phase phase );
      
      

      phase.raise_objection( this, "Starting seq in main phase" );

         

      $display("SEQ START");
      
      // fork
      // seq.start(env.vsr);              //interrupts configure + reset test
      //   repeat(1) begin                //send no. of interrupts to be sent on target
      //      seq_int.start(env.vsr);
      //     #300 seq_int.start(env.vsr);   
      //     forever begin
      //       seq_cl.start(env.vsr);                //interrupt check/serve
      //     end
      
      // end        
      // join_any          //for checking threshold join_any  

      fork
        seq.start(env.vsr);              //interrupts configure + reset test
          repeat(1) begin                //send no. of interrupts to be sent on target
             seq_int.start(env.vsr);
             #50 seq_cl.start(env.vsr);                //interrupt check/serve
             
           #100 seq_int.start(env.vsr);   
            #150 seq_cl.start(env.vsr);                //interrupt check/serve

            #100 seq_int.start(env.vsr);   
           #300 seq_cl.start(env.vsr);                //interrupt check/serve
            
        
        end        
        join_any          //for checking threshold join_any  

      // fork
      //   seq.start(env.vsr);              //interrupts configure + reset test
      //     repeat(1) begin                //send no. of interrupts to be sent on target
      //       seq_int.start(env.vsr); 
      //      #20 seq_int.start(env.vsr); 
      //      #20 seq_int.start(env.vsr); 
      //      #20 seq_int.start(env.vsr); 
      //      #20 seq_int.start(env.vsr); 
      //      #20 seq_int.start(env.vsr); 
      //      #20 seq_int.start(env.vsr); 
      //      #20 seq_int.start(env.vsr); 
      //      #20 seq_int.start(env.vsr); 
      //      #20 seq_int.start(env.vsr);
      //      #20 seq_int.start(env.vsr);
      //      #20 seq_int.start(env.vsr);
         
           
      //         seq_cl.start(env.vsr);
      //        // repeat(12)begin
      //         #20     seq_cl.start(env.vsr);
      //         #20     seq_cl.start(env.vsr);
      //         #20     seq_cl.start(env.vsr);           //interrupt check/serve
      //         #20     seq_cl.start(env.vsr); 
      //         #20     seq_cl.start(env.vsr);
      //         #20     seq_cl.start(env.vsr);
      //         #20     seq_cl.start(env.vsr);
      //         #20     seq_cl.start(env.vsr);
      //         #20     seq_cl.start(env.vsr);
      //         #20     seq_cl.start(env.vsr);
      //         #20     seq_cl.start(env.vsr);
      //         #20     seq_cl.start(env.vsr);
      //         #20     seq_cl.start(env.vsr);
      //         #20     seq_cl.start(env.vsr);
      //         #20     seq_cl.start(env.vsr);
      //         #20     seq_cl.start(env.vsr);
      //         #20     seq_cl.start(env.vsr);
      //       //end
        
      //   end        
      //   join          //for checking threshold join_any  
      
      
         

      #600;
      #600;
      //#300;
      phase.drop_objection( this , "Finished seq in main phase" );
    endtask: run_phase
    

  
  endclass 