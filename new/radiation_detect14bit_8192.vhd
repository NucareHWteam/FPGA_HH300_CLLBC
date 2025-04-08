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

entity Radiation_detect14bit_8192 is
port(
	clk: in std_logic;
	rst: in std_logic;
	acq_start: IN std_logic;	
	--CH_ACQ: In std_logic;
	ADC_ORT : in std_logic;
	--flag_data_stop : inout std_logic;
	Baseline_num : out std_logic_vector(13 downto 0); 
	CH_Signal_Adder_Com_out : out std_logic_vector(30 downto 0);
	Ch_Data_subtraction_all_out : out std_logic_vector(13 downto 0);
	Ch_Data_subtraction_all_Pre_out : out std_logic_vector(13 downto 0);
	Ch_Data_subtraction_all_Pre1_out : out std_logic_vector(13 downto 0);
	cnt_Signal_i_out : out std_logic_vector(12 downto 0);
	
	flag_start : out std_logic;
	Ort_en : in std_logic;  	
	Threshold : In STD_LOGIC_VECTOR( 12 downto 0);
	Signal_TIME: In STD_LOGIC_Vector( 6 downto 0);
	Data_subtraction : In STD_LOGIC_VECTOR( 12 downto 0) ;
	--Ch_Data_subtraction_all : in std_logic_vector(11 downto 0);
     Pileup_ce :out std_logic:='0';	
	data_in: in std_logic_vector(13 downto 0);
	dout_CH: out std_logic_vector(10 downto 0);
	 Trape_in :out std_logic_vector(13 downto 0);
	 data_in_Prompt_window : in std_logic_vector(15 downto 0); 
	 data_in_Delayed_window: in std_logic_vector(15 downto 0);
	data_in_Prompt: out std_logic_vector(17 downto 0);
	data_in_Delayed: out std_logic_vector(17 downto 0);	 
	PSD_Factor_bit : IN std_logic;	
	PSD_en: out std_logic;	
	flag_CH_Neutron: out std_logic;
	flag_CH : out std_logic
	);	
end Radiation_detect14bit_8192;

architecture Behavioral of Radiation_detect14bit_8192 is
--component Pileup_ROM
--	port (
--	clka: IN std_logic;
--	addra: IN std_logic_VECTOR(5 downto 0);
--	douta: OUT std_logic_VECTOR(10 downto 0));
--end component;
--
--component Pileup_Multiple
--	port (
--	clk: IN std_logic;
--	a: IN std_logic_VECTOR(10 downto 0);
--	b: IN std_logic_VECTOR(10 downto 0);
--	ce: IN std_logic;
--	p: OUT std_logic_VECTOR(21 downto 0));
--end component;
--attribute syn_black_box : boolean;
--attribute syn_black_box of Pileup_Multiple: component is true;

Component Moving_Avr is
generic (
  G_NBIT                     : integer := 14;
  G_AVG_LEN_LOG              : integer := 6 );
port (  
  i_clk                      : in  std_logic;
  i_rstb                     : in  std_logic;
  i_sync_reset               : in  std_logic;
  -- input
  i_data_ena                 : in  std_logic;
  i_data                     : in  std_logic_vector(G_NBIT-1 downto 0);
  -- output
  o_data_valid               : out std_logic;
  o_data                     : out std_logic_vector(G_NBIT-1 downto 0));
end Component;

Component c_addsub_0 IS
  PORT (
    A : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
    CLK : IN STD_LOGIC;
    CE : IN STD_LOGIC;
    S : OUT STD_LOGIC_VECTOR(13 DOWNTO 0)
  );
end Component;

Component c_addsub_1 IS
  PORT (
    A : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    CLK : IN STD_LOGIC;
    CE : IN STD_LOGIC;
    S : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
  );
end Component;

function maximum (
    left, right : STD_LOGIC_VECTOR)                      -- inputs
    return STD_LOGIC_VECTOR is
  begin  -- function max
    if LEFT > RIGHT then return LEFT;
    else return RIGHT;
    end if;
  end function maximum;

function minimum (
    left, right : STD_LOGIC_VECTOR)                     -- inputs
    return STD_LOGIC_VECTOR is
  begin  -- function minimum
    if LEFT < RIGHT then return LEFT;
    else return RIGHT;
    end if;
  end function minimum;

signal base_state : std_logic_vector(2 downto 0):="000";

signal Signal_data_on  : std_logic;
signal Signal_data_on1 : std_logic;
signal Signal_data_on2 : std_logic;
signal Signal_data_on3 : std_logic;
signal Signal_data_on4 : std_logic;
signal Signal_data_on5 : std_logic;
signal Signal_data_on6 : std_logic;
signal Signal_data_on7 : std_logic;
signal Signal_data_on8 : std_logic;

signal base_refresh1  : std_logic;
signal base_refresh2  : std_logic;
signal base_refresh3  : std_logic;
signal base_refresh4  : std_logic;
signal base_refresh5  : std_logic;
signal base_refresh6  : std_logic;
signal base_refresh7  : std_logic;
signal base_refresh8  : std_logic;


signal data_in_1d : STD_LOGIC_VECTOR ( 13 downto 0 );
signal data_in_2d : STD_LOGIC_VECTOR ( 13 downto 0 );

signal CH_Signal: STD_LOGIC_VECTOR ( 13 downto 0 );
signal data_in_Baseline: STD_LOGIC_VECTOR ( 13 downto 0 );
signal F_T_Pileup : STD_LOGIC_VECTOR ( 13 downto 0 );
signal F_Pileup: STD_LOGIC_VECTOR ( 13 downto 0 );
signal D_Pileup: STD_LOGIC_VECTOR ( 13 downto 0 ); 
signal D_Pileup_Before :  std_logic_vector(13 downto 0);
signal D_Pileup_Before_Before :  std_logic_vector(13 downto 0);
signal D_Pileup_Before_Before_Before :  std_logic_vector(13 downto 0);
signal D_Pileup_Before_Before_Before_Before :  std_logic_vector(13 downto 0);
signal D_Pileup_Before_Before_Before_Before_Before :  std_logic_vector(13 downto 0);
signal D_Pileup_Before_1:  std_logic_vector(13 downto 0);
signal D_Pileup_Before_2:  std_logic_vector(13 downto 0);
signal D_Pileup_Before_3:  std_logic_vector(13 downto 0);
signal D_Pileup_Before_4:  std_logic_vector(13 downto 0);
signal D_Pileup_Before_5:  std_logic_vector(13 downto 0);


signal CH_Signal_Baseline: STD_LOGIC_VECTOR ( 13 downto 0 );
signal CH_Signal_Baseline1: STD_LOGIC_VECTOR ( 13 downto 0 );
signal Ch_Data_subtraction : std_logic_vector(13 downto 0):=(others => '0');
signal Ch_Data_subtraction_2 : std_logic_vector(13 downto 0):=(others => '0');
signal Ch_Data_subtraction_3 : std_logic_vector(13 downto 0):=(others => '0');
signal Ch_Data_subtraction_4 : std_logic_vector(13 downto 0):=(others => '0');

signal Ch_Data_subtraction_i : std_logic_vector(13 downto 0):=(others => '0');
signal Ch_Data_subtraction_2_i : std_logic_vector(13 downto 0):=(others => '0');
signal Ch_Data_subtraction_3_i : std_logic_vector(13 downto 0):=(others => '0');
signal Ch_Data_subtraction_4_i : std_logic_vector(13 downto 0):=(others => '0');

signal Ch_Data_subtraction_min: std_logic_vector(13 downto 0):=(others => '0');
signal Ch_Data_subtraction_min_j : std_logic_vector(13 downto 0):=(others => '0');


signal Ch_Data_subtraction_all_1d: std_logic_vector(13 downto 0):=(others => '0');
signal Ch_Data_subtraction_all_2d: std_logic_vector(13 downto 0):=(others => '0');
signal Ch_Data_subtraction_all_3d: std_logic_vector(13 downto 0):=(others => '0');
signal Ch_Data_subtraction_all_4d: std_logic_vector(13 downto 0):=(others => '0');
signal Ch_Data_subtraction_all_5d: std_logic_vector(13 downto 0):=(others => '0');
signal Ch_Data_subtraction_all_6d: std_logic_vector(13 downto 0):=(others => '0');
signal Ch_Data_subtraction_all_7d: std_logic_vector(13 downto 0):=(others => '0');
signal Ch_Data_subtraction_all_8d: std_logic_vector(13 downto 0):=(others => '0');

signal Ch_Data_on_1d: std_logic_vector(13 downto 0):=(others => '0');

signal Ch_Data_subtraction_all_0 : std_logic_vector(13 downto 0):=(others => '0');
signal Ch_Data_subtraction_all_1 : std_logic_vector(13 downto 0):=(others => '0');
signal Ch_Data_subtraction_all_2 : std_logic_vector(15 downto 0):=(others => '0');
signal Ch_Data_subtraction_all_3 : std_logic_vector(15 downto 0):=(others => '0');
signal Ch_Data_subtraction_all : std_logic_vector(13 downto 0):=(others => '0');


signal Ch_Data_subtraction_Origin : std_logic_vector(13 downto 0):=(others => '0');
signal flag_Baseline : std_logic:='0';
signal flag_Find_Baseline : std_logic_vector(2 downto 0):="000";
Signal CH_Baseline : STD_LOGIC_VECTOR ( 19 downto 0 ):= (others => '0'); 
signal CH_Baseline_Pre : std_logic_VECTOR ( 19 downto 0 ):= (others => '0');  
--Signal CH_Signal_Baseline : STD_LOGIC_VECTOR ( 10 downto 0 ):= (others => '0'); 
signal CH_Baseline_Pre_1 : std_logic_VECTOR ( 13 downto 0 ):= (others => '0'); 
Signal CH_Baseline_2 : STD_LOGIC_VECTOR ( 19 downto 0 ):= (others => '0'); 
signal CH_Baseline_Pre_2 : std_logic_VECTOR ( 13 downto 0 ):= (others => '0');  
Signal CH_Baseline_3 : STD_LOGIC_VECTOR ( 19 downto 0 ):= (others => '0'); 
signal CH_Baseline_Pre_3 : std_logic_VECTOR ( 13 downto 0 ):= (others => '0');  
Signal CH_Baseline_4 : STD_LOGIC_VECTOR ( 19 downto 0 ):= (others => '0'); 
signal CH_Baseline_Pre_4 : std_logic_VECTOR ( 13 downto 0 ):= (others => '0');  

signal flag_Noise_Baseline: std_logic:='0'; 

Signal CH_Signal_Baseline_2 : STD_LOGIC_VECTOR ( 12 downto 0 ):= (others => '0');  


signal max_Baseline_Add : std_logic_vector(13 downto 0):=(others => '0');
signal min_Baseline_Add : std_logic_vector(13 downto 0):=(others => '0');

signal max_Baseline_Avr : std_logic_vector(13 downto 0):=(others => '0');
signal min_Baseline_Avr : std_logic_vector(13 downto 0):=(others => '0');

signal Baseline_Avr_cnt : STD_LOGIC_VECTOR (10 downto 0):= (others => '0');
signal Ch_Data_subtraction_all_Avr : STD_LOGIC_VECTOR ( 20 downto 0):= (others => '0');
signal Ch_Data_subtraction_all_Avr_Done: STD_LOGIC_VECTOR ( 20 downto 0):= (others => '0');

signal CH_0: STD_LOGIC_VECTOR ( 12 downto 0 );
signal CH_1: STD_LOGIC_VECTOR ( 12 downto 0 );
signal CH_2: STD_LOGIC_VECTOR ( 12 downto 0 );
signal CH_3: STD_LOGIC_VECTOR ( 12 downto 0 );

signal CH_S: STD_LOGIC_VECTOR ( 21 downto 0 ):= (others => '0');
signal CH_S_1: STD_LOGIC_VECTOR ( 21 downto 0 ):= (others => '0');
signal CH_S_PSD_Prompt : STD_LOGIC_VECTOR ( 21 downto 0 ):= (others => '0'); 
signal CH_S_PSD_Delay: STD_LOGIC_VECTOR ( 21 downto 0 ):= (others => '0'); 
Signal flag_1: std_logic:='0';
Signal flag_2:std_logic:='0'; 
Signal T_flag_CH:std_logic:='0';
signal dout_prompt: std_logic_vector(21 downto 0);
signal dout_delayed: std_logic_vector(21 downto 0);
signal dout: std_logic_vector(21 downto 0);
signal pileup_out : std_logic_vector(10 downto 0); 

signal  PSD_Counter: std_logic_vector(6 downto 0);

signal Pileup_p :  std_logic_vector(23 downto 0);
signal cnt_Noise_Fileup : std_logic_vector(10 downto 0):= (others => '0');
signal test_start : std_logic:='0';

signal i_ort_en : std_logic_vector(1 downto 0):="00";
signal Saturation_over : std_logic:='0';
signal Saturation_over_pipe : std_logic_vector:="00";
signal Saturation_over_cnt :  integer range 0 to 500000:=0;
signal trans_stay :  std_logic:='0';



signal cnt_Signal : STD_LOGIC_VECTOR ( 5 downto 0):= (others => '0');
signal cnt_Signal_2 : STD_LOGIC_VECTOR ( 5 downto 0):= (others => '0');
signal cnt_Signal_3 : STD_LOGIC_VECTOR ( 5 downto 0):= (others => '0');
signal cnt_Signal_4 : STD_LOGIC_VECTOR ( 5 downto 0):= (others => '0');


signal cnt_Signal_i : STD_LOGIC_VECTOR ( 12 downto 0):= (others => '0');
signal cnt_Signal_2_i : STD_LOGIC_VECTOR ( 6 downto 0):= (others => '0');
signal cnt_Signal_3_i : STD_LOGIC_VECTOR ( 6 downto 0):= (others => '0');
signal cnt_Signal_4_i : STD_LOGIC_VECTOR ( 6 downto 0):= (others => '0');

signal flag_Baseline_Avr : std_logic:='0';

signal cnt_Signal_S : STD_LOGIC_VECTOR ( 10 downto 0);
signal cnt_Signal_Before : STD_LOGIC_VECTOR ( 10 downto 0);
signal cnt_Signal_Before_Before : STD_LOGIC_VECTOR ( 10 downto 0);
signal cnt_Signal_Before_Before_Before : STD_LOGIC_VECTOR ( 10 downto 0);

signal cnt_Baseline_Count :  integer range 0 to 500000000:=0;

signal cnt_Baseline_Undershoot : std_logic_VECTOR ( 13 downto 0 ):= (others => '0');  

signal cnt_init : std_logic:='0';

signal cnt_flag_subtraction : STD_LOGIC_VECTOR ( 2 downto 0):= (others => '0');

signal max_Ch_Data_subtraction: std_logic_vector(13 downto 0):=(others => '0'); 
signal min_Ch_Data_subtraction: std_logic_vector(13 downto 0):=(others => '0');

signal cnt_pileup : std_logic_vector( 5 downto 0);
signal cnt_divide : STD_LOGIC_VECTOR ( 4 downto 0):= (others => '0');
signal cnt_pileup_sequence : std_logic_vector( 2 downto 0);
signal flag_Baseline_true : std_logic:='0';
signal D_Pileup_Before_pre : std_logic_vector(10 downto 0);
signal flag_Thresh_Flot : std_logic_vector(2 downto 0):="000";
signal flag_Pileup_get : STD_LOGIC :='0';
signal cnt_flag_Avr  : std_logic_vector(9 downto 0);

signal data_in_large : STD_LOGIC_VECTOR ( 17 downto 0):= (others => '0');
signal Baseline_Add : std_logic_vector(17 downto 0):=(others => '0');
signal CH_Signal_Add : std_logic_vector(17 downto 0):=(others => '0');
signal Ch_Data_subtraction_T : std_logic_vector(13 downto 0):=(others => '0');
signal CH_Signal_Baseline_T : STD_LOGIC_VECTOR ( 13 downto 0 ):= (others => '0');  
signal CH_Signal_Adder : std_logic_vector(30 downto 0):=(others => '0'); 
signal CH_Signal_Adder_Com : std_logic_vector(30 downto 0):=(others => '0'); 
signal CH_Signal_ADD_Pre: std_logic_vector(13 downto 0):=(others => '0');

signal Baseline_Search: std_logic:='0';
signal Baseline_Find: std_logic:='0';

--------------------------------------------------------------------------------
--signal Threshold :  STD_LOGIC_VECTOR( 10 downto 0) := "00000001000";
--
--signal Signal_TIME: STD_LOGIC_Vector( 6 downto 0) := "0010010";
--
constant base_commonlimit      : STD_LOGIC_VECTOR( 10 downto 0) := "00000000011";
constant base_upperlimit : STD_LOGIC_VECTOR( 10 downto 0) := "00000000110";
constant base_lowerlimit : STD_LOGIC_VECTOR( 10 downto 0) := "00000000110";


signal Data_base_upperlimit :  STD_LOGIC_VECTOR( 10 downto 0) := base_commonlimit;
signal Data_base_lowerlimit :  STD_LOGIC_VECTOR( 10 downto 0) := base_commonlimit;

signal Ch_Data_subtraction_all_stable: std_logic_vector(13 downto 0):=(others => '0');
signal Ch_Data_subtraction_all_stable_done: std_logic_vector(13 downto 0):=(others => '0');
signal baseline_stable_check: std_logic:= '0';
signal Baseline_undershoot_cnt : integer:= 0;
signal Baseline_Check_cnt      : integer:= 0;
signal Baseline_Undershoot : std_logic:='0';
signal PSD_Factor_bit_1d : std_logic:='0';
signal PSD_Factor_bit_2d : std_logic:='0';
signal signal_ORT : std_logic:='0';
signal ADC_ORT_pipe : std_logic_vector(1 downto 0):="00";

--------------------------------------------------------------------------------
type Master_state is ( Pileup_idle , Pileup_peak , Pileup_normal , Pileup_get , Pileup_exp, Pileup_trans);
signal Pileup_state : Master_state;
attribute mark_debug : string;
attribute mark_debug of data_in_Prompt : signal is "true";
attribute mark_debug of CH_S_PSD_delay  : signal is "true";
attribute mark_debug of CH_S_PSD_Prompt  : signal is "true";
attribute mark_debug of PSD_En  : signal is "true";
attribute mark_debug of data_in_delayed : signal is "true";
attribute mark_debug of PSD_Factor_bit_2d : signal is "true";
attribute mark_debug of dout_CH : signal is "true";
attribute mark_debug of cnt_Signal_S : signal is "true";
attribute mark_debug of Ch_Data_subtraction_all : signal is "true";
attribute mark_debug of F_Pileup : signal is "true";
attribute mark_debug of Pileup_state : signal is "true";
attribute mark_debug of flag_CH_Neutron : signal is "true";




     
  
attribute mark_debug of data_in : signal is "true";


begin

CH_Signal_Adder_Com_out     <= CH_Signal_Adder_Com;
--Baseline_num                <= Ch_Data_subtraction_all;
Ch_Data_subtraction_all_out <= Ch_Data_subtraction_all;
Ch_Data_subtraction_all_Pre_out <= Ch_Data_subtraction_all_1d;
Ch_Data_subtraction_all_Pre1_out <= Ch_Data_subtraction_all_2d;
cnt_Signal_i_out <= cnt_Signal_i;


process(acq_start,clk)  -- metastable remove
begin
    if rising_edge(clk) then
        PSD_Factor_bit_1d <= PSD_Factor_bit;
        PSD_Factor_bit_2d <= PSD_Factor_bit_1d;
       -- Ch_Data_subtraction_all_1 <= Ch_Data_subtraction_all;
    end if;
end process;    

--Signal_data_on <= (Signal_data_on1)and(Signal_data_on2)and(Signal_data_on3);--and(Signal_data_on4)and(Signal_data_on5)and(Signal_data_on6)and(Signal_data_on7)and(Signal_data_on8);
process(acq_start,clk)
begin
	if acq_start = '0' then
	base_refresh1 <= '0'; base_refresh2 <= '0'; base_refresh3 <= '0'; base_refresh4 <= '0'; base_refresh5 <= '0'; base_refresh6 <= '0'; base_refresh7 <= '0'; base_refresh8 <= '0';
	Signal_data_on1 <= '0';
	Signal_data_on2 <= '0';
	Signal_data_on3 <= '0';
	Signal_data_on4 <= '0';
	Signal_data_on5 <= '0';
	dout<= (others=>'0');
	Pileup_state<=Pileup_idle;
	T_flag_CH <= '0';
	flag_CH<='0';	
	flag_Find_Baseline<="000";
	flag_Noise_Baseline <= '0'; 
	flag_Baseline_true<='0';
--	flag_data_stop <='0';
   cnt_Baseline_Count<= 0;
	cnt_Signal<= (others=>'0');
	cnt_Signal_2<= (others=>'0');
	cnt_Signal_3<= (others=>'0');
	cnt_Signal_4<= (others=>'0');
	cnt_Signal_i<= (others=>'0');
	cnt_Signal_2_i<= (others=>'0');
	cnt_Signal_3_i<= (others=>'0');
	cnt_Signal_4_i<= (others=>'0');
	
    D_Pileup_Before_1<= (others=>'0');	
    D_Pileup_Before_2<= (others=>'0');	    
    D_Pileup_Before_3<= (others=>'0');		
    D_Pileup_Before_4<= (others=>'0');		
    D_Pileup_Before_5<= (others=>'0');		
	D_Pileup<= (others=>'0');	
	D_Pileup_Before<= (others=>'0');	
	D_Pileup_Before_Before<= (others=>'0');		
	D_Pileup_Before_Before_Before<= (others=>'0');		
	D_Pileup_Before_Before_Before_Before<= (others=>'0');		

	 max_Baseline_Add <= (others=>'0');	
  min_Baseline_Add <= (others=>'0');	
 Baseline_Avr_cnt<= (others=>'0');	
 Ch_Data_subtraction_all_Avr<= (others=>'0');	
	
	
	cnt_flag_subtraction<= (others=>'0');
	cnt_flag_Avr <= "0000000000";	
	PSD_Counter<="0000000";
	 Baseline_Undershoot <='0';
 Baseline_Search<='0';
 Baseline_Find<='0';	 
 flag_CH_Neutron<='0';
	 cnt_Baseline_Undershoot<= (others=>'0');	
	PSD_en<='0';
	
	Saturation_over_cnt<=0;
	Saturation_over<='0';
	i_ort_en<="00";
	elsif rising_edge(clk) then
	 
	
		i_ort_en( 0 ) <= ADC_ORT;
		i_ort_en( 1 ) <= i_ort_en( 0 );
        
		if i_ort_en( 0 ) > i_ort_en( 1 ) then --Data acq_1 start from unit
			Saturation_over <= '1';	
		end if;
        Saturation_over_pipe <= Saturation_over_pipe(0)&Saturation_over;
        
        if Saturation_over = '1' then
--            if Saturation_over_cnt = 5000 then
            if CH_Signal_Baseline< Threshold  then
                Saturation_over<='0';
                Saturation_over_cnt <= 0;
            else
                Saturation_over_cnt<=Saturation_over_cnt+1;
            end if;
         end if;   
        if Saturation_over_pipe = "01" then
            trans_stay<= '1';
        end if;

	
	if Baseline_Find ='0' then	
        if cnt_Baseline_Count = 5000 then --100US
         
            cnt_Baseline_Count<=0;
            Baseline_Search<='1';
            Baseline_Find<='1';
        else       	
            cnt_Baseline_Count<=cnt_Baseline_Count+1;
        end if;
    end if;
if flag_Baseline_true ='0'then

                            if(baseline_stable_check = '1') then
                           
                                 if(baseline_check_cnt > 5) then -- 1ms : 50000    10u , 0.01m :500
                                    
                                    baseline_stable_check <= '0';
--                                    baseline_undershoot_cnt <= 0;
                                    Ch_Data_subtraction_all <= Ch_Data_subtraction_all_stable_done;
                                    flag_Baseline_true <= '1';
                                else
                                    if((Ch_Data_subtraction_all_stable - "00000000001000"  <= Ch_Data_subtraction_all_stable_done)and   -- 01100 : 3
                                      Ch_Data_subtraction_all_stable_done <= (Ch_Data_subtraction_all_stable + "00000000001000")) then  -- 01100 : 3
--                                      baseline_undershoot_cnt <= baseline_undershoot_cnt + 1;
                                    else  
                                      baseline_check_cnt <= 0;
                                      baseline_stable_check   <= '0';
                                    end if;
                                end if;
                        end if; 


							if cnt_Signal_i= 0  then			
									cnt_Signal_i<=cnt_Signal_i+1;
									Baseline_Add<= (others=>'0');
									CH_Signal_Adder<=data_in+"0000000000000000000000000000000";
														
							       max_Baseline_Add<=data_in;		
							       min_Baseline_Add<=data_in;	
							elsif cnt_Signal_i = 512 then	
                               
								cnt_Signal_i<=cnt_Signal_i+1;
							CH_Signal_Adder_Com<=CH_Signal_Adder;	
							
							elsif cnt_Signal_i = 513 then	
							cnt_Signal_i<=cnt_Signal_i+1;								
                                        
							elsif cnt_Signal_i = 514 then	
--							    Ch_Data_subtraction_all        <= CH_Signal_Adder_Com(22 downto 9);	
                                if( baseline_stable_check = '0')then
                                    baseline_stable_check <= '1';
                                    Baseline_Check_cnt    <= 0;
                                    Ch_Data_subtraction_all_stable_done <= CH_Signal_Adder_Com(22 downto 9);

                                else    
                                    Baseline_Check_cnt <= Baseline_Check_cnt + 1;
                                    
                                end if;    
                                Ch_Data_subtraction_all_stable<= CH_Signal_Adder_Com(22 downto 9);
--                                Ch_Data_subtraction_all<= CH_Signal_Adder_Com(22 downto 9);
--							    flag_Baseline_true <= '1';

								cnt_Signal_i<= (others=>'0');
								Baseline_Add<= (others=>'0');
								Baseline_Search <='0';
							else
							    CH_Signal_Adder<=data_in+CH_Signal_Adder;
								cnt_Signal_i<=cnt_Signal_i+1;
								
									
								max_Baseline_Add<=maximum(data_in,max_Baseline_Add);
								min_Baseline_Add<=minimum(data_in,min_Baseline_Add);
							end if;		

						
				

				
		end if;
	
	
			if flag_Baseline_true = '1' then
				                
				                
                                if((Baseline_Undershoot = '1')) then
                                        if(Baseline_undershoot_cnt = 3000) then
                                            Baseline_Undershoot<= '0';
                                            baseline_check_cnt <= 0;
                                            baseline_stable_check   <= '0';
                                            cnt_Signal_i <= (others => '0');
                                            Baseline_undershoot_cnt <= 0; 
                                        else
                                            Baseline_undershoot_cnt <= Baseline_undershoot_cnt + 1;
                                        end if;    
                                        
                                else
                                    if(baseline_stable_check = '1') then
                                         if(baseline_check_cnt > 10) then -- 1ms : 50000    10u , 0.01m :500
                                        
                                            Baseline_Check_cnt    <= 0;
                                            baseline_stable_check <= '0';
--                                            baseline_undershoot_cnt <= 0;
                                            Ch_Data_subtraction_all <= Ch_Data_subtraction_all_stable_done;
        --                                    flag_Baseline_true <= '1';
                                        else
                                            if((Ch_Data_subtraction_all_stable - "00000000001100"  <= Ch_Data_subtraction_all_stable_done)and   -- 01000 : 2
                                                Ch_Data_subtraction_all_stable_done <= (Ch_Data_subtraction_all_stable + "00000000001100")) then  -- 01000 : 2
                                                
                                            else  
                                              baseline_check_cnt <= 0;
                                              baseline_stable_check   <= '0';
                                            end if;
                                        end if;
                                   end if; 
                                    
                                   if cnt_Signal_i= 0 then			
                                            cnt_Signal_i<=cnt_Signal_i+1;
                                            Baseline_Add<= (others=>'0');
                                            CH_Signal_Adder<=data_in+"0000000000000000000000000000000";
                
                                    elsif cnt_Signal_i = "0001000000000" then	
                                       
                                            cnt_Signal_i<=cnt_Signal_i+1;
                                            CH_Signal_Adder_Com<=CH_Signal_Adder;
                                                
                                    elsif cnt_Signal_i =  "0001000000001"  then	
                                         cnt_Signal_i<=cnt_Signal_i+1;								
                                           CH_Signal_Adder <= (others => '0');     
                                    elsif cnt_Signal_i = "0001000000010"  then	
        
                                       if( baseline_stable_check = '0')then
                                            baseline_stable_check <= '1';
                                            Baseline_Check_cnt    <= 0;
                                            Ch_Data_subtraction_all_stable_done <= CH_Signal_Adder_Com(22 downto 9);
                                        else
                                            Baseline_Check_cnt <= Baseline_Check_cnt + 1;
                                        end if;    
                                        Ch_Data_subtraction_all_stable<= CH_Signal_Adder_Com(22 downto 9);
        
                                      
        --								Baseline_Find <='0';
                                        cnt_Signal_i<= (others=>'0');
                                        Baseline_Add<= (others=>'0');
                                        Baseline_Search <='0';
                                    else
                                        CH_Signal_Adder<=data_in+CH_Signal_Adder;
                                        cnt_Signal_i<=cnt_Signal_i+1;
                                        
                                            
                                    
                                    end if;	
                 end if;     
                    
                            
							
--					Ch_Data_subtraction_T<=Ch_Data_subtraction_all_1;
                if data_in >  Ch_Data_subtraction_all+Data_subtraction then
					CH_Signal_Baseline <= data_in - Ch_Data_subtraction_all-Data_subtraction;
				else
					CH_Signal_Baseline<="00000000000000";
				end if;

		                   		
			
		else
			CH_Signal_Baseline<= (others=>'0');
		end if;					
--				

		case Pileup_state is
		when Pileup_idle =>
		flag_CH<='0';
		if flag_Baseline_true = '1'then	
			
			if CH_Signal_Baseline> Threshold then
			   
					flag_start <= '1';
					Pileup_state  <= Pileup_peak;
					cnt_Signal_S<="00000000001";
					CH_S<="0000000000000000000000"+CH_Signal_Baseline+CH_Baseline_Pre_1+CH_Baseline_Pre_2+CH_Baseline_Pre_3+CH_Baseline_Pre_4;
					CH_S_PSD_Prompt<="0000000000000000000000"+CH_Signal_Baseline+CH_Baseline_Pre_1;
					CH_S_PSD_Delay<="0000000000000000000000";
					CH_S_1<= (others=>'0');
				flag_Baseline_Avr<='0';
--				cnt_Signal_i<= (others=>'0');
 
			else 
			flag_Baseline_Avr<='1';
			CH_Baseline_Pre_1<=CH_Signal_Baseline;
			CH_Baseline_Pre_2<=CH_Baseline_Pre_1;
			CH_Baseline_Pre_3<=CH_Baseline_Pre_2;
			CH_Baseline_Pre_4<=CH_Baseline_Pre_3;
		  
			

			end if;	
		end if;	
		when Pileup_peak =>	
		flag_CH<='0';
			D_Pileup<=CH_Signal_Baseline;
			D_Pileup_Before<=D_Pileup;

			
--		cnt_Signal_i<= (others=>'0');
		CH_S_PSD_Prompt<= CH_S_PSD_Prompt+CH_Signal_Baseline;		
		
	
            if cnt_Signal_S <= Signal_TIME then
                        if CH_Signal_Baseline< Threshold  then
                            Pileup_state<=Pileup_idle;
                            cnt_Signal_S<="00000000000";
                            CH_S<="0000000000000000000000";	
    --						Baseline_Undershoot<='1';
                            cnt_Baseline_Undershoot<=(others=>'0');			
                        flag_Noise_Baseline <= '1'; 
    --                        Baseline_Find <='0';
                        else
                            
                            cnt_Signal_S<=cnt_Signal_S+1;
                            CH_S<=CH_S+CH_Signal_Baseline;
                        end if;	
            else
                if D_Pileup(13 downto 3)> CH_Signal_Baseline(13 downto 3) and D_Pileup_Before(13 downto 3)> D_Pileup(13 downto 3) then 
                                
                    F_Pileup <= D_Pileup;
                    D_Pileup_Before_1<= (others=>'0');	
                    D_Pileup_Before_2<= (others=>'0');	    
                    D_Pileup_Before_3<= (others=>'0');		
                    D_Pileup_Before_4<= (others=>'0');		
                    D_Pileup_Before_5<= (others=>'0');		
                    D_Pileup<= (others=>'0');	
                    D_Pileup_Before<= (others=>'0');	
                    D_Pileup_Before_Before<= (others=>'0');		
                    D_Pileup_Before_Before_Before<= (others=>'0');		
                    D_Pileup_Before_Before_Before_Before<= (others=>'0');							
                    
                    
                        Pileup_state<=Pileup_normal;
                        
                end if;
                CH_S<=CH_S+CH_Signal_Baseline;
                cnt_Signal_S<=cnt_Signal_S+1;
            end if;		

			
		

			
		
		when Pileup_Normal =>	
		flag_CH<='0';
			D_Pileup<=CH_Signal_Baseline;
			D_Pileup_Before<=D_Pileup;
			D_Pileup_Before_Before<=D_Pileup_Before;			
			D_Pileup_Before_Before_Before<=D_Pileup_Before_Before;
			D_Pileup_Before_Before_Before_Before<=D_Pileup_Before_Before_Before;
			D_Pileup_Before_1<=D_Pileup_Before_Before_Before_Before;			
			D_Pileup_Before_2<=D_Pileup_Before_1;
			D_Pileup_Before_3<=D_Pileup_Before_2;			
			D_Pileup_Before_4<=D_Pileup_Before_3;
			D_Pileup_Before_5<=D_Pileup_Before_4;
			
			cnt_Signal_Before_Before_Before<=cnt_Signal_Before;
			cnt_Signal_Before_Before<=cnt_Signal_Before;
			cnt_Signal_Before<=cnt_Signal_S;
--			D_Pileup<=CH_Signal_Baseline;
--			D_Pileup_Before<=D_Pileup;
--			D_Pileup_Before_Before<=D_Pileup_Before;
			
--			D_Pileup_Before_Before_Before<=D_Pileup_Before_Before;
--			D_Pileup_Before_Before_Before_Before<=D_Pileup_Before_Before_Before;
			
--			cnt_Signal_Before_Before_Before<=cnt_Signal_Before;
--			cnt_Signal_Before_Before<=cnt_Signal_Before;
--			cnt_Signal_Before<=cnt_Signal_S;
        	if cnt_Signal_S <= data_in_Prompt_window then
                     CH_S_PSD_Prompt<= CH_S_PSD_Prompt+CH_Signal_Baseline;
            end if;

                        if   cnt_Signal_S > data_in_Prompt_window and cnt_Signal_S <= data_in_delayed_window then
                           CH_S_PSD_Delay<=CH_S_PSD_Delay+CH_Signal_Baseline;
                        end if;	
					
	
                if D_Pileup(13 downto 4)< CH_Signal_Baseline(13 downto 4) and D_Pileup_Before(13 downto 4)< D_Pileup(13 downto 4) and 
                        D_Pileup_Before_Before(13 downto 4)< D_Pileup_Before(13 downto 4) and D_Pileup_Before_Before_Before(13 downto 4)< D_Pileup_Before_Before(13 downto 4) and --then
                        D_Pileup_Before_Before_Before(13 downto 4) > D_Pileup_Before_Before_Before_Before(13 downto 4) and   D_Pileup_Before_1(13 downto 4) >= D_Pileup_Before_Before_Before_Before(13 downto 4) then
                            
                        cnt_pileup<=cnt_Signal_S(5 downto 0); 
                        
                        D_Pileup<="00000000000000";
                        D_Pileup_Before<="00000000000000";
                        D_Pileup_Before_Before<="00000000000000";
                        D_Pileup_Before_Before_Before<="00000000000000";
                                
                    Pileup_state<=Pileup_get;	
                            F_T_Pileup<=CH_Signal_Baseline;	
                            cnt_Signal_S <= "00000000000";
                    else
                    
        --		  if D_Pileup(13 downto 6)< CH_Signal_Baseline(13 downto 6) and 
        --				    D_Pileup_Before(13 downto 6)< D_Pileup(13 downto 6) and 
        --				    D_Pileup_Before(13 downto 6) < D_Pileup_Before_Before(13 downto 6) and 
        --				    D_Pileup_Before_Before(13 downto 6) < D_Pileup_Before_Before_Before(13 downto 6) then
                    
        --                        cnt_pileup<=cnt_Signal_S(5 downto 0); 
                                
        --                        D_Pileup<="00000000000000";
        --                        D_Pileup_Before<="00000000000000";
        --                        D_Pileup_Before_Before<="00000000000000";
        --                        D_Pileup_Before_Before_Before<="00000000000000";
                                        
        --                        Pileup_state<=Pileup_get;	
        --                            F_T_Pileup<=CH_Signal_Baseline;	
        --                            cnt_Signal_S <= (others=>'0');
        --			else
                            if cnt_Signal_S=  "1001011000"  then
                            
        --                            Baseline_Find <='0';
        --                    if CH_Signal_Baseline< Threshold  then
        --						    Baseline_Undershoot<='1';
                                    cnt_Baseline_Undershoot<=(others=>'0');	 
                                    flag_start <= '0';
                                    Pileup_state<=Pileup_trans; 
                                    dout<=CH_S;  
                                    flag_Noise_Baseline <= '1';  
                                    T_flag_CH<='1';
                                    cnt_Signal_S <= "00000000000";
                                    data_in_Prompt<=CH_S_PSD_delay(20 downto 3);
                                    data_in_delayed<=CH_S_PSD_delay(20 downto 3)+CH_S_PSD_Prompt(20 downto 3);	
                                    PSD_En<='1';			
                                    PSD_Counter<="0000000";			
                                
                        else	
                        
                                
                                
                                cnt_Signal_S<=cnt_Signal_S+1;
                                CH_S<=CH_S+CH_Signal_Baseline;
                                
                        end if;	
                    end if;
		
		
	

	when Pileup_get =>
flag_CH<='0';
			D_Pileup<=CH_Signal_Baseline;
			D_Pileup_Before<=D_Pileup;
			D_Pileup_Before_Before<=D_Pileup_Before;
			Pileup_ce<='1';	

        		if cnt_Signal_S <= data_in_Prompt_window then
			       CH_S_PSD_Prompt<= CH_S_PSD_Prompt+CH_Signal_Baseline;
			     elsif cnt_Signal_S <= data_in_delayed_window then
			        CH_S_PSD_Delay<=CH_S_PSD_Delay+CH_Signal_Baseline;
			     end if;
			     
		
		if F_T_Pileup< CH_Signal_Baseline then
			F_T_Pileup<=CH_Signal_Baseline;
			
		end if;	 
				if CH_Signal_Baseline< Threshold  then
						if F_Pileup(12 downto 5) < F_T_Pileup then
							Pileup_state<=Pileup_idle;
							Pileup_ce<='0';
							cnt_Signal_S <= (others =>'0');
--							Baseline_Undershoot<='1';
						    cnt_Baseline_Undershoot<=(others=>'0');	
						else  
						    Pileup_ce<='0';  
							dout<=CH_S+CH_S_1;
							Pileup_state<=Pileup_trans;
							cnt_Signal_S <= (others =>'0');
							Baseline_Undershoot<='1';
					     	
							data_in_Prompt<=(others =>'0');
							data_in_delayed<=(others =>'0');	
--							PSD_En<='1';			
							PSD_Counter<=(others =>'0');								     	
						end if;
					flag_Noise_Baseline <= '1'; 
				else	
				CH_S_1<=CH_S_1+CH_Signal_Baseline;
				cnt_Signal_S<=cnt_Signal_S+1;
				end if;
		
		
		when Pileup_exp =>
				flag_CH<='0';
				if CH_Signal_Baseline< Threshold  then	
				
					flag_start <= '0';
					Pileup_state<=Pileup_trans;
					cnt_Signal_S <= "00000000000";
				else
					cnt_Signal_S<=cnt_Signal_S+1;
					CH_S<=CH_S+CH_Signal_Baseline;
				end if;	
			
		when Pileup_trans =>
		if(Saturation_over = '1') then
		
		else
		  if(trans_stay = '1') then
		         PSD_Counter<="0000000";
                 flag_CH<='0';
                 T_flag_CH<='0';
                 flag_CH_Neutron<='0';   
                 Pileup_state<=Pileup_idle;
                 cnt_divide<="00000";
                 Baseline_Undershoot<='1';
                 cnt_Baseline_Undershoot<=(others=>'0');	
                 PSD_En<='0';	
                 trans_stay <= '0';		  
		  else
                if PSD_Counter = "11010" then  -- 120ns
                   if dout > "0000111111111" and dout < "11111111111111111111"  then -- Ch 10 under cut
--                        if PSD_Factor_bit_2d = '0'  or dout < "10100010100111111111" then  
                                   
                                if cnt_divide="1010" then
                                        PSD_Counter<="0000000";
                                        flag_CH<='0';
                                        T_flag_CH<='0';
                                        Pileup_state<=Pileup_idle;
                                        cnt_divide<="00000";
                                        Baseline_Undershoot<='1';
                                        cnt_Baseline_Undershoot<=(others=>'0');	
        --                                cnt_Signal_i<= (others=>'0');	
                                        PSD_En<='0';			
                                    elsif cnt_divide="100" then
                                        flag_CH<='0';
                                        cnt_divide<=cnt_divide+'1';
                                    elsif cnt_divide="001" then
        
                                        dout_CH<=dout(18 downto 8);  
        --                                dout_CH<="00"&dout(18 downto 8);
                                        cnt_divide<=cnt_divide+'1';
                                    elsif cnt_divide="000" then
                                        
                                        flag_CH<='1';
                                        cnt_divide<=cnt_divide+'1';
                                    else
                                        cnt_divide<=cnt_divide+'1';
                                    end if;
--                               else 
--                                    if cnt_divide="1010" then
--                                        PSD_Counter<="0000000";
--                                        flag_CH_Neutron<='0';                        
--                                        Pileup_state<=Pileup_idle;
--                                        cnt_divide<="00000";
--                                        Baseline_Undershoot<='1';
--                                        cnt_Baseline_Undershoot<=(others=>'0');	
--                                        cnt_Signal_i<= (others=>'0');
--                                        PSD_En<='0';				
--                                    elsif cnt_divide="011" then
--                                         flag_CH_Neutron<='0';  
--                                        cnt_divide<=cnt_divide+'1';
            
--                                    elsif cnt_divide="000" then
--                                        dout_CH<="00"&dout(19 downto 9);  -- only for test!
--                                       flag_CH_Neutron<='1';
--                                        cnt_divide<=cnt_divide+'1';
--                                    else
--                                        cnt_divide<=cnt_divide+'1';
--                                    end if;
              
              
                               
--                               end if;     
        
                                         
                            else
                        --		flag_data_stop<='0';
                                dout<="0000000000000000000000";
                                Pileup_state<=Pileup_idle;
                                T_flag_CH<='0';
                                PSD_Counter<="0000000";
                                PSD_En<='0';
                            end if;
                            
                 else
                    PSD_Counter<=  PSD_Counter + '1';
                 end if;    
           end if;        -- trans_stay
        end if; --saturation over
		when others => Pileup_state <= Pileup_idle;
		end case;		
	end if;
 end process;
 

end Behavioral;


 
