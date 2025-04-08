----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:54:03 10/19/2011 
-- Design Name: 
-- Module Name:    ADC_invert - Behavioral 
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

entity ADC_invert is
port(
	clk : in std_logic;
	ADC_ORT : IN std_logic;  
	ADC_value : in std_logic_vector(11 downto 0); 
	inva : out std_logic_vector(13 downto 0));
end ADC_invert;

architecture Behavioral of ADC_invert is
signal temp : std_logic_vector(13 downto 0);


attribute mark_debug : string;
attribute keep : string;

--attribute mark_debug of temp : signal is "true";


begin
inva<=temp;
process(clk)
	begin
		if rising_edge(clk) then
                if ADC_ORT = '0' then
--	               if temp(11) = '1' then
					temp(13)<=ADC_value(11); -- not invert
					temp(12)<=ADC_value(10);
					temp(11)<=ADC_value(9);
					temp(10)<=ADC_value(8);
					temp(9)<=ADC_value(7);
					temp(8)<=ADC_value(6);
					temp(7)<=ADC_value(5);
					temp(6)<=ADC_value(4);
					temp(5)<=ADC_value(3);
					temp(4)<=ADC_value(2);
					temp(3)<=ADC_value(1);
					temp(2)<=ADC_value(0);
					temp(1)<='0';
					temp(0)<='0';		

				else
				    temp<= "11111111111111";
		      	end if;
					
			
		end if;
end process;
			
end Behavioral;

