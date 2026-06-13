# AXI3 Protocol Verification using SystemVerilog & UVM

## Overview

* This project implements a verification environment for the AMBA AXI3 (Advanced eXtensible Interface) protocol using SystemVerilog and UVM.
* AXI3 is a high-performance, high-bandwidth, low-latency bus protocol developed by ARM and widely used in SoCs for communication between masters and slaves.
* The objective of this project is to verify AXI3 read and write transactions, burst transfers, and protocol compliance using a reusable UVM-based verification environment.

---
## AXI3 Features
* Separate Read and Write data paths
* Full-duplex communication
* Burst-based data transfers
* Multiple outstanding transactions
* Address/Data phase decoupling
* High throughput and low latency
* Support for different burst types:
  * FIXED
  * INCR
  * WRAP
---

## AXI3 Channels
AXI3 consists of five independent channels:
### Write Address Channel (AW)
Carries write transaction information from Master to Slave.
Signals:
* AWADDR  : Write address
* AWLEN   : Burst length
* AWSIZE  : Burst size
* AWBURST : Burst type
* AWVALID : Address valid
* AWREADY : Address ready

### Write Data Channel (W)
Carries write data from Master to Slave.
Signals:
* WDATA   : Write data
* WSTRB   : Byte enables
* WLAST   : Last transfer indicator
* WVALID  : Data valid
* WREADY  : Data ready

### Write Response Channel (B)
Carries write completion response from Slave to Master.
Signals:
* BRESP   : Write response
* BVALID  : Response valid
* BREADY  : Response ready

### Read Address Channel (AR)
Carries read transaction information from Master to Slave.
Signals:
* ARADDR  : Read address
* ARLEN   : Burst length
* ARSIZE  : Burst size
* ARBURST : Burst type
* ARVALID : Address valid
* ARREADY : Address ready

### Read Data Channel (R)
Carries read data from Slave to Master.
Signals:
* RDATA   : Read data
* RRESP   : Read response
* RLAST   : Last transfer indicator
* RVALID  : Data valid
* RREADY  : Data ready

---

## Burst Types
### FIXED Burst (2'b00)
Address remains constant for every transfer.

### INCR Burst (2'b01)
Address increments after each transfer.
Address Increment:
Address += (1 << AWSIZE)

Examples:
* AWSIZE = 0 → 1 byte
* AWSIZE = 1 → 2 bytes
* AWSIZE = 2 → 4 bytes
* AWSIZE = 3 → 8 bytes

### WRAP Burst (2'b10)
Address increments until the wrap boundary is reached and then wraps around.

---

## UVM Verification Components

### Sequence Item (axi_tx)

Contains:
* Address
* Burst Length
* Burst Size
* Burst Type
* Data Queue
* Strobe Queue

### Sequences
Generates:

* Single Write Transactions
* Single Read Transactions
* Burst Write Transactions
* Burst Read Transactions

### Driver

Drives AXI signals to DUT through the virtual interface.

### Monitor

Captures bus activity and converts signal-level activity into transactions.

### Scoreboard

Compares expected and actual transactions.

### Agent

Contains:

* Sequencer
* Driver
* Monitor

### Environment

Integrates:

* Agents
* Scoreboard
* Coverage Components

### Test

Configures and runs different AXI verification scenarios.




* ARM AMBA AXI3 Specification
* UVM User Guide
* SystemVerilog IEEE 1800 Standard
