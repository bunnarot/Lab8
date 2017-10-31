----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:57:01 09/25/2017 
-- Design Name: 
-- Module Name:    CLK1ms - Behavioral 
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

entity CLK1ms is

	Port(
		clk : in std_logic;
		rstb : in std_logic;
		o1ms : out std_logic
	);

end CLK1ms;

architecture Behavioral of CLK1ms is
	signal rcnt : std_logic_vector(14 downto 0);
	signal r1ms : std_logic;
begin

	o1ms <= r1ms;
	
	u_rClk : process(clk,rstb)
	begin
		if(rstb = '0') then
			rcnt <= (others => '0');
			r1ms <= '0';
		elsif(rising_edge(clk)) then
			if(rcnt = 24999) then
				rcnt <= (others => '0');
				r1ms <= '1';
			else
				rcnt <= rcnt + 1;
				r1ms <= '0';
			end if;
		end if;
	end process;

end Behavioral;
