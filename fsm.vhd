library ieee;
use ieee.std_logic_1164.all;
entity fsm is 
	port(
			clk : in std_logic;
			data_in : in std_logic;
			reset : in std_logic;
			student_id : out std_logic_vector(3 downto 0);
			current_state : out std_logic_vector(3 downto 0)
			);
	end entity;
	
	architecture Behavior of fsm is 
	type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8);
	signal y : state_type;
begin
		process(clk, reset)
		begin
			if reset = '0' then
				y <=	s0;
			elsif(clk'EVENT AND clk = '1') then
				case y is
				
					when s0 =>
						if (data_in = '1') then	y <= s1;
						else y <= s0;
						end if;
						
							
					when s1 =>
						if (data_in = '1') then	y <= s2;
						else y <= s1;
						end if;
						
									
					when s2 =>
						if (data_in = '1') then y <= s3;
						else y <= s2;
						end if;
						
									
					when s3 =>
						if (data_in = '1') then	y <= s4;
						else y <= s3;
						end if;
						
									
					when s4 =>
						if (data_in = '1') then	y <= s5;
						else y <= s4;
						end if;
						
									
					when s5 =>
						if (data_in = '1') then	y <= s6;
						else y <= s5;
						end if;
									
					when s6 =>
						if (data_in = '1') then	y <= s7;
						else y <= s6;
						end if;
									
					when s7 =>
						if (data_in = '1') then	y <= s8;
						else y <= s7;
						end if;
									
					when s8 =>
						if (data_in = '1') then	y <= s0;
						else y <= s8;
						end if;
				end case;
			end if;
		end process;
		process(y, data_in)
		begin
			case y is
			
				when s0 => current_state <="0000";
					if data_in = '1' then student_id <= "0000";
					
					else student_id <= "0101"; 
					
					end if;
				when s8 => current_state <= "1000";
					if data_in = '1' then student_id <= "0001";
					
					else student_id <= "0000"; 
					end if;
					
				when s6 => current_state <= "0110";
					if data_in = '1' then student_id <= "0010";
					
					else student_id <= "0001"; 
					
					end if;
				when s4 => current_state <= "0100";
					if data_in = '1' then student_id <= "1000";
				
					else student_id <= "0010"; 
					end if;
					
					
					
					
				when s2 => current_state <= "0010";
					if data_in = '1' then student_id <= "1001";
					
					else student_id <= "1000"; 
				
					end if;
					
					
					
				when s7 => current_state <= "0111";
					if data_in = '1' then student_id <= "0001";
	
					else student_id <= "1001";
				
					end if;
				when s5 => current_state <= "0101";
					if data_in = '1' then student_id <= "0100";
				
					else student_id <= "0001"; 
				
					end if;
				when s3 => current_state <= "0011";
					if data_in = '1' then student_id <= "0100";
			
					else student_id <= "0100"; 
				
					end if;
				when s1 => current_state <= "0001";
					if data_in = '1' then student_id <= "0101";
				
					else student_id <= "0100"; 
				
					end if;
			end case;
		end process;
	end Behavior;
					
					
			