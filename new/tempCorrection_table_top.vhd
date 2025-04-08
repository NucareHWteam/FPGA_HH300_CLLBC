----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2024/07/18 10:18:40
-- Design Name: 
-- Module Name: tempCorrection_table_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
--Library XilinxCoreLib;
--library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library UNISIM;
	use UNISIM.vcomponents.all;
library xil_defaultlib;
    use xil_defaultlib.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tempCorrection_table_top is
 Port (
        rst : in std_logic;
        clk : in std_logic;    
        acq_start : in std_logic;
        Ch_temp_t1 : in STD_LOGIC_VECTOR ( 16-1 downto 0 );
        Ch_temp_t2 : in STD_LOGIC_VECTOR ( 16-1 downto 0 );
        K40_Pre_GC : in std_logic_vector(16 -1 downto 0);
        GC_Cal_out : out std_logic_vector( 16 - 1 downto 0);  -- calculation out
        t1_done : inout std_logic;
        Compare_rdy : in std_logic);
  
end tempCorrection_table_top;

architecture Behavioral of tempCorrection_table_top is
signal k40_1 : std_logic_vector(16 - 1 downto 0);
signal k40_2 :  std_logic_vector(16 - 1 downto 0);
signal addra : STD_LOGIC_VECTOR(11 DOWNTO 0);
signal GC_change_en : STD_LOGIC;
Component Temp_k40_location is
 Port (
        rst : in std_logic;
        clk : in std_logic;    
        acq_start : in std_logic;
--        addra : in STD_LOGIC_VECTOR(11 DOWNTO 0);
        Ch_temp_t1 : in STD_LOGIC_VECTOR ( 16-1 downto 0 );
        Ch_temp_t2 : in STD_LOGIC_VECTOR ( 16-1 downto 0 );
        k40_1 : out std_logic_vector( 16 - 1 downto 0);
        k40_2 : out std_logic_vector( 16 - 1 downto 0);
        GC_change_en : out std_logic:= '0';
        t1_done :inout std_logic;
        Compare_rdy : in std_logic);
  
end Component;

Component Temp_Gctable is
  Port  (
        clk : in std_logic;    
        acq_start : in std_logic;
        K40_Pre_GC : in std_logic_vector(16 -1 downto 0);
        Ch_662Kev_read : in std_logic_vector( 16 - 1 downto 0);
        Cs1_ch :  in std_logic_vector( 16 - 1 downto 0);
        Cs2_ch : in std_logic_vector( 16 - 1 downto 0);
--        cl_wr_en_pipe : in std_logic_vector(1 downto 0);
--        gc_a : in std_logic_vector(32 - 1 downto 0);
--        gc_b : in std_logic_vector(32 - 1 downto 0);
--        gc_change_en : in std_logic;
        GC_Cal_out : out std_logic_vector(16 - 1 downto 0);
        Compare_rdy : in std_logic);
end Component;

Component Temp_correction is
 Port (
        rst : in std_logic;
        clk : in std_logic;    
        acq_start : in std_logic;
       
        k40_1 : in STD_LOGIC_VECTOR ( 16-1 downto 0 );
        k40_2 : in STD_LOGIC_VECTOR ( 16-1 downto 0 );
        K40_Pre_GC : in std_logic_vector(16 -1 downto 0);
        GC_Cal_out : out std_logic_vector( 16 - 1 downto 0);
        GC_change_en : in std_logic;
        Compare_rdy : in std_logic);
  
end Component;

begin
inst_Temp_k40_location:Temp_k40_location 
 Port map(
        rst         =>  rst,
        clk         =>  clk, 
        acq_start   =>  acq_start,
--        addra       =>  addra,
        Ch_temp_t1  =>  Ch_temp_t1,
        Ch_temp_t2  =>  Ch_temp_t2,
        k40_1       =>  k40_1,
        k40_2       =>  k40_2,
        t1_done => t1_done,
        GC_change_en => GC_change_en,
        Compare_rdy => Compare_rdy);
  
-- inst_Temp_correction : Temp_correction 
-- Port map(
--        rst  => rst,
--        clk  => clk,   
--        acq_start => acq_start,
--        k40_1 => k40_1,
--        k40_2 => k40_2,
--        K40_Pre_GC => K40_Pre_GC,
--        GC_change_en => GC_change_en,
--        GC_Cal_out => GC_Cal_out,
--        Compare_rdy => Compare_rdy);


inst_Temp_Gctable : Temp_Gctable
  Port  map(
        clk => clk,   
        acq_start => t1_done,
        Cs1_ch => k40_1,
        Cs2_ch => k40_2,
--        cl_wr_en_pipe => cl_wr_en_pipe,
        Ch_662Kev_read => k40_1,
        K40_Pre_GC => K40_Pre_GC,
        GC_Cal_out => GC_Cal_out,

        Compare_rdy => Compare_rdy);



end Behavioral;
