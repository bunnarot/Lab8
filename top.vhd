
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity top is
Port(
	clk : in std_logic;
	
	rstb : in std_logic;
	I1 : in std_logic;
	I2 : in std_logic;
	O : out std_logic_vector(6 downto 0);
	com : out std_logic_vector(3 downto 0);
	buss : out std_logic
	
);
end top;

architecture Stuctural of top is
	
	
	component CLK1ms is
	Port(
		clk : in std_logic;
		rstb : in std_logic;
		o1ms : out std_logic
	);
	end component CLK1ms;
	
	component CLK1s is
	Port(
		clk : in std_logic;
		rstb : in std_logic;
		iclk1ms : in std_logic;
		o1s : out std_logic
	);
	end component CLK1s;
	
	component BCD is
	Port(
		I : in std_logic_vector(3 downto 0);
		O : out std_logic_vector(6 downto 0)
	);
	end component BCD;
	
	component debouce is
	Port(
		clk : in std_logic;
		rstb : in std_logic;
		i1ms : in std_logic;
		I : in std_logic;
		O : out std_logic
	);
	end component debouce;
	
	component ScanDigit is
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
	end component ScanDigit;
	
	component FSM is
	Port(
		CLK,Rstb : in std_logic;
		I : in std_logic;
		iDigit1,iDigit2,iDigit3,iDigit4 : in std_logic_vector(3 downto 0);
		oDigit1,oDigit2,oDigit3,oDigit4 : out std_logic_vector(3 downto 0)
	);
	end component FSM;
	
	component State_Count is
	Port(
		CLK,Rstb : in std_logic;
		i1s : in std_logic;
		I : in std_logic;
		oDigit1,oDigit2,oDigit3,oDigit4 : out std_logic_vector(3 downto 0)
	);
	end component State_Count;
	
	signal wDigit : std_logic_vector(3 downto 0);
	signal wDigit1 : std_logic_vector(3 downto 0);
	signal wDigit2 : std_logic_vector(3 downto 0);
	signal wDigit3 : std_logic_vector(3 downto 0);
	signal wDigit4 : std_logic_vector(3 downto 0);
	signal wDigitO1 : std_logic_vector(3 downto 0);
	signal wDigitO2 : std_logic_vector(3 downto 0);
	signal wDigitO3 : std_logic_vector(3 downto 0);
	signal wDigitO4 : std_logic_vector(3 downto 0);
	signal w1ms : std_logic;
	signal w1s : std_logic;
	signal wO1 : std_logic;
	signal wO2 : std_logic;
	
begin
		buss<=w1ms;
	u_FSM : FSM
	Port Map(
		CLK		=> CLK,
		Rstb		=> Rstb,
		I			=> wO2,
		
		iDigit1	=> wDigit1,
		iDigit2	=> wDigit2,
		iDigit3	=> wDigit3,
		iDigit4	=> wDigit4,
		
		oDigit1	=> wDigitO1,
		oDigit2	=> wDigitO2,
		oDigit3	=> wDigitO3,
		oDigit4	=> wDigitO4
	);
	
	u_Count : State_Count
	Port Map(
		CLK		=> CLK,
		Rstb		=> Rstb,
		i1s		=> w1s,
		I			=> wO1,
		
		oDigit1	=> wDigit1,
		oDigit2	=> wDigit2,
		oDigit3	=> wDigit3,
		oDigit4	=> wDigit4
	);
	
	u_CLK1ms : CLK1ms
	Port Map(
		clk 	=> clk,
		rstb 	=> rstb,
		o1ms 	=> w1ms
	
	);
	
	u_CLK1s : CLK1s
	Port Map(
		clk 		=> clk,
		rstb 		=> rstb,
		iclk1ms 	=> w1ms,
		o1s 		=> w1s
	);
	
	u_Debouce1 : debouce
	Port Map(
		clk 	=> clk,
		rstb 	=> rstb,
		i1ms 	=> w1ms,
		I 		=> I1,
		O 		=> wO1
	);
	
	u_Debouce2 : debouce
	Port Map(
		clk 	=> clk,
		rstb 	=> rstb,
		i1ms 	=> w1ms,
		I 		=> I2,
		O 		=> wO2
	);
	
	u_ScanDigit : ScanDigit
	Port Map(
		clk 		=> clk,
		rstb 		=> rstb,
		i1ms 		=> w1ms,
		
		idigit1 	=> wDigitO1,
		idigit2 	=> wDigitO2,
		idigit3 	=> wDigitO3,
		idigit4 	=> wDigitO4,
		
		odigit 	=> com,
		odata 	=> wdigit
	);
	
	u_BCD : BCD
	Port Map(
		I => wdigit,
		O => O
	);

end Stuctural;

