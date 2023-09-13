-64

 //-uvmhome $UVMHOME

// options


// include directories
//*** add incdir include directories here

//+incdir+/home/hassan/sverilog/a_peek_into_real_assignment_UVM/assignment1-integ/sv       //	YAPP
+incdir+/home/hassan/sverilog/tcp_plic/rtl/verilog
+incdir+/home/hassan/sverilog/tcp_plic/rtl/verilog/core
+incdir+/home/hassan/sverilog/tcp_plic/ahb
+incdir+/home/hassan/sverilog/tcp_plic/ir

+incdir+/home/hassan/sverilog/tcp_plic/verif 



// set default timescale
//-timescale 1ns/100ps
../rtl/verilog/ahb3lite_pkg.sv

/home/hassan/sverilog/tcp_plic/verif/define.sv
../rtl/verilog/core/plic_cell.sv
../rtl/verilog/core/plic_gateway.sv
../rtl/verilog/core/plic_priority_index.sv
../rtl/verilog/core/plic_target.sv
../rtl/verilog/core/plic_dynamic_registers.sv
../rtl/verilog/core/plic_core.sv

// compile files
//*** add compile files here
//clk_rst_if.sv
//dut_prob_if.sv
//inst_mem/ins_mem_if.sv

//data_mem/data_mem_if.sv
 
 ../ahb/ahb_interface.sv
 ../ir/ir_interface.sv

../rtl/verilog/ahb3lite/ahb3lite_plic_top.sv

//../sv/router_module_pkg.sv

//clkgen.sv // compile clock generation
//../../router_rtl/yapp_router.sv // compile yapp router
//hw_top_dut.sv // compile hardware top level
#inst_mem/ins_mem_testbench.sv

testbench.sv
