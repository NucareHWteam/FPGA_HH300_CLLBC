-------------------------------------------------------------------------------
--    
--    Company:          Xilinx
--    Engineer:         Jim Tatsukawa
--    Date:             2/10/2014
--    Design Name:      ug480
--    Module Name:      ug480.vhd
--    Version:          2.1 - Changed read_reg06 DADDR="0000110"
--                      2.0 - Initial self contained design
--    Target Devices:   7 Series Family
--    Tool versions:    2014.1
--    Description:      This is a basic demonstration of the XADC
-- 
--    Disclaimer:  XILINX IS PROVIDING THIS DESIGN, CODE, OR
--                 INFORMATION "AS IS" SOLELY FOR USE IN DEVELOPING
--                 PROGRAMS AND SOLUTIONS FOR XILINX DEVICES.  BY
--                 PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
--                 ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,
--                 APPLICATION OR STANDARD, XILINX IS MAKING NO
--                 REPRESENTATION THAT THIS IMPLEMENTATION IS FREE
--                 FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE
--                 RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY
--                 REQUIRE FOR YOUR IMPLEMENTATION.  XILINX
--                 EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH
--                 RESPECT TO THE ADEQUACY OF THE IMPLEMENTATION,
--                 INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
--                 REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
--                 FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES
--                 OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
--                 PURPOSE.
 
--                 (c) Copyright 2013-2014 Xilinx, Inc.
--                 All rights reserved.
 
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
Library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity ug480 is
   port
   (
    DCLK               : in  STD_LOGIC;                         -- Clock input for the dynamic reconfiguration port
    RESET              : in  STD_LOGIC;                         -- Reset signal for the System Monitor control logic
    VAUXP, VAUXN       : in  STD_LOGIC_VECTOR (3 downto 0);    -- Input data bus for the dynamic reconfiguration port
    VP, VN             : in  STD_LOGIC;                         -- Clock input for the dynamic reconfiguration port

    MEASURED_TEMP      : out  STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
    MEASURED_VCCAUX    : out  STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
    MEASURED_VCCINT    : out  STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
    MEASURED_VCCBRAM   : out  STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
    MEASURED_AUX0      : out  STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
    MEASURED_AUX1      : out  STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
    MEASURED_AUX2      : out  STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
    MEASURED_AUX3      : out  STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port

    ALM                : out  STD_LOGIC_VECTOR (7 downto 0);   -- Output data bus for dynamic reconfiguration port
    CHANNEL            : out  STD_LOGIC_VECTOR (4 downto 0);   -- Output data bus for dynamic reconfiguration port
    OT                 : out  STD_LOGIC;   -- Output data bus for dynamic reconfiguration port
    EOC         : out  STD_LOGIC;   -- Output data bus for dynamic reconfiguration port
    EOS         : out  STD_LOGIC   -- Output data bus for dynamic reconfiguration port
);
end entity ug480;


architecture rtl of ug480 is

  signal FLOAT_VBRAM_ALARM : STD_LOGIC;
  signal FLOAT_MUXADDR   : STD_LOGIC_VECTOR (4 downto 0);
  signal den_reg, dwe_reg: STD_LOGIC_VECTOR (1 downto 0);
  signal vauxp_active    : STD_LOGIC_VECTOR (15 downto 0);
  signal vauxn_active    : STD_LOGIC_VECTOR (15 downto 0);
  signal daddr           : STD_LOGIC_VECTOR (6 downto 0);     -- Address bus for the dynamic reconfiguration port
  signal den             : STD_LOGIC;                         -- Enable Signal for the dynamic reconfiguration port
  signal di_drp              : STD_LOGIC_VECTOR (15 downto 0);    -- Input data bus for the dynamic reconfiguration port
  signal dwe             : STD_LOGIC;                         -- Write Enable for the dynamic reconfiguration port
  signal do_drp             : STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
  signal drdy            : STD_LOGIC;                        -- Data ready signal for the dynamic reconfiguration port
  signal eoc_drp         : STD_LOGIC;
  signal eos_drp         : STD_LOGIC;
  signal busy            : STD_LOGIC;                        -- ADC Busy signal
  signal dclk_bufg       : STD_LOGIC;
  type state_type is (init_read, read_waitdrdy,
                    write_waitdrdy,
                    read_reg00,
                    reg00_waitdrdy,
                    read_reg01,
                    reg01_waitdrdy,
                    read_reg02,
                    reg02_waitdrdy,
                    read_reg06,
                    reg06_waitdrdy,
                    read_reg10,
                    reg10_waitdrdy,
                    read_reg11,
                    reg11_waitdrdy,
                    read_reg12,
                    reg12_waitdrdy,
                    read_reg13,
                    reg13_waitdrdy  ); 

  signal state, next_state : state_type; 
attribute mark_debug : string;
attribute keep : string;
attribute mark_debug of MEASURED_TEMP : signal is "true";
attribute mark_debug of MEASURED_VCCINT : signal is "true";
attribute mark_debug of MEASURED_VCCAUX : signal is "true";
attribute mark_debug of MEASURED_VCCBRAM : signal is "true";
attribute mark_debug of MEASURED_AUX0 : signal is "true";
attribute mark_debug of MEASURED_AUX1 : signal is "true";
attribute mark_debug of MEASURED_AUX2 : signal is "true";
attribute mark_debug of MEASURED_AUX3 : signal is "true";
 	  	 	 	 	 
begin
 U_BUFG : BUFG
     port map(
     I => DCLK,
	  O => dclk_bufg);



 U0 : XADC
     generic map(
      INIT_40 => X"3000", -- config reg 0
        INIT_41 => X"21A0", -- config reg 1
        INIT_42 => X"0200", -- config reg 2
        INIT_48 => X"4781", -- Sequencer channel selection
        INIT_49 => X"000F", -- Sequencer channel selection
        INIT_4A => X"4700", -- Sequencer Average selection
        INIT_4B => X"000F", -- Sequencer Average selection
        INIT_4C => X"0000", -- Sequencer Bipolar selection
        INIT_4D => X"0000", -- Sequencer Bipolar selection
        INIT_4E => X"0000", -- Sequencer Acq time selection
        INIT_4F => X"0000", -- Sequencer Acq time selection
        INIT_50 => X"B5ED", -- Temp alarm trigger
        INIT_51 => X"57E4", -- Vccint upper alarm limit
        INIT_52 => X"A147", -- Vccaux upper alarm limit
        INIT_53 => X"CA33",  -- Temp alarm OT upper
        INIT_54 => X"A93A", -- Temp alarm reset
        INIT_55 => X"52C6", -- Vccint lower alarm limit
        INIT_56 => X"9555", -- Vccaux lower alarm limit
        INIT_57 => X"AE4E",  -- Temp alarm OT reset
        INIT_58 => X"5999",  -- Vccbram upper alarm limit
        INIT_5C => X"5111",  -- Vccbram lower alarm limit
        SIM_DEVICE => "7SERIES",
        SIM_MONITOR_FILE => "G:\kihun_3\FPGA\Artix7\HH300_SPI_UART_XADC_Test\design.txt"
        )




port map (
        CONVST              => '0',
        CONVSTCLK           => '0',
        DADDR               => daddr,
        DCLK                => dclk_bufg,
        DEN                 => den_reg(0),
        DI(15 downto 0)     => di_drp,
        DWE                 => dwe_reg(0),
        RESET               => RESET,
        VAUXN(15 downto 0)  => vauxn_active ,
        VAUXP(15 downto 0)  => vauxp_active ,
        ALM                 => ALM,
        BUSY                => busy,
        CHANNEL             => CHANNEL,
        DO(15 downto 0)     => do_drp,
        DRDY                => drdy,
        EOC                 => eoc_drp,
        EOS                 => eos_drp,
        JTAGBUSY            => open,
        JTAGLOCKED          => open,
        JTAGMODIFIED        => open,
        OT                  => OT,
        MUXADDR             => open,
        VN                  => VP,
        VP                  => VN
      );
       vauxp_active <= "000000000000" & VAUXP(3 downto 0) ;
       vauxn_active <= "000000000000" & VAUXN(3 downto 0) ;
       EOC <= eoc_drp;
       EOS <= eos_drp;


	NEXT_STATE_DECODE: process (dclk_bufg, RESET)
	begin
		if (RESET = '1') then
					 state <= init_read;	
		elsif (dclk_bufg'event and dclk_bufg = '1') then
			 case (state) is
				 when init_read =>
					 daddr       <= "1000000";
					 den_reg     <= "10";
					 dwe_reg     <= "00"; -- performing read
					 state <= read_waitdrdy;
				 when read_waitdrdy =>
					 if eos_drp = '1' then
						 state <= write_waitdrdy;
						 di_drp  <= do_drp  AND "0000001111111111"; --Clearing AVG bits for Configreg0
						 daddr   <= "1000000";
						 den_reg <= "10";
						 dwe_reg <= "10"; -- performing write
					 else
						 state <= read_waitdrdy;
						 den_reg <= "0" & den_reg(1) ;
						 dwe_reg <= "0" & dwe_reg(1) ;
					 end if;
				 when write_waitdrdy =>
					 if drdy = '1' then
						 state <= read_reg00;
						 den_reg <= den_reg;
						 dwe_reg <= dwe_reg; --performing write
					 else
						 den_reg <= "0" & den_reg(1) ;
						 dwe_reg <= "0" & dwe_reg(1) ;
						 state <= write_waitdrdy;
					 end if;
				 when read_reg00 =>
						 daddr       <= "0000000";
						 den_reg     <= "10";
						 state <= reg00_waitdrdy;
				 when reg00_waitdrdy =>
					if eos_drp = '1' then
						 MEASURED_TEMP <= do_drp;
						 den_reg <= den_reg;
						 dwe_reg <= dwe_reg;
						 state <= read_reg01;
					else
						 den_reg <= "0" & den_reg(1) ;
						 dwe_reg <= "0" & dwe_reg(1) ;
						 state <= reg00_waitdrdy;
					end if;
				 when read_reg01 =>
					 daddr       <= "0000001";
					 den_reg     <= "10";
					 state <= reg01_waitdrdy;
				 when reg01_waitdrdy =>
					 if drdy = '1' then
						 MEASURED_VCCINT <= do_drp;
						 den_reg <= den_reg;
						 state <= read_reg02;
					else
						 den_reg <= "0" & den_reg(1) ;
						 state <= reg01_waitdrdy ;
					 end if;
				 when read_reg02 =>
						 daddr       <= "0000010";
						 den_reg     <= "10";
						 state <= reg02_waitdrdy;
				 when reg02_waitdrdy =>
					if drdy = '1' then
						 state <= read_reg06;
						 MEASURED_VCCAUX <= do_drp;
						 den_reg <= den_reg;
					else
						 state <= reg02_waitdrdy ;
						 den_reg <= "0" & den_reg(1) ;
					 end if;
				 when read_reg06 =>
					 daddr       <= "0000110";
					 den_reg     <= "10";
					 state <= reg06_waitdrdy;
				 when reg06_waitdrdy =>
					 if drdy = '1' then
						 state <= read_reg10;
						 MEASURED_VCCBRAM <= do_drp;
						 den_reg <= den_reg;
					 else
						 den_reg <= "0" & den_reg(1) ;
						 state <= reg06_waitdrdy ;
					 end if;
				 when read_reg10 =>
					 daddr       <= "0010000";
					 den_reg     <= "10";
					 state <= reg10_waitdrdy;
				 when reg10_waitdrdy =>
					 if drdy = '1' then
						 MEASURED_AUX0 <= do_drp;
						 den_reg <= den_reg;
						 state <= read_reg11;
					else
						 den_reg <= "0" & den_reg(1) ;
						 state <= reg10_waitdrdy ;
					 end if;
				 when read_reg11 =>
					 daddr       <= "0010001";
					 den_reg     <= "10";
					 state <= reg11_waitdrdy;
				 when reg11_waitdrdy =>
					 if drdy = '1' then
						 MEASURED_AUX1 <= do_drp;
						 den_reg <= den_reg;
						 state <= read_reg12;
					 else
						 state <= reg11_waitdrdy ;
						 den_reg <= "0" & den_reg(1) ;
					 end if;
				 when read_reg12 =>
						 daddr       <= "0010010";
						 den_reg     <= "10";
						 state <= reg12_waitdrdy;
				 when reg12_waitdrdy =>
					 if drdy = '1' then
						 MEASURED_AUX2 <= do_drp;
						 den_reg <= den_reg;
						 state <= read_reg13;
					else
						 den_reg <= "0" & den_reg(1) ;
						 state <= reg12_waitdrdy ;
					 end if;
				 when read_reg13 =>
					 daddr       <= "0010011";
					 den_reg     <= "10";
					 state <= reg13_waitdrdy;
				 when reg13_waitdrdy =>
					 if drdy = '1' then
						 state <= read_reg00;
						 MEASURED_AUX3 <= do_drp;
						 den_reg <= den_reg;
					 else
						 state <= reg13_waitdrdy ;
						 den_reg <= "0" & den_reg(1) ;
					 end if;
				 when others =>
					 state <= init_read ;
			 end case;      
		end if;
	end process;


end rtl;


