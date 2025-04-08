----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2016/10/25 14:57:57
-- Design Name: 
-- Module Name: radiation_detect14bit_1024 - Behavioral
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
Library XilinxCoreLib;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use UNISIM.VComponents.all;

entity PSD_Divider is
port(
	clk: in std_logic;
	rst: in std_logic;
	acq_start: IN std_logic;	

	data_in_Prompt: in std_logic_vector(17 downto 0);
	data_in_Delayed: in std_logic_vector(17 downto 0);
	data_in_rdy : in std_logic;
	
	data_Temp : in std_logic_vector(15 downto 0);
	temp_ack : in std_logic;	
	Compare_rdy : in std_logic;
	PSD_Factor : out std_logic_vector(7 downto 0);
	data_out_rdy : out std_logic
	);	
end PSD_Divider;

architecture Behavioral of PSD_Divider is


Component floating_point_5 IS -- divider
  PORT (
    aclk : IN STD_LOGIC;
    aclken : IN STD_LOGIC;
    s_axis_a_tvalid : IN STD_LOGIC;

    s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_b_tvalid : IN STD_LOGIC;

    s_axis_b_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_result_tvalid : OUT STD_LOGIC;
    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
end Component;


Component floating_point_6 IS -- comparator
  PORT (
    aclk : IN STD_LOGIC;
    aclken : IN STD_LOGIC;
    s_axis_a_tvalid : IN STD_LOGIC;
 
    s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_b_tvalid : IN STD_LOGIC;
   
    s_axis_b_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_result_tvalid : OUT STD_LOGIC;
    
    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
end Component;

COMPONENT floating_point_0 -- fixed to float
  PORT (
    aclk : IN STD_LOGIC;
    aclken : IN STD_LOGIC;
    s_axis_a_tvalid : IN STD_LOGIC;
    s_axis_a_tdata : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    m_axis_result_tvalid : OUT STD_LOGIC;
    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

COMPONENT floating_point_1st_Order -- ax + b
   PORT (
    aclk : IN STD_LOGIC;
    aclken : IN STD_LOGIC;
    s_axis_a_tvalid : IN STD_LOGIC;
    s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_b_tvalid : IN STD_LOGIC;
    s_axis_b_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_c_tvalid : IN STD_LOGIC;
    s_axis_c_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_result_tvalid : OUT STD_LOGIC;
    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;



--signal Ch_Compare : STD_LOGIC_VECTOR ( 31 downto 0 ):=X"3fff4dd9"; --0.8041 @ 25 C
--signal Ch_Compare : STD_LOGIC_VECTOR ( 31 downto 0 ):=X"3fff50C4"; --0.8255 @ 25 C
--signal Ch_Compare : STD_LOGIC_VECTOR ( 31 downto 0 ):=X"3fff55e3"; --0.8355 @ 25 C
--signal Ch_Compare : STD_LOGIC_VECTOR ( 31 downto 0 ):=X"3fff5844"; --0.8445 @ 25 C
--signal Ch_Compare : STD_LOGIC_VECTOR ( 31 downto 0 ):=X"3fff5aa6"; --0.8541 @ 25 C

--signal Ch_Compare : STD_LOGIC_VECTOR ( 31 downto 0 ):=X"3fff5C28"; --0.8600 @ 25 C
--signal Ch_Compare : STD_LOGIC_VECTOR ( 31 downto 0 ):=X"3fff5d91"; --0.8655 @ 25 C
--signal Ch_Compare : STD_LOGIC_VECTOR ( 31 downto 0 ):=X"3fff5eb8"; --0.8700 @ 25 C
--signal Ch_Compare : STD_LOGIC_VECTOR ( 31 downto 0 ):=X"3fff6020"; --0.8755 @ 25 C
--signal Ch_Compare : STD_LOGIC_VECTOR ( 31 downto 0 ):=X"3fff62b0"; --0.8855 @ 25 C
--signal Ch_Compare : STD_LOGIC_VECTOR ( 31 downto 0 ):=X"3fff653f"; --0.8955 @ 25 C

--signal Ch_Compare : STD_LOGIC_VECTOR ( 31 downto 0 ):=X"3fff5dd6"; --0.8541 @ 25 C
--signal Ch_Compare : STD_LOGIC_VECTOR ( 31 downto 0 ):=X"3fff45A1"; --0.7600 @ 25 C
--signal Ch_Compare : STD_LOGIC_VECTOR ( 31 downto 0 ):=X"3fff410c"; --0.7541 @ 25 C
--signal Ch_Compare : STD_LOGIC_VECTOR ( 31 downto 0 ):=X"3fff3E7C"; --0.74xx @ 25 C
--signal Ch_Compare : STD_LOGIC_VECTOR ( 31 downto 0 ):=X"3fff3bed"; --0.7341 @ 25 C
--signal Ch_Compare : STD_LOGIC_VECTOR ( 31 downto 0 ):=X"3fff343f"; --0.7041 @ 25 C --Gammar Â©¸²
--signal Ch_Compare : STD_LOGIC_VECTOR ( 31 downto 0 ):=X"3fff4ba5"; --0.7995 @ 25 C

--signal Ch_Compare : STD_LOGIC_VECTOR ( 31 downto 0 ):=X"3fff46e9"; --0.7770 @ 25 C
signal Ch_Compare : STD_LOGIC_VECTOR ( 31 downto 0 ):=X"3fff445a"; --0.7670 @ 25 C
--signal Ch_Compare : STD_LOGIC_VECTOR ( 31 downto 0 ):=X"3fff410c"; --0.7541 @ 25 C

signal dout_Out_Divide:  std_logic_vector(31 downto 0);
signal Ch_fixed : STD_LOGIC_VECTOR ( 23 downto 0 );
signal ch_Temp : STD_LOGIC_VECTOR ( 23 downto 0 ); 
signal  Ch_float: STD_LOGIC_VECTOR ( 31 downto 0 );
signal Ch_fixed_2 : STD_LOGIC_VECTOR ( 23 downto 0 );
signal  Ch_float_2: STD_LOGIC_VECTOR ( 31 downto 0 );

signal PSD_A: STD_LOGIC_VECTOR ( 31 downto 0 );
signal PSD_B: STD_LOGIC_VECTOR ( 31 downto 0 );

signal PSD_Temp : STD_LOGIC_VECTOR ( 31 downto 0 );

signal Ch_float2fixed : STD_LOGIC_VECTOR ( 15 downto 0 );

signal temp : std_logic_vector(12 - 1 downto 0);

signal data_in_Prompt_1d:  std_logic_vector(17 downto 0);
signal data_in_Delayed_1d:  std_logic_vector(17 downto 0);

signal data_in_Prompt_2d:  std_logic_vector(17 downto 0);
signal data_in_Delayed_2d:  std_logic_vector(17 downto 0);
signal temp_result_valid : std_logic:= '0';
signal acq_start_1d : std_logic;
signal acq_start_2d : std_logic;
signal data_Temp_1d : std_logic_vector(16 - 1 downto 0);
signal data_Temp_2d : std_logic_vector(16 - 1 downto 0);

begin
process(clk)-- metastable remove
begin    
    if(rising_edge(clk)) then
        acq_start_1d <= acq_start;
        acq_start_2d <= acq_start_1d;
    end if;    
end process;

process(clk,acq_start_2d)-- metastable remove
begin
    if(acq_start_2d = '0')then
        data_in_Prompt_1d  <=   (others => '0');
        data_in_Delayed_1d <=   (others => '0');
        data_in_Prompt_2d  <=   (others => '0');
        data_in_Delayed_2d <=   (others => '0');
 
    else
        data_in_Prompt_1d <= data_in_Prompt;
        data_in_Delayed_1d <= data_in_Delayed;
        
        data_in_Prompt_2d <= data_in_Prompt_1d;
        data_in_Delayed_2d <= data_in_Delayed_1d;

    end if;    
end process;
--Ch_Compare<=  X"3fff8000";
--Ch_Compare<=  X"3ffec7ae"; -- 0.39
--Ch_Compare<=  X"3ffecccd"; -- 0.40
--Ch_Compare<=  X"3ffebb64"; -- 0.366

--Ch_Compare<=  X"3ffeb333"; -- 0.315


--PSD_A<=X"bff925fd"; -- -0.0001583 -- old
--PSD_B<=X"3fff202a"; -- 0.62564896 --old

--PSD_A<=X"bff91642"; -- -0.0001583
--PSD_B<=X"3fff148e"; -- 0.62564896

--PSD_A<=X"bff87ba8"; -- -0.00006
--PSD_B<=X"3fff66a1"; -- 0.9009





Ch_fixed<="00000000"&data_in_Prompt_2d(16 downto 1);
Ch_fixed_2<="00000000"&data_in_Delayed_2d(16 downto 1);


ch_Temp<="000000000000"&temp;
process(clk)
begin
    if(rising_edge(clk))then
        if( data_Temp_2d(15 downto 4) <= X"54B" ) then
            temp <= X"54B"; -- 1355
        else
            temp <= data_Temp_2d(15 downto 4);
        end if;    
    end if;
end process;

process(acq_start_2d,clk)
begin
    if(acq_start_2d = '0') then
        data_Temp_1d <= (others => '0');
        data_Temp_2d <= (others => '0');        
    elsif(rising_edge(clk))then
        data_Temp_1d <= data_Temp;
        data_Temp_2d <= data_Temp_1d;
    end if;
end process;



i_floating_point_5 : floating_point_5 
port map(  
    aclk  => clk,
    aclken => acq_start,
    s_axis_a_tvalid =>  data_in_rdy,

    s_axis_a_tdata =>Ch_float,
    s_axis_b_tvalid =>data_in_rdy ,

    s_axis_b_tdata =>Ch_float_2,
    m_axis_result_tvalid =>open,
    m_axis_result_tdata => dout_Out_Divide);

i_floating_point_6 : floating_point_6 
port map(  
    aclk  => clk,
    aclken => acq_start,
    s_axis_a_tvalid =>  Compare_rdy,

    s_axis_a_tdata =>dout_Out_Divide,
    s_axis_b_tvalid =>Compare_rdy ,

    s_axis_b_tdata => Ch_Compare,
    m_axis_result_tvalid => data_out_rdy,
  
    m_axis_result_tdata => PSD_Factor);
i_floating_point_2 : floating_point_0
  PORT MAP (
    aclk  => clk,
    aclken => acq_start,
    s_axis_a_tvalid =>  Compare_rdy,
    s_axis_a_tdata => Ch_fixed,
    m_axis_result_tvalid => open,
    m_axis_result_tdata => Ch_float
  );

i_floating_point_4 : floating_point_0
  PORT MAP (
    aclk  => clk,
    aclken => acq_start,
    s_axis_a_tvalid =>  Compare_rdy,
    s_axis_a_tdata => Ch_fixed_2,
    m_axis_result_tvalid => open,
    m_axis_result_tdata => Ch_float_2
  );

i_floating_point_Temp : floating_point_0
  PORT MAP (
    aclk  => clk,
    aclken => acq_start,
    s_axis_a_tvalid =>  Compare_rdy,
    s_axis_a_tdata => ch_Temp,
    m_axis_result_tvalid => temp_result_valid,
    m_axis_result_tdata => PSD_Temp
  );


----PSD_A<=X"bff85516"; -- -0.00006143
--PSD_B<=X"3fff6c64"; -- 0.84592531


PSD_A<=X"bff85897"; -- -0.0000538538

PSD_B<=X"3fff5aa0";
--PSD_B<=X"3fff5969"; --  
--PSD_B<=X"3fff58a5"; --  0.8593208954
i_floating_point_1st_Order_PSD :floating_point_1st_Order -- ax + b
  PORT MAP (
    aclk => clk,
    aclken  => temp_result_valid,
    s_axis_a_tvalid =>  temp_result_valid,
    s_axis_a_tdata => PSD_A,
    s_axis_b_tvalid =>  temp_result_valid,
    s_axis_b_tdata => PSD_temp,
    s_axis_c_tvalid =>  temp_result_valid,
    s_axis_c_tdata => PSD_B,
    m_axis_result_tvalid  => open,
    m_axis_result_tdata =>Ch_Compare
  );




end Behavioral;
