// ***************************************************************************
//
//        Copyright (C) 2008-2014 Intel Corporation All Rights Reserved.
//
//
// Engineer:            pratik.m.marolia@intel.com
// Create Date:         08-05-14 10:55
// Module Name:         cci_ext_afu
// Project:             QLP+SPL2
// Description:         This module presents the CCI EXTENDED port interface. Instantiate
//                      the user AFU in this module. For more information on CCI interface
//                      refer to "CCI Specification.pdf"
// 
// instantiated afu_top by yaping.liu@intel.com 10/8/2014
//
// ***************************************************************************
// CAUTION: sharath.jayaprakash@intel.com
// Interrupts and Umsgs are NOT supported as a part of system release 3.3. We 
// do expect to support these features in the future. These ports are 
// currently defined as placeholders. 
// When writing a wrapper for your AFU you need to define these ports for 
// compilation purposes.
// ***************************************************************************

module cci_ext_afu(
  // Link/Protocol (LP) clocks and reset
  input  /*var*/  logic             vl_clk_LPdomain_32ui,                      // CCI Inteface Clock. 32ui link/protocol clock domain.
  input  /*var*/  logic             vl_clk_LPdomain_16ui,                      // 2x CCI interface clock. Synchronous.16ui link/protocol clock domain.
  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_SystemReset_n,         // System Reset
  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_SoftReset_n,           // CCI-S soft reset

  // Native CCI Interface (cache line interface for back end)
  /* Channel 0 can receive READ, WRITE, WRITE CSR, UMsg, Interrupt responses.*/
  input  /*var*/  logic      [23:0] ffs_vl18_LP32ui_lp2sy_C0RxHdr,             // System to LP header
  input  /*var*/  logic     [511:0] ffs_vl512_LP32ui_lp2sy_C0RxData,           // System to LP data 
  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_C0RxWrValid,           // RxWrHdr valid signal 
  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_C0RxRdValid,           // RxRdHdr valid signal
  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_C0RxCgValid,           // RxCgHdr valid signal
  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_C0RxUgValid,           // Rx Umsg Valid signal
  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_C0RxIrValid,           // Rx Interrupt valid signal
  /* Channel 1 reserved for WRITE, INTERRUPT RESPONSES */
  input  /*var*/  logic      [23:0] ffs_vl18_LP32ui_lp2sy_C1RxHdr,             // System to LP header (Channel 1)
  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_C1RxWrValid,           // RxData valid signal (Channel 1)
  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_C1RxIrValid,           // Rx Interrupt valid signal (Channel 1)

  /*Channel 0 reserved for READ REQUESTS ONLY */        
  output /*var*/  logic      [98:0] ffs_vl61_LP32ui_sy2lp_C0TxHdr,             // System to LP header 
  output /*var*/  logic             ffs_vl_LP32ui_sy2lp_C0TxRdValid,           // TxRdHdr valid signals 
  /*Channel 1 reserved for WRITE, INTERRUPT REQUESTS ONLY */       
  output /*var*/  logic      [98:0] ffs_vl61_LP32ui_sy2lp_C1TxHdr,             // System to LP header
  output /*var*/  logic     [511:0] ffs_vl512_LP32ui_sy2lp_C1TxData,           // System to LP data 
  output /*var*/  logic             ffs_vl_LP32ui_sy2lp_C1TxWrValid,           // TxWrHdr valid signal
  output /*var*/  logic             ffs_vl_LP32ui_sy2lp_C1TxIrValid,           // Tx Interrupt valid signal
  /* Tx push flow control */
  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_C0TxAlmFull,           // Channel 0 almost full
  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_C1TxAlmFull,           // Channel 1 almost full

  input  /*var*/  logic             ffs_vl_LP32ui_lp2sy_InitDnForSys           // System layer is aok to run
);

/* SPL2 test AFU goes here
*/
    afu_top afu_top(
        .clk                        (vl_clk_LPdomain_32ui),
        .reset_n                    (ffs_vl_LP32ui_lp2sy_SystemReset_n),
        .spl_enable                 (ffs_vl_LP32ui_lp2sy_InitDnForSys),
        .spl_reset                  (~ffs_vl_LP32ui_lp2sy_SoftReset_n),
        
        // AFU TX read request
        .spl_tx_rd_almostfull       (ffs_vl_LP32ui_lp2sy_C0TxAlmFull),
        .afu_tx_rd_valid            (ffs_vl_LP32ui_sy2lp_C0TxRdValid),
        .afu_tx_rd_hdr              (ffs_vl61_LP32ui_sy2lp_C0TxHdr),
    
        // AFU TX write request
        .spl_tx_wr_almostfull       (ffs_vl_LP32ui_lp2sy_C1TxAlmFull),
        .afu_tx_wr_valid            (ffs_vl_LP32ui_sy2lp_C1TxWrValid),
        .afu_tx_intr_valid          (ffs_vl_LP32ui_sy2lp_C1TxIrValid),
        .afu_tx_wr_hdr              (ffs_vl61_LP32ui_sy2lp_C1TxHdr),    
        .afu_tx_data                (ffs_vl512_LP32ui_sy2lp_C1TxData),
    
        // AFU RX read response
        .spl_rx_rd_valid            (ffs_vl_LP32ui_lp2sy_C0RxRdValid),
        .spl_rx_wr_valid0           (ffs_vl_LP32ui_lp2sy_C0RxWrValid),
        .spl_rx_cfg_valid           (ffs_vl_LP32ui_lp2sy_C0RxCgValid),
        .spl_rx_intr_valid0         (ffs_vl_LP32ui_lp2sy_C0RxIrValid),
        .spl_rx_umsg_valid          (ffs_vl_LP32ui_lp2sy_C0RxUgValid),
        .spl_rx_hdr0                (ffs_vl18_LP32ui_lp2sy_C0RxHdr),
        .spl_rx_data                (ffs_vl512_LP32ui_lp2sy_C0RxData),
    
        // AFU RX write response
        .spl_rx_wr_valid1           (ffs_vl_LP32ui_lp2sy_C1RxWrValid),
        .spl_rx_intr_valid1         (ffs_vl_LP32ui_lp2sy_C1RxIrValid),
        .spl_rx_hdr1                (ffs_vl18_LP32ui_lp2sy_C1RxHdr)
    );
    
endmodule
