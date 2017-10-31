----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:48:03 09/25/2017 
-- Design Name: 
-- Module Name:    CLK1s - Behavioral 
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

entity CLK1s is

	Port(
		clk : in std_logic;
		rstb : in std_logic;
		iclk1ms : in std_logic;
		o1s : out std_logic
	);

end CLK1s;

architecture Behavioral of CLK1s is
	signal rcnt : std_logic_vector(9 downto 0);
	signal r1s : std_logic;
begin

	o1s <= r1s;
	
	u_rCnt : process(clk,rstb)
	begin
		if(rstb = '0') then
			rcnt <= (others => '0');
			r1s <= '0';
		elsif(rising_edge(clk)) then
			if(rcnt = 999 and iclk1ms = '1') then
				rcnt <= (others => '0');
				r1s <= '1';
			elsif(iclk1ms = '1') then
				rcnt <= rcnt + 1;
				r1s <= '0';
			else
				rcnt <= rcnt;
				r1s <= '0';
			end if;
		end if;
	end process;

end Behavioral;
