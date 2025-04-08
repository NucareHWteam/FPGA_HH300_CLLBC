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

entity radiation_SCA14bit is
port(
	clk: in std_logic;
	rst: in std_logic;
	acq_start: IN std_logic;	
	--CH_ACQ: In std_logic;
	--ADC_ORT : in std_logic;
	--flag_data_stop : inout std_logic;
	flag_start : out std_logic;
	Threshold : In STD_LOGIC_VECTOR( 12 downto 0);
	Signal_TIME: In STD_LOGIC_Vector( 6 downto 0);
	Data_subtraction : In STD_LOGIC_VECTOR( 12 downto 0) ;
	--Ch_Data_subtraction_all : in std_logic_vector(11 downto 0);
 
	data_in: in std_logic_vector(13 downto 0);
	dout_CH: out std_logic_vector(12 downto 0);
	flag_CH : out std_logic
	);	
end radiation_SCA14bit;

architecture Behavioral of radiation_SCA14bit is
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
signal Saturation_over_cnt :  integer range 0 to 500000:=0;


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

signal Baseline_Undershoot : std_logic:='0';
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
signal Baseline_undershoot_cnt : integer;
signal Baseline_Check_cnt      : integer;
--------------------------------------------------------------------------------
--signal Threshold :  STD_LOGIC_VECTOR( 10 downto 0) := "00000001000";
--
--signal Signal_TIME: STD_LOGIC_Vector( 6 downto 0) := "0010010";
--
--signal Data_subtraction :  STD_LOGIC_VECTOR( 10 downto 0) := "00000000000";

--------------------------------------------------------------------------------
type Master_state is ( Pileup_idle , Pileup_peak , Pileup_normal , Pileup_get , Pileup_exp, Pileup_trans);
signal Pileup_state : Master_state;
begin


i_Moving_Avr : Moving_Avr 
port map(  
  i_clk                     =>clk,
  i_rstb                     =>acq_start,
  i_sync_reset               =>'0',
  -- input
  i_data_ena                =>flag_Baseline_Avr,
  i_data                     =>data_in,
  -- output
  o_data_valid              =>open,
  o_data                     =>data_in_Baseline);

--i_c_addsub_0 : c_addsub_0 
--port map( 
--			a => data_in,
--			b => Ch_Data_subtraction_T,
--			clk => clk,
--			ce => flag_Baseline_true,
--			s => CH_Signal_Baseline_T);

--i_Adder : c_addsub_1 
--port map(
--			a => data_in_large,
--			b => Baseline_Add,
--			clk => clk,
--			ce => acq_start,
--			s => CH_Signal_Add);



process(acq_start,clk)
begin
	if acq_start = '0' then
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
	cnt_flag_subtraction<= (others=>'0');
	cnt_flag_Avr <= "0000000000";	
	 Baseline_Undershoot <='0';
 Baseline_Search<='0';
 Baseline_Find<='0';	 
	 cnt_Baseline_Undershoot<= (others=>'0');	
	
	elsif rising_edge(clk) then
	
				CH_Signal<=data_in;
--CH_Signal_Baseline<= CH_Signal_Baseline_T;
		data_in_large <=  "0000"&data_in(13 downto 0);
	if Baseline_Find ='0' then	
        if cnt_Baseline_Count = 50000000 then
            cnt_Baseline_Count<=0;
            Baseline_Search<='1';
            Baseline_Find<='1';
        else       	
            cnt_Baseline_Count<=cnt_Baseline_Count+1;
        end if;
    end if;
if flag_Baseline_true ='0'then

                            if(baseline_stable_check = '1') then
                           
                                 if(baseline_check_cnt > 2) then -- 1ms : 50000    10u , 0.01m :500
                                    
                                    baseline_stable_check <= '0';
                                    baseline_undershoot_cnt <= 0;
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


							if cnt_Signal_i="0000000" then			
									cnt_Signal_i<=cnt_Signal_i+1;
									Baseline_Add<= (others=>'0');
									CH_Signal_Adder<=data_in+"0000000000000000000000000000000";
														
					
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
								
									
			
							end if;		

						
				

				
		end if;
	
	
			if flag_Baseline_true = '1' then
				        if(baseline_stable_check = '1') then
                           
                                 if(baseline_check_cnt > 5) then -- 1ms : 50000    10u , 0.01m :500
                                 
                                    Baseline_Check_cnt    <= 0;
                                    baseline_stable_check <= '0';
                                    baseline_undershoot_cnt <= 0;
                                    Ch_Data_subtraction_all <= Ch_Data_subtraction_all_stable_done;
--                                    flag_Baseline_true <= '1';
                                else
                                    if((Ch_Data_subtraction_all_stable - "00000000001100"  <= Ch_Data_subtraction_all_stable_done)and   -- 01000 : 2
                                      Ch_Data_subtraction_all_stable_done <= (Ch_Data_subtraction_all_stable + "00000000001100")) then  -- 01000 : 2
--                                      baseline_undershoot_cnt <= baseline_undershoot_cnt + 1;
                                    else  
                                      baseline_check_cnt <= 0;
                                      baseline_stable_check   <= '0';
                                    end if;
                                end if;
                        end if; 
                            
							if cnt_Signal_i="0000000" then			
									cnt_Signal_i<=cnt_Signal_i+1;
									Baseline_Add<= (others=>'0');
									CH_Signal_Adder<=data_in+"0000000000000000000000000000000";
		
							elsif cnt_Signal_i = "1000000000" then	
                               
								    cnt_Signal_i<=cnt_Signal_i+1;
							        CH_Signal_Adder_Com<=CH_Signal_Adder;	
							elsif cnt_Signal_i = "1000000001" then	
							     cnt_Signal_i<=cnt_Signal_i+1;								
                                        
							elsif cnt_Signal_i = "1000000010" then	

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
--					Ch_Data_subtraction_T<=Ch_Data_subtraction_all_1;
                if data_in >  Ch_Data_subtraction_all+Data_subtraction then
					CH_Signal_Baseline <= data_in - Ch_Data_subtraction_all-Data_subtraction;
				else
					CH_Signal_Baseline<="00000000000000";
				end if;

		                   		
			
		else
			CH_Signal_Baseline<= (others=>'0');
		end if;				

		case Pileup_state is
		when Pileup_idle =>
		flag_CH<='0';
		if flag_Baseline_true = '1' then			
			if CH_Signal_Baseline> Threshold then				
				
					flag_start <= '1';
					Pileup_state  <= Pileup_peak;
					cnt_Signal_S<="00000000001";
					CH_S<="0000000000000000000000"+CH_Signal_Baseline+CH_Baseline_Pre_1+CH_Baseline_Pre_2+CH_Baseline_Pre_3+CH_Baseline_Pre_4;
					CH_S_1<= (others=>'0');
				flag_Baseline_Avr<='0';
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

			
		cnt_Signal_i<= (others=>'0');

		
		if cnt_Signal_S <= Signal_TIME then
					if CH_Signal_Baseline< Threshold  then
						Pileup_state<=Pileup_idle;
						cnt_Signal_S<=(others => '0');
						CH_S<="0000000000000000000000";	
						Baseline_Undershoot<='1';
						cnt_Baseline_Undershoot<=(others=>'0');			
					flag_Noise_Baseline <= '1'; 
--                        Baseline_Find <='0';
					else
						
						cnt_Signal_S<=cnt_Signal_S+1;
						CH_S<=CH_S+CH_Signal_Baseline;
					end if;	
		else
			if D_Pileup(13 downto 2)> CH_Signal_Baseline(13 downto 2) and D_Pileup_Before(13 downto 2)> D_Pileup(13 downto 2) then 
							

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
			D_Pileup_Before_Before_Before_Before<=D_Pileup_Before_Before;
			
			cnt_Signal_Before_Before_Before<=cnt_Signal_Before;
			cnt_Signal_Before_Before<=cnt_Signal_Before;
			cnt_Signal_Before<=cnt_Signal_S;
					

			
			
		
			
			
					if cnt_Signal_S=  "1001011000"  then
				    
--                            Baseline_Find <='0';
--                    if CH_Signal_Baseline< Threshold  then
						    Baseline_Undershoot<='1';
						    cnt_Baseline_Undershoot<=(others=>'0');	
							flag_start <= '0';
							Pileup_state<=Pileup_trans;
							dout<=CH_S;
							flag_Noise_Baseline <= '1'; 
							T_flag_CH<='1';
							cnt_Signal_S <= "00000000000";
									
						
				else	
				
							
					
						
						cnt_Signal_S<=cnt_Signal_S+1;
						CH_S<=CH_S+CH_Signal_Baseline;
						
				end if;	
			
			
		
	

	when Pileup_get =>
flag_CH<='0';
			D_Pileup<=CH_Signal_Baseline;
			D_Pileup_Before<=D_Pileup;
			D_Pileup_Before_Before<=D_Pileup_Before;
			
		
		if F_T_Pileup< CH_Signal_Baseline then
			F_T_Pileup<=CH_Signal_Baseline;
			
		end if;	
				if CH_Signal_Baseline< Threshold  then
--						if F_Pileup(12 downto 5) < F_T_Pileup then
							Pileup_state<=Pileup_idle;
						
							cnt_Signal_S <= "00000000000";
							Baseline_Undershoot<='1';
						    cnt_Baseline_Undershoot<=(others=>'0');	
--						else  
--						    Pileup_ce<='0';  
--							dout<=CH_S+CH_S_1;
--							Pileup_state<=Pileup_trans;
--							cnt_Signal_S <= "00000000000";
--							Baseline_Undershoot<='1';
--					     	cnt_Baseline_Undershoot<="00000000000";
--							data_in_Prompt<=CH_S_PSD_Prompt(21 downto 6);
--							data_in_delayed<=CH_S_PSD_delay(21 downto 6)+CH_S_PSD_Prompt(19 downto 6);	
--							PSD_En<='1';			
--							PSD_Counter<="0000000";								     	
--						end if;
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
					cnt_Signal_S <= (others => '0');
				else
					cnt_Signal_S<=cnt_Signal_S+1;
					CH_S<=CH_S+CH_Signal_Baseline;
				end if;	
		
		when Pileup_trans =>
		
					if dout > "0000111111111" and dout < "11111111111111111111"  then -- Ch 10 under cut
                           
                        if cnt_divide="1010" then
                        
                                flag_CH<='0';
                                T_flag_CH<='0';
                                Pileup_state<=Pileup_idle;
                                cnt_divide<="00000";
                                Baseline_Undershoot<='1';
                                cnt_Baseline_Undershoot<=(others=>'0');	
                                cnt_Signal_i<= (others=>'0');	
                    		
                            elsif cnt_divide="100" then
                                flag_CH<='0';
                                cnt_divide<=cnt_divide+'1';
                            elsif cnt_divide="001" then

                              --  dout_CH<="00"&dout(19 downto 9);  -- only for test!
--                                dout_CH<="00"&dout(18 downto 8);
                                cnt_divide<=cnt_divide+'1';
                            elsif cnt_divide="000" then
                                
                                flag_CH<='1';
                                cnt_divide<=cnt_divide+'1';
                            else
                                cnt_divide<=cnt_divide+'1';
                            end if;
                      

                                 
                    else
                --		flag_data_stop<='0';
                        dout<="0000000000000000000000";
                        Pileup_state<=Pileup_idle;
                        T_flag_CH<='0';
            
                    end if;
		when others => Pileup_state <= Pileup_idle;
		end case;		
	end if;
 end process;
end Behavioral;
