class axi_sequence extends uvm_sequence#(axi_tx);
	`uvm_object_utils(axi_sequence)
	`NEW_OBJ
	uvm_phase phase;
	task pre_body();
		phase=get_starting_phase();
		if(phase!=null)begin
			phase.raise_objection(this);
			phase.phase_done.set_drain_time(this,100);
		end
	endtask
	task post_body();
		if(phase!=null)begin
			phase.drop_objection(this);
		end
	endtask
endclass

class axi_wr_rd_seq extends axi_sequence;
	`uvm_object_utils(axi_wr_rd_seq)
	`NEW_OBJ
  int tx_count;
	axi_tx tx;
	task body();

		  if(!uvm_resource_db #(int)::read_by_name("GLOBAL",
            										"TX_COUNT",
            										tx_count,
            										null))
         tx_count = 10;

		//write
		`uvm_do_with(req,{req.wr_rd==1;})
		tx = axi_tx::type_id::create("tx");
		tx.copy(req);
		//read
		`uvm_do_with(req,{req.wr_rd==0;
						  req.id==tx.id;
						  req.addr== tx.addr;
						  req.burst_len==tx.burst_len;
						  req.burst_size==tx.burst_size;
						  req.burst_type==tx.burst_type;})

	endtask
endclass

class axi_nwr_nrd_seq extends axi_sequence;
	`uvm_object_utils(axi_nwr_nrd_seq)
	`NEW_OBJ
	int tx_count;
	axi_tx tx,txQ[$];
	task body();
		uvm_resource_db#(int)::read_by_name("GLOBAL","TX_COUNT",tx_count,null);
		//write
		repeat(tx_count)begin
			`uvm_do_with(req,{req.wr_rd==1;})
			tx = axi_tx::type_id::create("tx");
			tx.copy(req);
			txQ.push_back(tx);
		end
		//read
		repeat(tx_count)begin
			tx=txQ.pop_front();
			`uvm_do_with(req,{req.wr_rd==0;
						  req.id==tx.id;
						  req.addr== tx.addr;
						  req.burst_len==tx.burst_len;
						  req.burst_size==tx.burst_size;
						  req.burst_type==tx.burst_type;})

		end
	endtask
endclass
	
