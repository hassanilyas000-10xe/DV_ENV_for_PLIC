class reset_test extends uvm_sequence #(ahb_seq_item);
    `uvm_object_utils(reset_test);
    function new (string name = "reset_test");
        super.new(name);
    endfunction

    task body();
       
        ahb_seq_item tr;
     
        $display("RESETIING ALL");
      
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==0;tr.h_size==0;tr.h_sel_0==0;tr.h_ready==0;tr.h_addr==0;tr.h_wdata==0;tr.h_prot==0;tr.h_write==0;}) 
      
    endtask

endclass


class random_test extends uvm_sequence #(ahb_seq_item);

  `uvm_object_utils(random_test);

  function new (string name = "random_test");
        super.new(name);
    endfunction

    task body();
         ahb_seq_item tr;
      repeat (1) begin
        
            tr = ahb_seq_item::type_id::create("tr");
            start_item(tr);
        //	tr.h_reset_n = 1;
            tr.h_burst =0;
        	tr.h_write = 1;
        	tr.h_addr  = 8;       //1
            tr.h_wdata = 1;       //EL
        	tr.h_trans =2;
        	tr.h_size  =2;
           // $display("Sequence printing start");
           // tr.print();
            finish_item(tr);
        
        
        
            tr = ahb_seq_item::type_id::create("tr");
            start_item(tr);
           // tr.h_reset_n = 1;
        	tr.h_write = 1;
            tr.h_burst =0;           
        	tr.h_addr  = 12;        //PRIORITY
            tr.h_wdata = 2;           //2
        	tr.h_trans =2;
        	tr.h_size  =2;
           // $display("Sequence printing start");
           // tr.print();
            finish_item(tr);
        
        
            tr = ahb_seq_item::type_id::create("tr");
            start_item(tr);
            //tr.h_reset_n = 1;
        	tr.h_write = 1;
        	tr.h_addr  = 16;        //1
            tr.h_wdata = 1;         //IE
            //tr.h_wdata = 32'h0000000F;
            
            tr.h_burst =0;
        	tr.h_trans =2;
        	tr.h_size  =2;
           // $display("Sequence printing start");
           // tr.print();
            finish_item(tr);

            tr = ahb_seq_item::type_id::create("tr");
            start_item(tr);
            //tr.h_reset_n = 1;
        	tr.h_write = 1;
        	tr.h_addr  = 20;        //1
            tr.h_wdata = 1;           //THRESHOLD
            tr.h_burst =0;
        	tr.h_trans =2;
        	tr.h_size  =2;
           // $display("Sequence printing start");
           // tr.print();
            finish_item(tr);

            //
            //         STARTED READING OF REGISTERS
            //
            tr = ahb_seq_item::type_id::create("tr");
            start_item(tr);
            //tr.h_reset_n = 1;
        	tr.h_write = 0;
        	tr.h_addr  = 0;
            //tr.h_wdata = 0;
            tr.h_burst =0;
        	tr.h_trans =2;
        	tr.h_size  =2;
           // $display("Sequence printing start");
           // tr.print();
            finish_item(tr);

            tr = ahb_seq_item::type_id::create("tr");
            start_item(tr);
            //tr.h_reset_n = 1;
        	tr.h_write = 0;
        	tr.h_addr  = 4;
            //tr.h_wdata = 0;
            tr.h_burst =0;
        	tr.h_trans =2;
        	tr.h_size  =2;
           // $display("Sequence printing start");
           // tr.print();
            finish_item(tr);

            tr = ahb_seq_item::type_id::create("tr");
            start_item(tr);
            //tr.h_reset_n = 1;
        	tr.h_write = 0;
        	tr.h_addr  = 8;
            //tr.h_wdata = 0;
            tr.h_burst =0;
        	tr.h_trans =2;
        	tr.h_size  =2;
           // $display("Sequence printing start");
           // tr.print();
            finish_item(tr);
        
            tr = ahb_seq_item::type_id::create("tr");
            start_item(tr);
            //tr.h_reset_n = 1;
        	tr.h_write = 0;
        	tr.h_addr  = 12;
            //tr.h_wdata = 0;
            tr.h_burst =0;
        	tr.h_trans =2;
        	tr.h_size  =2;
           // $display("Sequence printing start");
           // tr.print();
            finish_item(tr);

            tr = ahb_seq_item::type_id::create("tr");
            start_item(tr);
            //tr.h_reset_n = 1;
        	tr.h_write = 0;
        	tr.h_addr  = 16;
            //tr.h_wdata = 0;
            tr.h_burst =0;
        	tr.h_trans =2;
        	tr.h_size  =2;
           // $display("Sequence printing start");
           // tr.print();
            finish_item(tr);

            tr = ahb_seq_item::type_id::create("tr");
            start_item(tr);
            //tr.h_reset_n = 1;
        	tr.h_write = 0;
        	tr.h_addr  = 20;
            //tr.h_wdata = 0;
            tr.h_burst =0;
        	tr.h_trans =2;
        	tr.h_size  =2;
           // $display("Sequence printing start");
           // tr.print();
            finish_item(tr);


           
        
      end    
    endtask
endclass

    class id_check extends uvm_sequence #(ahb_seq_item);
       
        `uvm_object_utils(id_check);
        function new (string name = "id_check");
            super.new(name);
        endfunction


      `uvm_declare_p_sequencer(ahb_sequencer)
    
        task body();
           
            ahb_seq_item tr;
            ahb_seq_item seq;
           
          repeat(1) begin
           
            tr = ahb_seq_item::type_id::create("tr");
            start_item(tr);
        	tr.h_write = 0;
        	tr.h_addr  = 24;
            //tr.h_wdata = 0;
            tr.h_burst =0;
        	tr.h_trans =2;
        	tr.h_size  =2;
            finish_item(tr);

            //@(tr.h_rdata);
             
            seq = ahb_seq_item::type_id::create("seq");
            p_sequencer.input_flow_f.get(seq);
             
            // 
            // $display("HRDATA IN SEQ:: %d",seq.h_rdata);
            // if(seq.h_rdata>0)begin                             //ID>0
            //     $display("DONE COMPLETE");
            
            
            $display("HRDATA IN SEQ:: %d",seq.h_rdata);
                tr = ahb_seq_item::type_id::create("tr");
                start_item(tr);
                assert(tr.randomize());
        	tr.h_write = 1;
        	tr.h_addr  = 24;
            
         //   tr.h_wdata = ;  //random write
            tr.h_burst =0;
        	tr.h_trans =2;
        	tr.h_size  =2;
            finish_item(tr);
           
            end

        //    end
        endtask

endclass


class multiple_src_test_config extends random_test #(ahb_seq_item);
    `uvm_object_utils(multiple_src_test_config);
    function new (string name = "multiple_src_test_config");
        super.new(name);
    endfunction
    int i;
    task body();
       
        ahb_seq_item tr;
///////////////////////////////            WRITING ALL           /////////////////////////////////
//Edge Triggered
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==1;tr.h_wdata==32'h0000FFFF;tr.h_addr==8;tr.h_size==2;}) //EL = 1
//P =3  
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==1;tr.h_wdata==32'h33333533;tr.h_addr==12;tr.h_size==2;}) //P1 = 1

        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==1;tr.h_wdata==32'h33333333;tr.h_addr==16;tr.h_size==2;}) //P2 = 1

//IE =1 in all 16
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==1;tr.h_wdata==32'h0000FFFF;tr.h_addr==20;tr.h_size==2;}) //IE 
        
       
//TH=1 in all
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==1;tr.h_wdata==1;tr.h_addr==24;tr.h_size==2;}) //T1 = 1


        ///////////////////////            READING ALL                    ///////////////////

        for(i=0;i<=24;i=i+4) begin
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==0;tr.h_addr==i;tr.h_size==2;}) 
        end
    endtask

endclass

class multiple_id_check_src extends uvm_sequence #(ahb_seq_item);
       
    `uvm_object_utils(multiple_id_check_src);
    function new (string name = "multiple_id_check_src");
        super.new(name);
    endfunction
    int i;

  `uvm_declare_p_sequencer(ahb_sequencer)

    task body();
       
        ahb_seq_item tr;
        ahb_seq_item seq;
       
        
      repeat(1) begin
       
     
        //for(i=52;i<=64;i=i+4)begin
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==0;tr.h_addr==28;tr.h_size==2;}) //ID ,1,2,3,4
        //end

        seq = ahb_seq_item::type_id::create("seq");

        p_sequencer.input_flow_f.get(seq);
        $display("HRDATA IN SEQ:: %d",seq.h_rdata);
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==1;tr.h_addr==seq.h_addr;tr.h_size==2;}) //ID ,1,2,3,4
       
        end

    endtask

endclass

class multiple_irq_test_config extends random_test #(ahb_seq_item);
    `uvm_object_utils(multiple_irq_test_config);
    function new (string name = "multiple_irq_test_config");
        super.new(name);
    endfunction
    int i;
    task body();
       
        ahb_seq_item tr;

///////////////////////////////            WRITING ALL           /////////////////////////////////
        //TH=1 in all
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==1;tr.h_wdata==1;tr.h_addr==32;tr.h_size==2;}) //T1 = 1
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==1;tr.h_wdata==1;tr.h_addr==36;tr.h_size==2;}) //T1 = 1
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==1;tr.h_wdata==5;tr.h_addr==40;tr.h_size==2;}) //T1 = 1
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==1;tr.h_wdata==1;tr.h_addr==44;tr.h_size==2;}) //T1 = 1
//Edge Triggered
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==1;tr.h_wdata==1;tr.h_addr==8;tr.h_size==2;}) //EL = 1
//P =2  
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==1;tr.h_wdata==2;tr.h_addr==12;tr.h_size==2;}) //P1 

//IE =1 in all 4 irqs
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==1;tr.h_wdata==1;tr.h_addr==16;tr.h_size==2;}) //IE 
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==1;tr.h_wdata==1;tr.h_addr==20;tr.h_size==2;}) //IE 
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==1;tr.h_wdata==1;tr.h_addr==24;tr.h_size==2;}) //IE 
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==1;tr.h_wdata==1;tr.h_addr==28;tr.h_size==2;}) //IE 
        
       

        ///////////////////////            READING ALL                    ///////////////////

        for(i=0;i<=44;i=i+4) begin
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==0;tr.h_addr==i;tr.h_size==2;}) 
        end
    endtask

endclass

class multiple_id_check_irq extends uvm_sequence #(ahb_seq_item);
       
    `uvm_object_utils(multiple_id_check_irq);
    function new (string name = "multiple_id_check_irq");
        super.new(name);
    endfunction
    int i;

  `uvm_declare_p_sequencer(ahb_sequencer)

    task body();
       
        ahb_seq_item tr;
        ahb_seq_item seq;
       
        
      repeat(1) begin
       
     
        
        //for(i=52;i<=64;i=i+4)begin
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==0;tr.h_addr==48;tr.h_size==2;}) //ID ,1,2,3,4
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==0;tr.h_addr==52;tr.h_size==2;})
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==0;tr.h_addr==56;tr.h_size==2;})
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==0;tr.h_addr==60;tr.h_size==2;})
        seq = ahb_seq_item::type_id::create("seq");

        p_sequencer.input_flow_f.get(seq);

        //end

        $display("HRDATA IN SEQ:: %d",seq.h_rdata);
        `uvm_do_with (tr, {tr.h_burst==0 && tr.h_trans ==2;tr.h_write==1;tr.h_addr==seq.h_addr;tr.h_size==2;}) //ID ,1,2,3,4
       
        end

    endtask

endclass