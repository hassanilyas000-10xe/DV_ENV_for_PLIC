class virtual_seq extends uvm_sequence;
    `uvm_object_utils(virtual_seq)

    random_test rt;

    reset_test rst;

    multiple_src_test_config  mstc;
    multiple_irq_test_config   mitc;
    

        `uvm_declare_p_sequencer(virtual_seqr)

        function new (string name = "virtual_seq");
            super.new();
            
            rst = reset_test::type_id::create ("rst");
           
            rt = random_test :: type_id::create ("rt");
        
             mstc=multiple_src_test_config::type_id:: create ("mstc");
             mitc=multiple_irq_test_config::type_id:: create ("mitc");

        endfunction
   
        virtual task body();
            
            `uvm_do_on(rst,p_sequencer.ahb_seqr)                  //RESET TEST

           $display("RUNNING VIRTUAL SEQ on AHB SEQR");
          
           `uvm_do_on(rt,p_sequencer.ahb_seqr)                    //CONFIGURE REGISTERS for single source single target
           
    //Configure registers for multiple sources and targets
        //   `uvm_do_on(mstc,p_sequencer.ahb_seqr)             //CONFIGURE REGISTERS for multiple source single target
        //   `uvm_do_on(mitc,p_sequencer.ahb_seqr)             //CONFIGURE REGISTERS for single source multiple target
   
        endtask:body
    
    
    endclass:virtual_seq

    class virtual_seq_int extends uvm_sequence;
        `uvm_object_utils(virtual_seq_int)
       
        ir_base_seq ibs;
        ir_multiple_seq ims;
    
            `uvm_declare_p_sequencer(virtual_seqr)
    
            function new (string name = "virtual_seq_int");
                super.new();
                ibs  = ir_base_seq :: type_id :: create ("ibs");
                ims = ir_multiple_seq::type_id::create ("ims");
            endfunction
       
            virtual task body();
              
               $display("RUNNING VIRTUAL SEQ on IR SEQR");
                `uvm_do_on(ibs,p_sequencer.ir_seqr)                 //START INTERRUPT from single source
              // `uvm_do_on(ims,p_sequencer.ir_seqr)                 //START INTERRUPT from multiple source

              // #200;
       
            endtask:body
        
        
        endclass:virtual_seq_int


    class virtual_seq_claim extends uvm_sequence;
        `uvm_object_utils(virtual_seq_claim)
    
    
        id_check id_ck;
        multiple_id_check_src midc;
        ir_seq_item ir_sq;
        multiple_id_check_irq mici;
    
            `uvm_declare_p_sequencer(virtual_seqr)
    
            function new (string name = "virtual_seq_claim");
                super.new();           
                id_ck=id_check :: type_id :: create ("id_ck");
                midc=multiple_id_check_src :: type_id :: create ("midc");
                mici=multiple_id_check_irq :: type_id :: create ("mici");
            endfunction
       
            virtual task body();
                
           p_sequencer.fifo.get(ir_sq);
           $display("IR_SQ.IRQ= %b ",ir_sq.irq);
           if(ir_sq.irq>=1)begin
               $display("SEQ OF ID CLAIM IS RUNNING");              //INTERRUPT CLAIM AND COMPLETE for single source single target
               `uvm_do_on(id_ck,p_sequencer.ahb_seqr) 
                                                                            //For multiple id check
              // `uvm_do_on(midc,p_sequencer.ahb_seqr)
              // `uvm_do_on(mici,p_sequencer.ahb_seqr)
           end
       
            endtask:body
        
        
        endclass:virtual_seq_claim