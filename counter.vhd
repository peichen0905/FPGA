----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:35:16 09/27/2023 
-- Design Name: 
-- Module Name:    counter - Behavioral 
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
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;




entity counter is 
	port (clk : in STD_LOGIC; -- clock input
		  rst : in STD_LOGIC; -- reset input 
		  count1 : out STD_LOGIC_VECTOR (7 downto 0);
		  count2 : out STD_LOGIC_VECTOR (7 downto 0)
		);
end counter;

architecture Behavioral of counter is
signal cnt1: STD_LOGIC_VECTOR (7 downto 0);
signal cnt2: STD_LOGIC_VECTOR (7 downto 0);
type STATE_TYPE is (s1,s2,tmp1,tmp2);
signal state: STATE_TYPE;
begin

	Count1 <= cnt1;
	Count2 <= cnt2;
	
	FSM:process(clk, rst, cnt1, cnt2)
	begin
		if rst='1' then
		    state <= s1;
		elsif CLK'event and CLK='1' then
			case state is
				when s1 =>
					if cnt1 >= "1111"&"1100" then--252<end at 253>
						state <= tmp1;
					else
						state <= s1;
					end if;
				when tmp1=>
						state <=s2;
						
				when s2 =>
					if cnt2 <= "0010"&"1011" then--43<end at 42>
						state <= tmp2;
					else
						state <= s2;
					end if;
					
				when tmp2=>
						state <= s1;
				when others =>
					null;
			end case;
		end if;					
	end process;
	
	
	
	counter1: process(clk,rst,state)
	begin
		if rst='1' then
			cnt1 <= "0000"&"1101";--13
		elsif CLK'event and CLK='1' then
			case state is
				when s1 =>
					cnt1 <= cnt1 + '1';
				when tmp1 =>
					cnt1 <= "0000"&"1101";--13
				when s2 =>
					cnt1 <= "0000"&"1101";--13
				when tmp2 =>
					null;
				when others =>
					null;
			end case;
		end if;
	end process;
	
	
	counter2: process(clk, rst, state)
	begin
		if rst='1' then
			cnt2 <= "1010"&"0001";--161=128+33=128+32+1
		elsif CLK'event and CLK='1' then
			case state is
				when s1 =>
					cnt2 <= "1010"&"0001";--161=128+33=128+32+1
				when tmp1 =>
					null;
				when s2 =>
					cnt2 <= cnt2 - '1';
				when tmp2 =>
					cnt2 <= "1010"&"0001";
				when others =>
					null;
			end case;
		end if;
	end process;

end Behavioral;

