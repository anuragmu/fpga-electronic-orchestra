
module Soundprocessor(

	//////////// CLOCK //////////
	CLOCK_50,

	//////////// LED //////////
	//LED,

	//////////// KEY //////////
	KEY,

	//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
	GPIO_0_D,
	GPIO_0_IN,	
	
	//////////// Accelerometer and EEPROM //////////
	G_SENSOR_CS_N,
	G_SENSOR_INT,
	I2C_SCLK,
	I2C_SDAT ,
	//////awaaz////
	sa2
);

		//=======================================================
		//  PARAMETER declarations
		//=======================================================


		//=======================================================
		//  PORT declarations
		//=======================================================

		//////////// CLOCK //////////
		input 		          		CLOCK_50;

		//////////// LED //////////
		//output		     [7:0]		LED;

		//////////// KEY //////////
		input 		     [1:0]		KEY;

		//////////// Accelerometer and EEPROM //////////
		output		          		G_SENSOR_CS_N;
		input 		          		G_SENSOR_INT;
		output		          		I2C_SCLK;
		inout 		          		I2C_SDAT;

		//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
		output 		    [33:0]		GPIO_0_D;
		reg              [33:0]     GPIO_0_Y;
		input 		     [1:0]		GPIO_0_IN;

		//=======================================================
		//  REG/WIRE declarations
		//=======================================================
		wire	        dly_rst;
		wire	        spi_clk, spi_clk_out;
		wire	[15:0]  data_x;
		wire	[15:0]  data_y;
		reg  sa1;
		output sa2;

		//=======================================================
		//  Structural coding
		//=======================================================
		//	Reset

		reset_delay	u_reset_delay	(	
					.iRSTN(KEY[0]),
					.iCLK(CLOCK_50),
					.oRST(dly_rst));

		//  PLL            
		spipll u_spipll	(
					.areset(dly_rst),
					.inclk0(CLOCK_50),
					.c0(spi_clk),      // 2MHz
					.c1(spi_clk_out)); // 2MHz phase shift 

		//  Initial Setting and Data Read Back
		spi_ee_config u_spi_ee_config (			
								.iRSTN(!dly_rst),															
								.iSPI_CLK(spi_clk),								
								.iSPI_CLK_OUT(spi_clk_out),								
								.iG_INT2(G_SENSOR_INT),            
								.oDATA_L(data_x[7:0]),
								.oDATA_H(data_x[15:8]),
								.SPI_SDIO(I2C_SDAT),
								.oSPI_CSN(G_SENSOR_CS_N),
								.oSPI_CLK(I2C_SCLK)
								);
		//for Y
		spi_ee_config_y y_spi_ee_config (			
								.iRSTN(!dly_rst),															
								.iSPI_CLK(spi_clk),								
								.iSPI_CLK_OUT(spi_clk_out),								
								.iG_INT2(G_SENSOR_INT),            
								.oDATA_L(data_y[7:0]),
								.oDATA_H(data_y[15:8]),
								.SPI_SDIO(I2C_SDAT),
								.oSPI_CSN(G_SENSOR_CS_N),
								.oSPI_CLK(I2C_SCLK)
								);
											
		//	LED
		led_driver u_led_driver	(	
								.iRSTN(!dly_rst),
								.iCLK(CLOCK_50),
								.iDIG(data_x[9:0]),
								.iG_INT2(G_SENSOR_INT),            
								.oLED(GPIO_0_D)
								);	

		led_driver y_led_driver	(	
								.iRSTN(!dly_rst),
								.iCLK(CLOCK_50),
								.iDIG(data_y[9:0]),
								.iG_INT2(G_SENSOR_INT),            
								.oLED(GPIO_0_Y)
								);	
								
		Saptak S1(.clk(CLOCK_50),.sa1(sa1),.oled(GPIO_0_D));

		Tempo S2 (.clk(CLOCK_50),.sa2(sa2),.oled(GPIO_0_Y), .sa1(sa1));				

endmodule

module Tempo(clk, sa2, oled, sa1);
	input clk;
	input [23:0] oled;
	input sa1;
	output sa2;
	reg slowclk;
	reg [32:0] count_sa2;
	//			if (oled==32'hF0000000) 
	assign sa2 = sa1&slowclk;
	always @ (posedge clk)
		 begin
			if (oled==32'hF0000000)
				begin
							if (count_sa == 100000000) 
								begin
									count_sa1 <= 0;
									slowclk=~slowclk;
							end
							
							else
								begin 
								count_sa1 <= count_sa1 + 1;
							end 
				end
			else if (oled==32'h0F000000 ) 
				begin
							if (count_sa == 90000000) 
								begin
									count_sa1 <= 0;
									slowclk=~slowclk;
							end
							
							else
								begin 
								count_sa1 <= count_sa1 + 1;
							end 
				end
			else if (oled== 32'h03C00000) 
				begin
							if (count_sa == 80000000) 
								begin
									count_sa1 <= 0;
									slowclk=~slowclk;
							end
							
							else
								begin 
								count_sa1 <= count_sa1 + 1;
							end 
				end
			else if (oled== 32'h00F00000) 
				begin
							if (count_sa == 70000000) 
								begin
									count_sa1 <= 0;
									slowclk=~slowclk;
							end
							
							else
								begin 
								count_sa1 <= count_sa1 + 1;
							end 
				end
			else if (oled== 32'h003C0000) 
				begin
							if (count_sa == 60000000) 
								begin
									count_sa1 <= 0;
									slowclk=~slowclk;
							end
							
							else
								begin 
								count_sa1 <= count_sa1 + 1;
							end 
				end
			else if (oled== 32'h000F0000) 
				begin
							if (count_sa == 50000000) 
								begin
									count_sa1 <= 0;
									slowclk=~slowclk;
							end
							
							else
								begin 
								count_sa1 <= count_sa1 + 1;
							end 
				end
			else if (oled==32'h0003C000) 
				begin
							if (count_sa == 40000000) 
								begin
									count_sa1 <= 0;
									slowclk=~slowclk;
							end
							
							else
								begin 
								count_sa1 <= count_sa1 + 1;
							end 
				end
			else if (oled== 32'hF000) 
				begin
							if (count_sa == 30000000) 
								begin
									count_sa1 <= 0;
									slowclk=~slowclk;
							end
							
							else
								begin 
								count_sa1 <= count_sa1 + 1;
							end 
				end
			else if (oled== 32'h3C00) 
				begin
							if (count_sa == 20000000) 
								begin
									count_sa1 <= 0;
									slowclk=~slowclk;
							end
							
							else
								begin 
								count_sa1 <= count_sa1 + 1;
							end 
				end
			else if (oled== 32'h0F00) 
				begin
							if (count_sa == 10000000) 
								begin
									count_sa1 <= 0;
									slowclk=~slowclk;
							end
							
							else
								begin 
								count_sa1 <= count_sa1 + 1;
							end 
				end
			else if (oled== 32'h03C0) 
				begin
							if (count_sa == 5000000) 
								begin
									count_sa1 <= 0;
									slowclk=~slowclk;
							end
							
							else
								begin 
								count_sa1 <= count_sa1 + 1;
							end 
				end
				/*else if (oled==32'h00F0) 
else if (oled==32'h003C) 
else if (oled==32'h000F)*/*/
				
			end
endmodule




module led_driver (iRSTN, iCLK, iDIG, iG_INT2, oLED);
		input				       iRSTN;
		input				       iCLK;
		input		    [9:0]  iDIG;
		input		           iG_INT2;
		output	    [33:0]  oLED;

		//=======================================================
		//  REG/WIRE declarations
		//=======================================================
		wire				[4:0]  select_data;
		wire               signed_bit;
		wire				[3:0]  abs_select_high;
		reg				  [1:0]  int2_d;
		reg	        [23:0] int2_count;
		reg	               int2_count_en;

		//=======================================================
		//  Structural coding
		//=======================================================
		assign select_data = iG_INT2 ? iDIG[9:5] :  // +-2g resolution : 10-bit
									   (iDIG[9]?(iDIG[8]?iDIG[8:4]:5'h10):(iDIG[8]?5'hf:iDIG[8:4])); // +-g resolution : 9-bit                               
		assign signed_bit = select_data[4];
		assign abs_select_high = signed_bit ? ~select_data[3:0] : select_data[3:0]; // the negitive number here is the 2's complement - 1

		assign oLED = int2_count[23] ? (		(abs_select_high[3:1] == 3'h0) ? 32'h0003C000 :
											(abs_select_high[3:1] == 3'h1) ? (signed_bit?32'hF000:32'h000F0000) :
												(abs_select_high[3:1] == 3'h2) ? (signed_bit?32'h3C00:32'h003C0000) :
												(abs_select_high[3:1] == 3'h3) ? (signed_bit?32'h0F00:32'h00F00000) :
												(abs_select_high[3:1] == 3'h4) ? (signed_bit?32'h03C0:32'h03C00000) :
												(abs_select_high[3:1] == 3'h5) ? (signed_bit?32'h00F0:32'h0F000000) :
												(abs_select_high[3:1] == 3'h6) ? (signed_bit?32'h003C:32'h3C000000) :
																				 (signed_bit?32'h000F:32'hF0000000)):
												(int2_count[20] ? 8'h0 : 8'hff); // Activity

		always@(posedge iCLK or negedge iRSTN)
			if (!iRSTN)
		  begin
			int2_count_en	<= 1'b0;
			int2_count <= 24'h800000;
		  end
			else
			begin
				int2_d <= {int2_d[0], iG_INT2};

				if (!int2_d[1] && int2_d[0])
			begin
			  int2_count_en	<= 1'b1;
				int2_count <= 24'h0;
			  end
			  else if (int2_count[23])
				int2_count_en	<= 1'b0; 	
			else
				int2_count <= int2_count + 1;
			end

endmodule


module	reset_delay(iRSTN, iCLK, oRST);
		input		    iRSTN;
		input		    iCLK;
		output reg	oRST;

		reg  [20:0] cont;

		always @(posedge iCLK or negedge iRSTN)
		  if (!iRSTN) 
		  begin
			cont     <= 21'b0;
			oRST     <= 1'b1;
		  end
		  else if (!cont[20]) 
		  begin
			cont <= cont + 21'b1;
			oRST <= 1'b1;
		  end
		  else
			oRST <= 1'b0;
	  
endmodule

/////////////////////
module Saptak (clk,sa1,oled);
		input [23:0] oled;

		input clk;
		output sa1;
		reg sa1;
		reg [16:0] count_sa1;


		always @(posedge clk)
		begin

					if (oled==32'hF0000000) 
					begin
								if (count_sa1 == 104167) 
									begin
										count_sa1 <= 0;
										sa1 <= ~sa1;
								end
								
								else
									begin 
									count_sa1 <= count_sa1 + 1;
								end 
						end

						else if (oled== 32'h3C000000) 
						begin
								if (count_sa1 == 92592)
									begin
										count_sa1 <= 0;
										sa1 <= ~sa1;
								end
								
								else
									begin 
									count_sa1 <= count_sa1 + 1;
								end 
						end
						
				else if (oled== 32'h0F000000) 
						begin
								if (count_sa1 == 83333) 
									begin
										count_sa1 <= 0;
										sa1 <= ~sa1;
								end
								
								else
									begin 
									count_sa1 <= count_sa1 + 1;
								end 
						end

				
						
						else if (oled==32'h03C00000) 
						begin
								if (count_sa1 == 78125) 
									begin
										count_sa1 <= 0;
										sa1 <= ~sa1;
								end
								
								else
									begin 
									count_sa1 <= count_sa1 + 1;
								end 
						end
						
				
						
						else if (oled==32'h00F00000) 
						begin
								if (count_sa1 == 69444 ) 
									begin
										count_sa1 <= 0;
										sa1 <= ~sa1;
								end
								
								else
									begin 
									count_sa1 <= count_sa1 + 1;
								end 
						end

						else if (oled ==32'h003C0000) 
						begin
								if (count_sa1 == 62500) 
									begin
										count_sa1 <= 0;
										sa1 <= ~sa1;
								end
								
								else
									begin 
									count_sa1 <= count_sa1 + 1;
								end 
						end

						else if (oled==32'h000F0000) 
						begin
								if (count_sa1 == 55555 ) 
									begin
										count_sa1 <= 0;
										sa1 <= ~sa1;
								end
								
								else
									begin 
									count_sa1 <= count_sa1 + 1;
								end 
						end
		////center frequency
						else if (oled==32'h0003C000) 
						begin
								if (count_sa1 == 52083) 
									begin
										count_sa1 <= 0;
										sa1 <= ~sa1;
								end
								
								else
									begin 
									count_sa1 <= count_sa1 + 1;
								end 
						end
						
						else if (oled==32'hF000) 
						begin
								if (count_sa1 == 46296) 
									begin
										count_sa1 <= 0;
										sa1 <= ~sa1;
								end
								
								else
									begin 
									count_sa1 <= count_sa1 + 1;
								end 
						end
						
						
				else if (oled==32'h3C00) 
						begin
								if (count_sa1 == 41667) 
									begin
										count_sa1 <= 0;
										sa1 <= ~sa1;
								end
								
								else
									begin 
									count_sa1 <= count_sa1 + 1;
								end 
						end
								
				else if (oled==32'h0F00) 
						begin
								if (count_sa1 == 39063) 
									begin
										count_sa1 <= 0;
										sa1 <= ~sa1;
								end
								
								else
									begin 
									count_sa1 <= count_sa1 + 1;
								end 
						end	
				else if (oled==32'h03C0) 
						begin
								if (count_sa1 == 34722) 
									begin
										count_sa1 <= 0;
										sa1 <= ~sa1;
								end
								
								else
									begin 
									count_sa1 <= count_sa1 + 1;
								end 
						end			
					
					else if (oled==32'h00F0) 
						begin
								if (count_sa1 == 31250) 
									begin
										count_sa1 <= 0;
										sa1 <= ~sa1;
								end
								
								else
									begin 
									count_sa1 <= count_sa1 + 1;
								end 
						end			
						
						else if (oled==32'h003C) 
						begin
								if (count_sa1 == 27778) 
									begin
										count_sa1 <= 0;
										sa1 <= ~sa1;
								end
								
								else
									begin 
									count_sa1 <= count_sa1 + 1;
								end 
						end			
						
						
						else if (oled==32'h000F) 
						begin
								if (count_sa1 == 26042) 
									begin
										count_sa1 <= 0;
										sa1 <= ~sa1;
								end
								
								else
									begin 
									count_sa1 <= count_sa1 + 1;
								end 
						end		
						
					
		end
endmodule
////////////////////////////


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module spipll (
	areset,
	inclk0,
	c0,
	c1);

	input	  areset;
	input	  inclk0;
	output	  c0;
	output	  c1;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0	  areset;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire [4:0] sub_wire0;
	wire [0:0] sub_wire5 = 1'h0;
	wire [0:0] sub_wire2 = sub_wire0[0:0];
	wire [1:1] sub_wire1 = sub_wire0[1:1];
	wire  c1 = sub_wire1;
	wire  c0 = sub_wire2;
	wire  sub_wire3 = inclk0;
	wire [1:0] sub_wire4 = {sub_wire5, sub_wire3};

	altpll	altpll_component (
				.areset (areset),
				.inclk (sub_wire4),
				.clk (sub_wire0),
				.activeclock (),
				.clkbad (),
				.clkena ({6{1'b1}}),
				.clkloss (),
				.clkswitch (1'b0),
				.configupdate (1'b0),
				.enable0 (),
				.enable1 (),
				.extclk (),
				.extclkena ({4{1'b1}}),
				.fbin (1'b1),
				.fbmimicbidir (),
				.fbout (),
				.fref (),
				.icdrclk (),
				.locked (),
				.pfdena (1'b1),
				.phasecounterselect ({4{1'b1}}),
				.phasedone (),
				.phasestep (1'b1),
				.phaseupdown (1'b1),
				.pllena (1'b1),
				.scanaclr (1'b0),
				.scanclk (1'b0),
				.scanclkena (1'b1),
				.scandata (1'b0),
				.scandataout (),
				.scandone (),
				.scanread (1'b0),
				.scanwrite (1'b0),
				.sclkout0 (),
				.sclkout1 (),
				.vcooverrange (),
				.vcounderrange ());
	defparam
		altpll_component.bandwidth_type = "AUTO",
		altpll_component.clk0_divide_by = 25,
		altpll_component.clk0_duty_cycle = 50,
		altpll_component.clk0_multiply_by = 1,
		altpll_component.clk0_phase_shift = "200000",
		altpll_component.clk1_divide_by = 25,
		altpll_component.clk1_duty_cycle = 50,
		altpll_component.clk1_multiply_by = 1,
		altpll_component.clk1_phase_shift = "166667",
		altpll_component.compensate_clock = "CLK0",
		altpll_component.inclk0_input_frequency = 20000,
		altpll_component.intended_device_family = "Cyclone IV E",
		altpll_component.lpm_hint = "CBX_MODULE_PREFIX=spipll",
		altpll_component.lpm_type = "altpll",
		altpll_component.operation_mode = "NORMAL",
		altpll_component.pll_type = "AUTO",
		altpll_component.port_activeclock = "PORT_UNUSED",
		altpll_component.port_areset = "PORT_USED",
		altpll_component.port_clkbad0 = "PORT_UNUSED",
		altpll_component.port_clkbad1 = "PORT_UNUSED",
		altpll_component.port_clkloss = "PORT_UNUSED",
		altpll_component.port_clkswitch = "PORT_UNUSED",
		altpll_component.port_configupdate = "PORT_UNUSED",
		altpll_component.port_fbin = "PORT_UNUSED",
		altpll_component.port_inclk0 = "PORT_USED",
		altpll_component.port_inclk1 = "PORT_UNUSED",
		altpll_component.port_locked = "PORT_UNUSED",
		altpll_component.port_pfdena = "PORT_UNUSED",
		altpll_component.port_phasecounterselect = "PORT_UNUSED",
		altpll_component.port_phasedone = "PORT_UNUSED",
		altpll_component.port_phasestep = "PORT_UNUSED",
		altpll_component.port_phaseupdown = "PORT_UNUSED",
		altpll_component.port_pllena = "PORT_UNUSED",
		altpll_component.port_scanaclr = "PORT_UNUSED",
		altpll_component.port_scanclk = "PORT_UNUSED",
		altpll_component.port_scanclkena = "PORT_UNUSED",
		altpll_component.port_scandata = "PORT_UNUSED",
		altpll_component.port_scandataout = "PORT_UNUSED",
		altpll_component.port_scandone = "PORT_UNUSED",
		altpll_component.port_scanread = "PORT_UNUSED",
		altpll_component.port_scanwrite = "PORT_UNUSED",
		altpll_component.port_clk0 = "PORT_USED",
		altpll_component.port_clk1 = "PORT_USED",
		altpll_component.port_clk2 = "PORT_UNUSED",
		altpll_component.port_clk3 = "PORT_UNUSED",
		altpll_component.port_clk4 = "PORT_UNUSED",
		altpll_component.port_clk5 = "PORT_UNUSED",
		altpll_component.port_clkena0 = "PORT_UNUSED",
		altpll_component.port_clkena1 = "PORT_UNUSED",
		altpll_component.port_clkena2 = "PORT_UNUSED",
		altpll_component.port_clkena3 = "PORT_UNUSED",
		altpll_component.port_clkena4 = "PORT_UNUSED",
		altpll_component.port_clkena5 = "PORT_UNUSED",
		altpll_component.port_extclk0 = "PORT_UNUSED",
		altpll_component.port_extclk1 = "PORT_UNUSED",
		altpll_component.port_extclk2 = "PORT_UNUSED",
		altpll_component.port_extclk3 = "PORT_UNUSED",
		altpll_component.width_clock = 5;


endmodule

module spi_ee_config (			
								iRSTN,															
								iSPI_CLK,								
								iSPI_CLK_OUT,								
								iG_INT2,
								oDATA_L,
								oDATA_H,
								SPI_SDIO,
								oSPI_CSN,
								oSPI_CLK
								);

						
			`include "spi_param.h"
				
			//=======================================================
			//  PORT declarations
			//=======================================================
			//	Host Side							
			input					          iRSTN;
			input					          iSPI_CLK, iSPI_CLK_OUT;
			input					          iG_INT2;
			output reg [SO_DataL:0] oDATA_L;
			output reg [SO_DataL:0] oDATA_H;
			//	SPI Side           
			inout					          SPI_SDIO;
			output					        oSPI_CSN;
			output					        oSPI_CLK;       
										   
			//=======================================================
			//  REG/WIRE declarations
			//=======================================================
			reg	    [3:0] 	       ini_index;
			reg		  [SI_DataL-2:0] write_data;
			reg		  [SI_DataL:0]	 p2s_data;
			reg                    spi_go;
			wire                   spi_end;
			wire	  [SO_DataL:0]	 s2p_data; 
			reg     [SO_DataL:0]	 low_byte_data;
			reg		       		       spi_state;
			reg                    high_byte; // indicate to read the high or low byte
			reg                    read_back; // indicate to read back data 
			reg                    clear_status, read_ready;
			reg     [3:0]          clear_status_d;
			reg                    high_byte_d, read_back_d;
			reg	    [IDLE_MSB:0]   read_idle_count; // reducing the reading rate

			//=======================================================
			//  Sub-module
			//=======================================================
	spi_controller u_spi_controller (		
								.iRSTN(iRSTN),
								.iSPI_CLK(iSPI_CLK),
								.iSPI_CLK_OUT(iSPI_CLK_OUT),
								.iP2S_DATA(p2s_data),
								.iSPI_GO(spi_go),
								.oSPI_END(spi_end),			
								.oS2P_DATA(s2p_data),			
								.SPI_SDIO(SPI_SDIO),
								.oSPI_CSN(oSPI_CSN),							
								.oSPI_CLK(oSPI_CLK));
								
			//=======================================================
			//  Structural coding
			//=======================================================
			// Initial Setting Table
			always @ (ini_index)
				case (ini_index)
				0      : write_data = {THRESH_ACT,8'h20};
				1      : write_data = {THRESH_INACT,8'h03};
				2      : write_data = {TIME_INACT,8'h01};
				3      : write_data = {ACT_INACT_CTL,8'h7f};
				4      : write_data = {THRESH_FF,8'h09};
				5      : write_data = {TIME_FF,8'h46};
				6      : write_data = {BW_RATE,8'h09}; // output data rate : 50 Hz
				7      : write_data = {INT_ENABLE,8'h10};	
				8      : write_data = {INT_MAP,8'h10};
				9      : write_data = {DATA_FORMAT,8'h40};
				  default: write_data = {POWER_CONTROL,8'h08};
				endcase

			always@(posedge iSPI_CLK or negedge iRSTN)
				if(!iRSTN)
				begin
					ini_index	<= 4'b0;
					spi_go		<= 1'b0;
					spi_state	<= IDLE;
					read_idle_count <= 0; // read mode only
					high_byte <= 1'b0; // read mode only
					read_back <= 1'b0; // read mode only
				clear_status <= 1'b0;
				end
				// initial setting (write mode)
				else if(ini_index < INI_NUMBER) 
					case(spi_state)
						IDLE : begin
								p2s_data  <= {WRITE_MODE, write_data};
								spi_go		<= 1'b1;
								spi_state	<= TRANSFER;
						end
						TRANSFER : begin
								if (spi_end)
								begin
							ini_index	<= ini_index + 4'b1;
									spi_go		<= 1'b0;
									spi_state	<= IDLE;							
								end
						end
					endcase
			  // read data and clear interrupt (read mode)
			  else 
					case(spi_state)
						IDLE : begin
							  read_idle_count <= read_idle_count + 1;
							
								if (high_byte) // multiple-byte read
							  begin
								  p2s_data[15:8] <= {READ_MODE, X_HB};						
								  read_back      <= 1'b1;
								end
							  else if (read_ready)
							  begin
								  p2s_data[15:8] <= {READ_MODE, X_LB};						
								  read_back      <= 1'b1;
								end
							  else if (!clear_status_d[3]&&iG_INT2 || read_idle_count[IDLE_MSB])
							  begin
								  p2s_data[15:8] <= {READ_MODE, INT_SOURCE};
								  clear_status   <= 1'b1;
					  end

					  if (high_byte || read_ready || read_idle_count[IDLE_MSB] || !clear_status_d[3]&&iG_INT2)
					  begin
								  spi_go		<= 1'b1;
								  spi_state	<= TRANSFER;
								end

							  if (read_back_d) // update the read back data
							  begin
								if (high_byte_d)
								begin
								  oDATA_H <= s2p_data;	
								  oDATA_L <= low_byte_data;			  		
								end
								else
									low_byte_data <= s2p_data;
							  end
						end
						TRANSFER : begin
								if (spi_end)
								begin
									spi_go		<= 1'b0;
									spi_state	<= IDLE;
									
									if (read_back)
									begin
										read_back <= 1'b0;
									high_byte <= !high_byte;
									read_ready <= 1'b0;					
								  end
								  else
								  begin
						  clear_status <= 1'b0;
						  read_ready <= s2p_data[6];					  	
									read_idle_count <= 0;
						end
								end
						end
					endcase
			 
			always@(posedge iSPI_CLK or negedge iRSTN)
				if(!iRSTN)
				begin
					high_byte_d <= 1'b0;
					read_back_d <= 1'b0;
					clear_status_d <= 4'b0;
				end
				else
				begin
					high_byte_d <= high_byte;
					read_back_d <= read_back;
					clear_status_d <= {clear_status_d[2:0], clear_status};
				end

endmodule					
//////////////isme Y hai obviously
module spi_ee_config_y (			
								iRSTN,															
								iSPI_CLK,								
								iSPI_CLK_OUT,								
								iG_INT2,
								oDATA_L,
								oDATA_H,
								SPI_SDIO,
								oSPI_CSN,
								oSPI_CLK);

			
`include "spi_param.h"
	
//=======================================================
//  PORT declarations
//=======================================================
//	Host Side							
input					          iRSTN;
input					          iSPI_CLK, iSPI_CLK_OUT;
input					          iG_INT2;
output reg [SO_DataL:0] oDATA_L;
output reg [SO_DataL:0] oDATA_H;
//	SPI Side           
inout					          SPI_SDIO;
output					        oSPI_CSN;
output					        oSPI_CLK;       
                               
//=======================================================
//  REG/WIRE declarations
//=======================================================
reg	    [3:0] 	       ini_index;
reg		  [SI_DataL-2:0] write_data;
reg		  [SI_DataL:0]	 p2s_data;
reg                    spi_go;
wire                   spi_end;
wire	  [SO_DataL:0]	 s2p_data; 
reg     [SO_DataL:0]	 low_byte_data;
reg		       		       spi_state;
reg                    high_byte; // indicate to read the high or low byte
reg                    read_back; // indicate to read back data 
reg                    clear_status, read_ready;
reg     [3:0]          clear_status_d;
reg                    high_byte_d, read_back_d;
reg	    [IDLE_MSB:0]   read_idle_count; // reducing the reading rate

//=======================================================
//  Sub-module
//=======================================================
spi_controller u_spi_controller (		
							.iRSTN(iRSTN),
							.iSPI_CLK(iSPI_CLK),
							.iSPI_CLK_OUT(iSPI_CLK_OUT),
							.iP2S_DATA(p2s_data),
							.iSPI_GO(spi_go),
							.oSPI_END(spi_end),			
							.oS2P_DATA(s2p_data),			
							.SPI_SDIO(SPI_SDIO),
							.oSPI_CSN(oSPI_CSN),							
							.oSPI_CLK(oSPI_CLK));
							
//=======================================================
//  Structural coding
//=======================================================
// Initial Setting Table
always @ (ini_index)
	case (ini_index)
    0      : write_data = {THRESH_ACT,8'h20};
    1      : write_data = {THRESH_INACT,8'h03};
    2      : write_data = {TIME_INACT,8'h01};
    3      : write_data = {ACT_INACT_CTL,8'h7f};
    4      : write_data = {THRESH_FF,8'h09};
    5      : write_data = {TIME_FF,8'h46};
    6      : write_data = {BW_RATE,8'h09}; // output data rate : 50 Hz
    7      : write_data = {INT_ENABLE,8'h10};	
    8      : write_data = {INT_MAP,8'h10};
    9      : write_data = {DATA_FORMAT,8'h40};
	  default: write_data = {POWER_CONTROL,8'h08};
	endcase

always@(posedge iSPI_CLK or negedge iRSTN)
	if(!iRSTN)
	begin
		ini_index	<= 4'b0;
		spi_go		<= 1'b0;
		spi_state	<= IDLE;
		read_idle_count <= 0; // read mode only
		high_byte <= 1'b0; // read mode only
		read_back <= 1'b0; // read mode only
    clear_status <= 1'b0;
	end
	// initial setting (write mode)
	else if(ini_index < INI_NUMBER) 
		case(spi_state)
			IDLE : begin
					p2s_data  <= {WRITE_MODE, write_data};
					spi_go		<= 1'b1;
					spi_state	<= TRANSFER;
			end
			TRANSFER : begin
					if (spi_end)
					begin
		        ini_index	<= ini_index + 4'b1;
						spi_go		<= 1'b0;
						spi_state	<= IDLE;							
					end
			end
		endcase
  // read data and clear interrupt (read mode)
  else 
		case(spi_state)
			IDLE : begin
				  read_idle_count <= read_idle_count + 1;
				
					if (high_byte) // multiple-byte read
				  begin
					  p2s_data[15:8] <= {READ_MODE, Y_HB};						
					  read_back      <= 1'b1;
					end
				  else if (read_ready)
				  begin
					  p2s_data[15:8] <= {READ_MODE, Y_LB};						
					  read_back      <= 1'b1;
					end
				  else if (!clear_status_d[3]&&iG_INT2 || read_idle_count[IDLE_MSB])
				  begin
					  p2s_data[15:8] <= {READ_MODE, INT_SOURCE};
					  clear_status   <= 1'b1;
          end

          if (high_byte || read_ready || read_idle_count[IDLE_MSB] || !clear_status_d[3]&&iG_INT2)
          begin
					  spi_go		<= 1'b1;
					  spi_state	<= TRANSFER;
					end

				  if (read_back_d) // update the read back data
				  begin
				  	if (high_byte_d)
				  	begin
				  	  oDATA_H <= s2p_data;	
				  	  oDATA_L <= low_byte_data;			  		
				  	end
				  	else
				  		low_byte_data <= s2p_data;
				  end
			end
			TRANSFER : begin
					if (spi_end)
					begin
						spi_go		<= 1'b0;
						spi_state	<= IDLE;
						
						if (read_back)
						begin
							read_back <= 1'b0;
					    high_byte <= !high_byte;
					    read_ready <= 1'b0;					
					  end
					  else
					  begin
              clear_status <= 1'b0;
              read_ready <= s2p_data[6];					  	
					    read_idle_count <= 0;
            end
					end
			end
		endcase
 
always@(posedge iSPI_CLK or negedge iRSTN)
	if(!iRSTN)
	begin
		high_byte_d <= 1'b0;
		read_back_d <= 1'b0;
		clear_status_d <= 4'b0;
	end
	else
	begin
		high_byte_d <= high_byte;
		read_back_d <= read_back;
		clear_status_d <= {clear_status_d[2:0], clear_status};
	end

endmodule					


module spi_controller (		
							iRSTN,
							iSPI_CLK,
							iSPI_CLK_OUT,
							iP2S_DATA,
							iSPI_GO,
							oSPI_END,					
							oS2P_DATA,							
							SPI_SDIO,
							oSPI_CSN,							
							oSPI_CLK);
	
`include "spi_param.h"	

//=======================================================
//  PORT declarations
//=======================================================
//	Host Side
input				              iRSTN;
input				              iSPI_CLK;
input				              iSPI_CLK_OUT;
input	      [SI_DataL:0]  iP2S_DATA; 
input	      			        iSPI_GO;
output	  			          oSPI_END;
output	reg [SO_DataL:0]	oS2P_DATA;
//	SPI Side              
inout				              SPI_SDIO;
output	   			          oSPI_CSN;
output				            oSPI_CLK;

//=======================================================
//  REG/WIRE declarations
//=======================================================
wire          read_mode, write_address;
reg           spi_count_en;
reg  	[3:0]		spi_count;

//=======================================================
//  Structural coding
//=======================================================
assign read_mode = iP2S_DATA[SI_DataL];
assign write_address = spi_count[3];
assign oSPI_END = ~|spi_count;
assign oSPI_CSN = ~iSPI_GO;
assign oSPI_CLK = spi_count_en ? iSPI_CLK_OUT : 1'b1;
assign SPI_SDIO = spi_count_en && (!read_mode || write_address) ? iP2S_DATA[spi_count] : 1'bz;

always @ (posedge iSPI_CLK or negedge iRSTN) 
	if (!iRSTN)
	begin
		spi_count_en <= 1'b0;
		spi_count <= 4'hf;
	end
	else 
	begin
		if (oSPI_END)
			spi_count_en <= 1'b0;
		else if (iSPI_GO)
			spi_count_en <= 1'b1;
			
		if (!spi_count_en)	
  		spi_count <= 4'hf;		
		else
			spi_count	<= spi_count - 4'b1;

    if (read_mode && !write_address)
		  oS2P_DATA <= {oS2P_DATA[SO_DataL-1:0], SPI_SDIO};
	end

endmodule

