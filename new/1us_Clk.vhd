----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:48:28 10/25/2011 
-- Design Name: 
-- Module Name:    clk_20us - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Clk_1ns is
port(clk: in std_logic;
	clk_1ns: out std_logic:='0');
end Clk_1ns;

architecture Behavioral of Clk_1ns is
signal D : integer range 0 to 1005:=0;
begin
process(clk)
begin
	if rising_edge(clk) then
		if D = 10 then
			Clk_1ns <= '0';

			D <= 0;
		elsif D= 5 then
			Clk_1ns <= '1';
			D <= D + 1;
		else
			D <= D + 1;
			
		end if;
	end if;
end process;

end Behavioral;
