----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/06/01 17:00:34
-- Design Name: 
-- Module Name: PSD_temp_subtraction - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Temp_Gctable is
  Port  (
--        rst : in std_logic;
        clk : in std_logic;    
        acq_start : in std_logic;
--        Ch_temp1 : in STD_LOGIC_VECTOR (31 downto 0 );
--        Ch_temp2 : in STD_LOGIC_VECTOR (31 downto 0 );
--        cl_wr_en_pipe : in STD_LOGIC_VECTOR ( 1 downto 0);
        Cs1_ch :  in std_logic_vector( 16 - 1 downto 0);
        Cs2_ch : in std_logic_vector( 16 - 1 downto 0);
        Ch_662Kev_read : in std_logic_vector( 16 - 1 downto 0);
        K40_Pre_GC : in std_logic_vector(16 -1 downto 0);
--        Cal_662KeV_Ch : in std_logic_vector(16 - 1 downto 0);
        GC_Cal_out : out std_logic_vector(16 - 1 downto 0);
        Compare_rdy : in std_logic);
end Temp_Gctable;

architecture Behavioral of Temp_Gctable is
  signal cnt:integer range 0 to 4096:=0;
  signal wea : std_logic_vector(0 downto 0);
  signal wea_buf : std_logic:='0';
  signal    addra :  STD_LOGIC_VECTOR(11 - 1 DOWNTO 0):=(others => '0');
  signal    dina :  STD_LOGIC_VECTOR(16 - 1  DOWNTO 0):=(others => '0');
  signal    douta :  STD_LOGIC_VECTOR(16 - 1 DOWNTO 0):=(others => '0');
  signal    t1_count : integer range 0 to 10000000 := 0;
  signal    t1_done : std_logic:='0';
  signal    t2_count : integer range 0 to 100000 := 0;
  signal    temp_to_ch : std_logic_vector( 31 downto 0):=((others => '0') );
  --signal    t1_done  : std_logic := '0';
  signal    ch_start : std_logic_vector(16-1 downto 0):=(others => '0');
  signal    ch_valid : std_logic:='0';
  signal    t1_Cs_GC : std_logic_vector( 16 - 1 downto 0);
  signal    t2_Cs_GC : std_logic_vector( 16 - 1 downto 0);

  signal    Cs_ch : std_logic_vector( 24 - 1 downto 0);
  signal    cal_Cs1_ch : std_logic_vector( 24 - 1 downto 0);
  signal    cal_Cs2_ch : std_logic_vector( 24 - 1 downto 0);
  signal    cal_indc_sel : std_logic;
  signal    Gc_inde_buf : std_logic_vector( 16 - 1 downto 0);
  signal    indecre_sel : std_logic:= '0';
  signal    table_t1_ch : std_logic_vector(16-1 downto 0) := X"01a9";
  signal    Ch_temp : std_logic_vector(32 - 1 downto 0);
  COMPONENT ram_Gctable
 
    PORT (
      clka : IN STD_LOGIC;
      wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      addra : IN STD_LOGIC_VECTOR(11 - 1 DOWNTO 0);
      dina : IN STD_LOGIC_VECTOR(16 - 1 DOWNTO 0);
      douta : OUT STD_LOGIC_VECTOR(16 - 1 DOWNTO 0)
    );
  END COMPONENT;

--  COMPONENT floating_point_3
--  PORT (
--    aclk : IN STD_LOGIC;
--    aclken : IN STD_LOGIC;
--    s_axis_a_tvalid : IN STD_LOGIC;
--    s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
--    m_axis_result_tvalid : OUT STD_LOGIC;
--    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
--  );
--END COMPONENT;
  
  attribute mark_debug : string;
  attribute mark_debug of addra : signal is "true";
  attribute mark_debug of douta : signal is "true";
  
  
  begin
  
  
  
  inst_ram_Gctable: ram_Gctable
    PORT map(
      clka => clk,
      wea  => wea,
      addra  => addra,
      dina  => dina,
      douta  => douta
    );

--   inst_floating_point_3 : floating_point_3
--   PORT map (
--     aclk                   => clk,
--     aclken                 => acq_start,
--     s_axis_a_tvalid        => Compare_rdy,
--     s_axis_a_tdata         => Ch_temp,
--     m_axis_result_tvalid   => ch_valid,
--     m_axis_result_tdata    => Cs_ch
--   ); 
  wea <= conv_std_logic_vector(wea_buf,1);


  
--  process(clk)  -- peak1 Count
--  begin
--        if(rising_edge(clk))then
--          if(t1_done = '0')then
--            Ch_temp <= Ch_temp1;
--            Cs1_ch  <= Cs_ch;
--          else
--            Ch_temp <= Ch_temp2;
--            Cs2_ch  <= Cs_ch;
--          end if;    
--      end if;
--  end process;
  
  
  
  process(clk)  -- peak1 Count
  begin
        if(rising_edge(clk))then
          if(acq_start = '1')then
            if(t1_count = 10000 )then
--                if (cl_wr_en_pipe = "01")then
--                    t1_count <= 0;
--                    t1_done  <= '0';
--                else
                    t1_done <= '1';
--                end if;    
                    
            else
                t1_count <= t1_count + 1; 
            end if;
          else
            t1_count <= 0;
            t1_done  <= '0';
          end if;    
      end if;
  end process;
  
  

  
  process(clk)  -- peak2 Count
  begin
      if(rising_edge(clk))then
          if(t1_done = '1')then
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
  
  
    
--  process(clk)  
--  begin
--        if(rising_edge(clk))then
--          if(acq_start = '1')then
--            if(t1_count = 3000) then
--                if(Cs1_ch >= table_t1_ch )then
--                    cal_Cs2_ch <= Cs1_ch - table_t1_ch  + X"000000";
--                    cal_indc_sel <= '0';
--                else
--                    cal_Cs2_ch <= table_t1_ch - Cs1_ch  + X"000000";
--                    cal_indc_sel <= '1'; 
--                end if;    
--            end if;    
--          end if;    
--      end if;
--  end process;

  process(clk)  -- peak1 , peak2
  begin
      if(rising_edge(clk))then
        if(t1_done ='0')then  
          if(t1_count = 9995)then
            t1_Cs_GC <= douta;
          elsif(t1_count = 9990) then
            if( cal_indc_sel = '1')then
                addra <= Cs1_ch(11 - 1 downto 0) - 1;
            else
                addra <= Cs1_ch(11 - 1 downto 0) - 1;
            
            end if;    
          end if;
        else
          if(t2_count = 995)then
            t2_cs_GC <= douta;
          elsif(t2_count = 990) then   
            if( cal_indc_sel = '1')then
                addra <= Cs2_ch(11 - 1 downto 0) - 1;
            else
                addra <= Cs2_ch(11 - 1 downto 0) - 1;
            end if;
          end if;      
        end if;
      end if;
  end process;
  
  process(clk)  -- buf_calcu
  begin
      if(rising_edge(clk))then
        if(acq_start = '1')then  
          if(t2_cs_GC > t1_cs_GC)then
            Gc_inde_buf <= t2_cs_GC - t1_cs_GC;
            indecre_sel <= '1';
          elsif(t2_cs_GC = t1_cs_GC) then  
            Gc_inde_buf <= (others => '0') ;
            indecre_sel <= '0';
          else
            Gc_inde_buf <= t1_cs_GC - t2_cs_GC;
            indecre_sel <= '0';  
          end if;      
        end if;  
      end if;
  end process; 

  process (clk, acq_start)
  begin
    if acq_start = '0' then
        GC_Cal_out <= (others => '0') ;
    elsif rising_edge(clk) then 
          if(indecre_sel = '1')then
            GC_Cal_out <= K40_Pre_GC + Gc_inde_buf;
          
          else
            GC_Cal_out <= K40_Pre_GC - Gc_inde_buf;
          end if;  
    end if;
  end process;
  
  end Behavioral;
  