//    
    module top (
        inout logic [14:0]DDR_addr,
        inout logic[2:0]DDR_ba,
        inout logic DDR_cas_n,
        inout logic DDR_ck_n,
        inout logic DDR_ck_p,
        inout logic DDR_cke,
        inout logic DDR_cs_n,
        inout logic [3:0]DDR_dm,
        inout logic [31:0]DDR_dq,
        inout logic [3:0]DDR_dqs_n,
        inout logic [3:0]DDR_dqs_p,
        inout logic DDR_odt,
        inout logic DDR_ras_n,
        inout logic DDR_reset_n,
        inout logic DDR_we_n,
        inout logic FIXED_IO_ddr_vrn,
        inout logic FIXED_IO_ddr_vrp,
        inout logic [53:0]FIXED_IO_mio,
        inout vFIXED_IO_ps_clk,
        inout logic FIXED_IO_ps_porb,
        inout logic FIXED_IO_ps_srstb,
        output logic [3:0] led
    );
    
    logic axi_aclk;
    logic SPI_0_0_io0_i;
    logic SPI_0_0_io0_io;
    logic SPI_0_0_io0_o;
    logic SPI_0_0_io0_t;
    logic SPI_0_0_io1_i;
    logic SPI_0_0_io1_io;
    logic SPI_0_0_io1_o;
    logic SPI_0_0_io1_t;
    logic SPI_0_0_sck_i;
    logic SPI_0_0_sck_io;
    logic SPI_0_0_sck_o;
    logic SPI_0_0_sck_t;
    logic SPI_0_0_ss1_o;
    logic SPI_0_0_ss2_o;
    logic SPI_0_0_ss_i;
    logic SPI_0_0_ss_io;
    logic SPI_0_0_ss_o;
    logic SPI_0_0_ss_t;
    
    system system_i (
        .DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),    
        //  
        .axi_aclk(axi_aclk),
        .SPI_0_0_io0_i(SPI_0_0_io0_i),
        .SPI_0_0_io0_o(SPI_0_0_io0_o),
        .SPI_0_0_io0_t(SPI_0_0_io0_t),
        .SPI_0_0_io1_i(SPI_0_0_io1_i),
        .SPI_0_0_io1_o(SPI_0_0_io1_o),
        .SPI_0_0_io1_t(SPI_0_0_io1_t),
        .SPI_0_0_sck_i(SPI_0_0_sck_i),
        .SPI_0_0_sck_o(SPI_0_0_sck_o),
        .SPI_0_0_sck_t(SPI_0_0_sck_t),
        .SPI_0_0_ss1_o(SPI_0_0_ss1_o),
        .SPI_0_0_ss2_o(SPI_0_0_ss2_o),
        .SPI_0_0_ss_i(SPI_0_0_ss_i),
        .SPI_0_0_ss_o(SPI_0_0_ss_o),
        .SPI_0_0_ss_t(SPI_0_0_ss_t),  
        //
        .led_tri_o(led)
    );
    
    spi_ila spi_ila_inst (.clk(axi_aclk), .probe0({SPI_0_0_io0_i,SPI_0_0_io0_io,SPI_0_0_io0_o,SPI_0_0_io0_t,SPI_0_0_io1_i,SPI_0_0_io1_io,SPI_0_0_io1_o,SPI_0_0_io1_t,
            SPI_0_0_sck_i,SPI_0_0_sck_io,SPI_0_0_sck_o,SPI_0_0_sck_t,SPI_0_0_ss1_o,SPI_0_0_ss2_o,SPI_0_0_ss_i,SPI_0_0_ss_io,SPI_0_0_ss_o,SPI_0_0_ss_t}) ); // 18
    
    endmodule
