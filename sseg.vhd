LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sseg IS
	port( bcd : IN STD_logic_vector(3 DOWNTO 0);
	sign : IN STD_LOGIC;
	leds1	: OUT STD_logic_vector(1 TO 7);
	leds2 :  OUT STD_logic_vector(1 TO 7));
END sseg;
ARCHITECTURE Behavior OF sseg IS
BEGIN
Process (bcd, sign)
BEGIN 
	IF sign = '0' THEN
		leds2 <= NOT("0000000");
	ELSE 
		leds2 <= NOT("0000001");
	END IF;
	CASE bcd IS
		WHEN "0000" => leds1 <= NOT("1111110"); 
		WHEN "0001" => leds1 <= NOT("0110000"); 
		WHEN "0010" => leds1 <= NOT("1101101"); 
		WHEN "0011" => leds1 <= NOT("1111001"); 
		WHEN "0100" => leds1 <= NOT("0110011"); 
		WHEN "0101" => leds1 <= NOT("1011011"); 
		WHEN "0110" => leds1 <= NOT("1011111");
		WHEN "0111" => leds1 <= NOT("1110000");
		WHEN "1000" => leds1 <= NOT("1111111");
		WHEN "1001" => leds1 <= NOT("1110011");
		WHEN "1010" => leds1 <= NOT("1110111");
		WHEN "1011" => leds1 <= NOT("0011111");
		WHEN "1100" => leds1 <= NOT("1001110");
		WHEN "1101" => leds1 <= NOT("0111101");
		WHEN "1110" => leds1 <= NOT("1001111");
		WHEN "1111" => leds1 <= NOT("1000111");
		WHEN OTHERS => leds1 <= NOT("0000000");
	END CASE;
END PROCESS;
END Behavior;
	