class ir_base_seq extends uvm_sequence #(ir_seq_item);
    
    `uvm_object_utils(ir_base_seq);
    function new (string name = "ir_base_seq");
        super.new(name);
    endfunction

    task body();
        ir_seq_item tr;
      tr = ir_seq_item::type_id::create("tr");
            start_item(tr);
            tr.src = 1;
         
            $display("IR Seq finished");
      
            finish_item(tr);

            #40;

            start_item(tr);
            tr.src = 0;
            $display("IR Seq finished");
            finish_item(tr);
    endtask

endclass

//[15:0]src
class ir_multiple_seq extends uvm_sequence #(ir_seq_item);
    
    `uvm_object_utils(ir_multiple_seq);
    function new (string name = "ir_multiple_seq");
        super.new(name);
    endfunction
int i;
    task body();
        ir_seq_item tr;
        $display("IR MULTIPLE START Seq ");
        `uvm_do_with (tr, {tr.src==16'hFFFF;})            //`uvm_do_with (tr, {tr.src==16'h000F;})
        #40;
        `uvm_do_with (tr, {tr.src==16'h0000;})

        // for(i=0;i<16;i++)begin
        // `uvm_do_with (tr, {tr.src==16'h000F ;})
        // #40;
      // `uvm_do_with (tr, {tr.src==16'h0000 ;})
        
        // end        
    
    endtask

endclass