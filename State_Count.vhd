----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:39:25 10/30/2017 
-- Design Name: 
-- Module Name:    State_Count - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity State_Count is
Port(
	CLK,Rstb : in std_logic;
	i1s : in std_logic;
	I : in std_logic;
	oDigit1,oDigit2,oDigit3,oDigit4 : out std_logic_vector(3 downto 0)
);
end State_Count;

architecture Behavioral of State_Count is
	signal rCnt1 : std_logic_vector(3 downto 0);
	signal rCnt2 : std_logic_vector(3 downto 0);
	signal rCnt3 : std_logic_vector(3 downto 0);
	signal rCnt4 : std_logic_vector(3 downto 0);
begin

	oDigit1 <= rCnt1;
	oDigit2 <= rCnt2;
	oDigit3 <= rCnt3;
	oDigit4 <= rCnt4;
	
	u_rCnt1 : Process(CLK,Rstb)
	Begin
		if(Rstb='0') then
			rCnt1 <= (others => '0');
		elsif(rising_edge(CLK)) then
			if(I='1' and rCnt1 = "1111") then
				rCnt1 <= (others => '0');
			elsif(I='1') then
				rCnt1 <= rCnt1 + 1;
			else
				rCnt1 <= rCnt1;
			end if;
		end if;
	End Process;
	
	u_rCnt2 : Process(CLK,Rstb)
	Begin
		if(Rstb='0') then
			rCnt2 <= (others => '0');
		elsif(rising_edge(CLK)) then
			if(i1s='1' and rCnt2 = "1111") then
				rCnt2 <= (others => '0');
			elsif(i1s='1') then
				rCnt2 <= rCnt2 + 1;
			else
				rCnt2 <= rCnt2;
			end if;
		end if;
	End Process;
	
	u_rCnt3 : Process(CLK,Rstb)
	Begin
		if(Rstb='0') then
			rCnt3 <= (others => '1');
		elsif(rising_edge(CLK)) then
			if(i1s='1' and rCnt3 = "0000") then
				rCnt3 <= (others => '1');
			elsif(i1s='1') then
				rCnt3 <= rCnt3 - 1;
			else
				rCnt3 <= rCnt3;
			end if;
		end if;
	End Process;
	
	u_rCnt4 : Process(CLK,Rstb)
	Begin
		if(Rstb='0') then
			rCnt4 <= (others => '0');
		elsif(rising_edge(CLK)) then
			if(i1s='1' and rCnt1 = rCnt4) then
				rCnt4 <= (others => '0');
			elsif(i1s='1') then
				rCnt4 <= rCnt4 + 1;
			else
				rCnt4 <= rCnt4;
			end if;
		end if;
	End Process;

end Behavioral;

