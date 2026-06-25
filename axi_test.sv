class axi_test extends uvm_test;

   `uvm_component_utils(axi_test)

   axi_env env_h;

   `NEW_COMP

   //----------------------------------
   // Build
   //----------------------------------
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env_h = axi_env::type_id::create("env_h",this);

      //----------------------------------
      // Number of transactions
      //----------------------------------
      uvm_resource_db #(int)::set("GLOBAL",
         							"TX_COUNT",
         							20,
         							this);

   endfunction
  
  //end_of_elaboration_phase
function void end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology();
endfunction


   //----------------------------------
   // Run
   //----------------------------------
   task run_phase(uvm_phase phase);
      axi_nwr_nrd_seq seq;
      phase.raise_objection(this);
      seq = axi_nwr_nrd_seq::type_id::create("seq");
      seq.start(env_h.magt_h.sqr_h);
      phase.drop_objection(this);
   endtask

endclass

