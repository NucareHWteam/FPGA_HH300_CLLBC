----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/04/11 13:45:09
-- Design Name: 
-- Module Name: eeprom_top - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity eeprom_top is
 Port ( --rst  : in std_logic;
        clk              : in std_logic;
        Hv_wr_en               : in  std_logic;
        su_wr_en            : in std_logic;
        sw_wr_en                  : in STD_LOGIC;
        rd_en               : in std_logic;
        GC_write                  : in std_logic_vector(16 - 1 downto 0):= X"6978";
        Temp_write                : in std_logic_vector(16 - 1 downto 0):= X"0401";
        Ch_32Kev_write            : in std_logic_vector(16 - 1 downto 0):= X"000F";
        Ch_662Kev_write           : in std_logic_vector(16 - 1 downto 0):= X"018a";
        Ch_1460Kev_write          : in std_logic_vector(16 - 1 downto 0):= X"036b";
        D_lab_write               : in std_logic_vector(16 - 1 downto 0):= X"000D";
        HV_DAC_write              : in std_logic_vector(16 - 1 downto 0):= X"7d46";
        Threshold_write           : in std_logic_vector(8 - 1 downto 0):= X"06";
        SignalTime_write          : in std_logic_vector(8 - 1 downto 0):= X"0b";
        Data_subtraction_write    : in std_logic_vector(8 - 1 downto 0):= X"00";
        Serial_1_write            : in std_logic_vector(8 - 1 downto 0):= X"47";
        Serial_2_write            : in std_logic_vector(8 - 1 downto 0):= X"33";
        Serial_3_write            : in std_logic_vector(8 - 1 downto 0):= X"41";
        Serial_4_write            : in std_logic_vector(8 - 1 downto 0):= X"41";
        Serial_5_write            : in std_logic_vector(8 - 1 downto 0):= X"34";
        Serial_6_write            : in std_logic_vector(8 - 1 downto 0):= X"38";
        
        
        GC_read                  : out std_logic_vector(16 - 1 downto 0);
        Temp_read                : out std_logic_vector(16 - 1 downto 0);
        Ch_32Kev_read            : out std_logic_vector(16 - 1 downto 0);
        Ch_662Kev_read           : out std_logic_vector(16 - 1 downto 0);
        Ch_1460Kev_read          : out std_logic_vector(16 - 1 downto 0);
        D_lab_read               : out std_logic_vector(16 - 1 downto 0);
        HV_DAC_read              : out std_logic_vector(16 - 1 downto 0);
        Threshold_read           : out std_logic_vector(8 - 1 downto 0);
        SignalTime_read          : out std_logic_vector(8 - 1 downto 0);
        Data_subtraction_read    : out std_logic_vector(8 - 1 downto 0);
        Serial_1_read            : out std_logic_vector(8 - 1 downto 0);
        Serial_2_read            : out std_logic_vector(8 - 1 downto 0);
        Serial_3_read            : out std_logic_vector(8 - 1 downto 0);
        Serial_4_read            : out std_logic_vector(8 - 1 downto 0);
        Serial_5_read            : out std_logic_vector(8 - 1 downto 0);
        Serial_6_read            : out std_logic_vector(8 - 1 downto 0);
        
        read_end                 : out std_logic;
        
        cs_n                : out std_logic;
        sclk                : out std_logic;
        miso                : in std_logic;
        mosi                : out std_logic
         );
end eeprom_top;


architecture Behavioral of eeprom_top is

    
    
signal tx_data : std_logic_vector(7 downto 0);
signal rx_data : std_logic_vector(7 downto 0);
signal busy : std_logic;    
signal ena : std_logic;  
signal cont : std_logic; 
signal rst  : std_logic:='1';
signal ss_n : std_logic_vector(0 downto 0);
signal mosi_buf : std_logic;
signal miso_buf : std_logic;
--signal sclk_buf : std_logic;
signal cs_n_buf : std_logic;
--signal clk,clk_debug : std_logic;
--signal        GC                  :  std_logic_vector(16 - 1 downto 0):= X"6978";
--signal        Temp                :  std_logic_vector(16 - 1 downto 0):= X"0401";
--signal        Ch_32Kev            :  std_logic_vector(16 - 1 downto 0):= X"000F";
--signal        Ch_662Kev           :  std_logic_vector(16 - 1 downto 0):= X"018a";
--signal        Ch_1460Kev          :  std_logic_vector(16 - 1 downto 0):= X"036b";
--signal        D_lab               :  std_logic_vector(16 - 1 downto 0):= X"000D";
--signal        HV_DAC              :  std_logic_vector(16 - 1 downto 0):= X"7d46";
--signal        Threshold           :  std_logic_vector(8 - 1 downto 0):= X"06";
--signal        SignalTime          :  std_logic_vector(8 - 1 downto 0):= X"0b";
--signal        Data_subtraction    :  std_logic_vector(8 - 1 downto 0):= X"00";
--signal        Serial_1            :  std_logic_vector(8 - 1 downto 0):= X"47";
--signal        Serial_2            :  std_logic_vector(8 - 1 downto 0):= X"33";
--signal        Serial_3            :  std_logic_vector(8 - 1 downto 0):= X"41";
--signal        Serial_4            :  std_logic_vector(8 - 1 downto 0):= X"41";
--signal        Serial_5            :  std_logic_vector(8 - 1 downto 0):= X"34";
--signal        Serial_6            :  std_logic_vector(8 - 1 downto 0):= X"38";



attribute mark_debug : string;
    attribute mark_debug of cs_n : signal is "true";
    attribute mark_debug of sclk : signal is "true";
    attribute mark_debug of hv_wr_en : signal is "true";
    attribute mark_debug of su_wr_en : signal is "true";
    attribute mark_debug of rd_en : signal is "true";
    attribute mark_debug of miso : signal is "true";
    attribute mark_debug of mosi : signal is "true";
--attribute mark_debug : string;
--    attribute mark_debug of mosi_buf : signal is "true";
--    attribute mark_debug of miso_buf : signal is "true";
--    attribute mark_debug of sclk_buf : signal is "true";
--    attribute mark_debug of cs_n_buf : signal is "true";
signal sclk_buf : std_logic;
signal ss_n_buf : std_logic;
Component eeprom_spi_master IS
  GENERIC(
    slaves  : INTEGER := 1;  --number of spi slaves
    d_width : INTEGER := 8); --data bus width
  PORT(
    clock   : IN     STD_LOGIC;                             --system clock
    reset_n : IN     STD_LOGIC;                             --asynchronous reset
    enable  : IN     STD_LOGIC;                             --initiate transaction
    cpol    : IN     STD_LOGIC;                             --spi clock polarity
    cpha    : IN     STD_LOGIC;                             --spi clock phase
    cont    : IN     STD_LOGIC;                             --continuous mode command
    clk_div : IN     INTEGER;                               --system clock cycles per 1/2 period of sclk
    addr    : IN     INTEGER;                               --address of slave
    tx_data : IN     STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);  --data to transmit
    
    miso    : IN     STD_LOGIC;                             --master in, slave out
    sclk    : Buffer STD_LOGIC;                             --spi clock
    ss_n    : inout STD_LOGIC_VECTOR(slaves-1 DOWNTO 0);   --slave select
    mosi    : OUT    STD_LOGIC;                             --master out, slave in
    busy    : OUT    STD_LOGIC;                             --busy / data ready signal
    rx_data : OUT    STD_LOGIC_VECTOR(d_width-1 DOWNTO 0)); --data received
END component;

Component eeprom_protocol is
 Port (
    clock   : IN     STD_LOGIC;                             --system clock
    reset_n : IN     STD_LOGIC;                             --asynchronous reset
    enable  : out     STD_LOGIC;                             --initiate transaction   
    hv_wr_en   : in     std_logic;
    su_wr_en   : in     std_logic;
    sw_wr_en    : in    STD_LOGIC;
    rd_en   : in    std_logic;
    cont    : out     STD_LOGIC;                             --continuous mode command
    tx_data : out     STD_LOGIC_VECTOR(8-1 DOWNTO 0);  --data to transmit
    busy    : IN    STD_LOGIC;                             --busy / data ready signal
    
    GC                  : in std_logic_vector(16 - 1 downto 0);
    Temp                : in std_logic_vector(16 - 1 downto 0);
    Ch_32Kev            : in std_logic_vector(16 - 1 downto 0);
    Ch_662Kev           : in std_logic_vector(16 - 1 downto 0);
    Ch_1460Kev          : in std_logic_vector(16 - 1 downto 0);
    D_lab               : in std_logic_vector(16 - 1 downto 0);
    HV_DAC              : in std_logic_vector(16 - 1 downto 0);
    Threshold           : in std_logic_vector(8 - 1 downto 0);
    SignalTime          : in std_logic_vector(8 - 1 downto 0);
    Data_subtraction    : in std_logic_vector(8 - 1 downto 0);
    Serial_1            : in std_logic_vector(8 - 1 downto 0);
    Serial_2            : in std_logic_vector(8 - 1 downto 0);
    Serial_3            : in std_logic_vector(8 - 1 downto 0);
    Serial_4            : in std_logic_vector(8 - 1 downto 0);
    Serial_5            : in std_logic_vector(8 - 1 downto 0);
    Serial_6            : in std_logic_vector(8 - 1 downto 0);
    
    GC_read                  : out std_logic_vector(16 - 1 downto 0);
    Temp_read                : out std_logic_vector(16 - 1 downto 0);
    Ch_32Kev_read            : out std_logic_vector(16 - 1 downto 0);
    Ch_662Kev_read           : out std_logic_vector(16 - 1 downto 0);
    Ch_1460Kev_read          : out std_logic_vector(16 - 1 downto 0);
    D_lab_read               : out std_logic_vector(16 - 1 downto 0);
    HV_DAC_read              : out std_logic_vector(16 - 1 downto 0);
    Threshold_read           : out std_logic_vector(8 - 1 downto 0);
    SignalTime_read          : out std_logic_vector(8 - 1 downto 0);
    Data_subtraction_read    : out std_logic_vector(8 - 1 downto 0);
    Serial_1_read            : out std_logic_vector(8 - 1 downto 0);
    Serial_2_read            : out std_logic_vector(8 - 1 downto 0);
    Serial_3_read            : out std_logic_vector(8 - 1 downto 0);
    Serial_4_read            : out std_logic_vector(8 - 1 downto 0);
    Serial_5_read            : out std_logic_vector(8 - 1 downto 0);
    Serial_6_read            : out std_logic_vector(8 - 1 downto 0);
    
    read_end                 : out std_logic;
    
    rx_data : IN    STD_LOGIC_VECTOR(8-1 DOWNTO 0)); --data received
end Component;

COMPONENT clk_wiz_0 
PORT(
       clk_out1  : OUT std_logic;
       clk_out2  : OUT std_logic;

       reset  : In std_logic;
       locked : OUT std_logic;
        clk_in1 : In std_logic
        );
 END COMPONENT;

begin
cs_n <= ss_n(0);
sclk <= sclk_buf;

inst_eeprom_spi_master : eeprom_spi_master
port map(
    clock   => clk,
    reset_n => rst,
    enable  => ena,
    cpol    => '0',
    cpha    => '0',
    cont    => cont,
    clk_div => 20,
    addr    => 1,
    tx_data => tx_data,
    miso    => miso,
    sclk    => sclk_buf,
    ss_n    => ss_n,
    mosi    => mosi,
    busy    => busy,
    rx_data => rx_data);
    
inst_eeprom_protocol  : eeprom_protocol 
 Port map(
    clock   => clk,
    reset_n => rst,
    enable  => ena,  
    hv_wr_en   => hv_wr_en,
    su_wr_en   => su_wr_en,
    sw_wr_en   => sw_wr_en,
    rd_en   => rd_en,
    cont    => cont,
    tx_data => tx_data,
    busy    => busy,
    
    GC                  =>  GC_write                ,
    Temp                =>  Temp_write              ,
    Ch_32Kev            =>  Ch_32Kev_write          ,
    Ch_662Kev           =>  Ch_662Kev_write         ,
    Ch_1460Kev          =>  Ch_1460Kev_write        ,
    D_lab               =>  D_lab_write             ,
    HV_DAC              =>  HV_DAC_write            ,
    Threshold           =>  Threshold_write         ,
    SignalTime          =>  SignalTime_write        ,
    Data_subtraction    =>  Data_subtraction_write  ,
    Serial_1            =>  Serial_1_write          ,
    Serial_2            =>  Serial_2_write          ,
    Serial_3            =>  Serial_3_write          ,
    Serial_4            =>  Serial_4_write          ,
    Serial_5            =>  Serial_5_write          ,
    Serial_6            =>  Serial_6_write          ,
    
    GC_read                => GC_read,  
    Temp_read              => Temp_read,
    Ch_32Kev_read          => Ch_32Kev_read,
    Ch_662Kev_read         => Ch_662Kev_read,
    Ch_1460Kev_read        => Ch_1460Kev_read,
    D_lab_read             => D_lab_read,
    HV_DAC_read            => HV_DAC_read,
    Threshold_read         => Threshold_read,
    SignalTime_read        => SignalTime_read,
    Data_subtraction_read  => Data_subtraction_read,
    Serial_1_read          => Serial_1_read,
    Serial_2_read          => Serial_2_read,
    Serial_3_read          => Serial_3_read,
    Serial_4_read          => Serial_4_read,
    Serial_5_read          => Serial_5_read,
    Serial_6_read          => Serial_6_read,
    
    read_end               => read_end,
    
    rx_data  =>rx_data);

--i_clk_wiz_0 : clk_wiz_0 
--PORT map(
--       clk_out1  => clk,
--       clk_out2  => clk_debug,
----         clk_XADC=> clk_XADC,
--       reset  => '0',
--       locked => open,
--        clk_in1 => clk_in
--        );

end Behavioral;
