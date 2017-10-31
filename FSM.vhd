----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:06:30 10/30/2017 
-- Design Name: 
-- Module Name:    FSM - Behavioral 
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

entity FSM is
Port(
	CLK,Rstb : in std_logic;
	I : in std_logic;
	iDigit1,iDigit2,iDigit3,iDigit4 : in std_logic_vector(3 downto 0);
	oDigit1,oDigit2,oDigit3,oDigit4 : out std_logic_vector(3 downto 0)
);
end FSM;

architecture Behavioral of FSM is
	type state_type is (S0,S1,S2,S3);
	signal curr_state,next_state : state_type;
begin

	oDigit1 <= 	iDigit1 when curr_state = S0 else
					iDigit4 when curr_state = S1 else
					iDigit3 when curr_state = S2 else
					iDigit2;
	
	oDigit2 <= 	iDigit2 when curr_state = S0 else
					iDigit1 when curr_state = S1 else
					iDigit4 when curr_state = S2 else
					iDigit3;
	
	oDigit3 <= 	iDigit3 when curr_state = S0 else
					iDigit2 when curr_state = S1 else
					iDigit1 when curr_state = S2 else
					iDigit4;
	
	oDigit4 <= 	iDigit4 when curr_state = S0 else
					iDigit3 when curr_state = S1 else
					iDigit2 when curr_state = S2 else
					iDigit1;
	
	u_rState : Process(CLK,Rstb)
	Begin
		if(Rstb='0') then
			curr_state <= S0;
		elsif(rising_edge(CLK)) then
			curr_state <= next_state;
		end if;
	End Process;
	
	u_Next_State : Process(curr_state,I)
	Begin
		case curr_state is
			when S0 => 	if(I='1') then
								next_state <= S1;
							else
								next_state <= S0;
							end if;
			
			when S1 => 	if(I='1') then
								next_state <= S2;
							else
								next_state <= S1;
							end if;
			
			when S2 => 	if(I='1') then
								next_state <= S3;
							else
								next_state <= S2;
							end if;
			
			when S3 => 	if(I='1') then
								next_state <= S0;
							else
								next_state <= S3;
							end if;
			
			when others => next_state <= S0;
		end case;
	End Process;

end Behavioral;

