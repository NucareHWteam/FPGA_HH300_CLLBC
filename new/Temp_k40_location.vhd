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
-- DV2
----------------------------------------------------------------------------------


library IEEE;
--Library XilinxCoreLib;
--library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use std.textio.all;

library UNISIM;
	use UNISIM.vcomponents.all;
--library xil_defaultlib;
--    use xil_defaultlib.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Temp_k40_location is
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
        t1_done : inout  std_logic;

        Compare_rdy : in std_logic);

end Temp_k40_location;

architecture Behavioral of Temp_k40_location is

--signal ram : memory_array := file_open(filename => "../RAM.HEX");
--file file_pointer : text;
--signal line_content : integer;
--signal line_num : integer;
--signal j : integer := 0;
--type line2 is array(0 to 4095) of integer range 0 to 2047;
----type line3 is array(0 to 2047) of integer range 0 to 2047;
--signal char : integer range 0 to 2047:=0;
--signal temp_minimum : integer range 0 to 2047:=0;
--signal char2 : integer;
signal cnt:integer range 0 to 4096:=0;
signal wea : std_logic_vector(0 downto 0);
signal wea_buf : std_logic:='0';
signal    addra :  STD_LOGIC_VECTOR(11 DOWNTO 0):=(others => '0');
signal    dina :  STD_LOGIC_VECTOR(10 DOWNTO 0):=(others => '0');
signal    douta :  STD_LOGIC_VECTOR(10 DOWNTO 0):=(others => '0');
signal    t1_count : integer range 0 to 10000000 := 0;
signal    t2_count : integer range 0 to 1000 := 0;
--signal    t1_done  : std_logic := '0';
signal    ch_start : std_logic_vector(16-1 downto 0):=(others => '0');
COMPONENT RAM_Test
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
  );
END COMPONENT;

attribute mark_debug : string;
attribute mark_debug of addra : signal is "true";
attribute mark_debug of douta : signal is "true";


begin



inst_RAM_Test: RAM_Test
  PORT map(
    clka => clk,
    wea  => wea,
    addra  => addra,
    dina  => dina,
    douta  => douta
  );
wea <= conv_std_logic_vector(wea_buf,1);

process(rst,clk)  -- k40_1 Count
begin
    if(rst = '0') then
        t1_count <= 0;
        t1_done  <= '0';
    elsif(rising_edge(clk))then
        if (t1_count = 10000) then--1ms
            t1_done <= '1';
        else
            t1_count <= t1_count + 1;
        end if;
    end if;
end process;


process(rst,clk)  -- k40_2 Count
begin
    if(rst = '0') then
        t2_count <= 0;

    elsif(rising_edge(clk))then
        if (t1_done = '1') then
            if(t2_count =1000 )then
                t2_count <= 0;
            else
                t2_count <= t2_count + 1;
            end if;
        else
            t2_count <= 0;
        end if;
    end if;
end process;

process(rst,clk)  -- k40_1 , K40_2
begin
    if(rst = '0') then

        addra <= (others => '0');
    elsif(rising_edge(clk))then
        if (t1_done = '0') then
            if(t1_count = 10000) then
                k40_1 <= "00000"&douta;
                addra <= (others=> '0');
            elsif(t1_count = 9997) then
                addra <= ch_temp_t1(11 downto 0)-ch_start(11 downto 0);
            elsif(t1_count = 9993) then
                ch_start <= "00000"&douta;
            elsif(t1_count = 9990) then
                addra <= (others => '0');
            else
                addra <= (others => '0');
            end if;
        else

            if(t2_count = 997)then
                k40_2 <= "00000"&douta;
            elsif(t2_count = 0) then
                if(ch_temp_t2 <= ch_start)then
                    addra <=  X"001";
                else
                    addra <= ch_temp_t2(11 downto 0) - ch_start(11 downto 0);
                end if;
            end if;
        end if;
    end if;
end process;

--process(clk)
--begin
--    if(rising_edge(clk)) then
--        if ( ch_temp_t2 <= 1100) then -- and ch_temp_t2 <= 1850 ) then
--            GC_change_en <= '1';
--        else
--            GC_change_en <= '0';
--        end if;
--    end if;
--end process;

end Behavioral;


