----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:07:12 10/02/2017 
-- Design Name: 
-- Module Name:    ScanDigit - Behavioral 
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

entity ScanDigit is

Port(
	clk : in std_logic;
	rstb : in std_logic;
	
	i1ms : in std_logic;
	
	idigit1 : in std_logic_vector(3 downto 0);
	idigit2 : in std_logic_vector(3 downto 0);
	idigit3 : in std_logic_vector(3 downto 0);
	idigit4 : in std_logic_vector(3 downto 0);
	
	odigit : out std_logic_vector(3 downto 0);
	odata : out std_logic_vector(3 downto 0)
);

end ScanDigit;

architecture Behavioral of ScanDigit is

	signal rcnt : std_logic_vector(3 downto 0);
	signal rcnt1 : std_logic_vector(3 downto 0);
	signal rcnt2 : std_logic_vector(3 downto 0);
	signal rcnt3 : std_logic_vector(3 downto 0);
	signal rshift : std_logic_vector(3 downto 0);
	signal rshift1 : std_logic_vector(3 downto 0);
	signal rshift2 : std_logic_vector(3 downto 0);
	signal rshift3 : std_logic_vector(3 downto 0);

begin

	odigit <= rshift;
	
	odata <= idigit1 when rshift="0111" else
				idigit2 when rshift="1011" else
				idigit3 when rshift="1101" else
				idigit4;
	
	u_rCnt : Process(clk,rstb)
	Begin
		if(rstb='0') then
			rcnt <= (others => '0');
			rshift <= "0111";
		elsif(rising_edge(clk)) then
			if(rcnt=4 and i1ms='1') then
				rcnt <= (others => '0');
				rshift <= rshift(0) & rshift(3 downto 1);
			elsif(i1ms = '1') then
				rcnt <= rcnt + 1;
				rshift <= rshift;
			else
				rcnt <= rcnt;
				rshift <= rshift;
			end if;
		end if;
	end Process;
		
		
	u_rCnt1 : Process(clk,rstb)
	Begin
		if(rstb='0') then
			rcnt1 <= "0001";
			rshift1 <= "0111";
		elsif(rising_edge(clk)) then
			if(rcnt1=4 and i1ms='1') then
				rcnt1 <= (others => '0');
				rshift1 <= rshift1(0) & rshift1(3 downto 1);
			elsif(i1ms = '1') then
				rcnt1 <= rcnt1 + 1;
				rshift1 <= rshift1;
			else
				rcnt1 <= rcnt1;
				rshift1 <= rshift1;
			end if;
		end if;
	end Process;
		
		
	u_rCnt2 : Process(clk,rstb)
	Begin
		if(rstb='0') then
			rcnt2 <= "0010";
			rshift2 <= "0111";
		elsif(rising_edge(clk)) then
			if(rcnt2=4 and i1ms='1') then
				rcnt2 <= (others => '0');
				rshift2 <= rshift2(0) & rshift2(3 downto 1);
			elsif(i1ms = '1') then
				rcnt2 <= rcnt2 + 1;
				rshift2 <= rshift2;
			else
				rcnt2 <= rcnt2;
				rshift2 <= rshift2;
			end if;
		end if;
	end Process;
	
	u_rCnt3 : Process(clk,rstb)
	Begin
		if(rstb='0') then
			rcnt3 <= "0100";
			rshift3 <= "0111";
		elsif(rising_edge(clk)) then
			if(rcnt3=4 and i1ms='1') then
				rcnt3 <= (others => '0');
				rshift3 <= rshift3(0) & rshift3(3 downto 1);
			elsif(i1ms = '1') then
				rcnt3 <= rcnt3 + 1;
				rshift3 <= rshift3;
			else
				rcnt3 <= rcnt3;
				rshift3 <= rshift3;
			end if;
		end if;
	end Process;

end Behavioral;

