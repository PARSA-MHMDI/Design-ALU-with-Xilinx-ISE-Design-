
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY logic_unit_TB IS
END logic_unit_TB;
 
ARCHITECTURE behavior OF logic_unit_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT logic_unit
    PORT(
         a : IN  std_logic_vector(15 downto 0);
         b : IN  std_logic_vector(15 downto 0);
         s : IN  std_logic_vector(1 downto 0);
         output : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(15 downto 0) := (others => '0');
   signal b : std_logic_vector(15 downto 0) := (others => '0');
   signal s : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: logic_unit PORT MAP (
          a => a,
          b => b,
          s => s,
          output => output
        );



   -- Stimulus process
   stim_proc: process
   begin		
		a <= "1111111100001010";
		b <= "1111111100001100";

		s <= "00";
		wait for 20ns;
		
		s <= "01";
		wait for 20ns;
		
		s <= "10";
		wait for 20ns;
		
		s <= "11";
		wait for 20ns;
		
      -- insert stimulus here 

      wait;
   end process;

END;
