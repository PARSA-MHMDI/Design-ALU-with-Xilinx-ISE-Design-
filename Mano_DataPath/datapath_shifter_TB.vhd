--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:44:46 03/21/2017
-- Design Name:   
-- Module Name:   U:/Computer Architecture/Datapath/Datapath/datapath_shifter_TB.vhd
-- Project Name:  RegsiterFile
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: datapath
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY datapath_shifter_TB IS
END datapath_shifter_TB;
 
ARCHITECTURE behavior OF datapath_shifter_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT datapath
    PORT(
         a_select : IN  std_logic_vector(2 downto 0);
         b_select : IN  std_logic_vector(2 downto 0);
         dest_select : IN  std_logic_vector(2 downto 0);
         write_sig : IN  std_logic;
         clk : IN  std_logic;
         const_in : IN  std_logic_vector(15 downto 0);
         b_source : IN  std_logic;
         fs_control : IN  std_logic_vector(4 downto 0);
         v : OUT  std_logic;
         c : OUT  std_logic;
         n : OUT  std_logic;
         z : OUT  std_logic;
         addr_out : OUT  std_logic_vector(15 downto 0);
         data_out : OUT  std_logic_vector(15 downto 0);
         data_in : IN  std_logic_vector(15 downto 0);
         mem_load : IN  std_logic;
         reg0 : OUT  std_logic_vector(15 downto 0);
         reg1 : OUT  std_logic_vector(15 downto 0);
         reg2 : OUT  std_logic_vector(15 downto 0);
         reg3 : OUT  std_logic_vector(15 downto 0);
         reg4 : OUT  std_logic_vector(15 downto 0);
         reg5 : OUT  std_logic_vector(15 downto 0);
         reg6 : OUT  std_logic_vector(15 downto 0);
         reg7 : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a_select : std_logic_vector(2 downto 0) := (others => '0');
   signal b_select : std_logic_vector(2 downto 0) := (others => '0');
   signal dest_select : std_logic_vector(2 downto 0) := (others => '0');
   signal write_sig : std_logic := '0';
   signal clk : std_logic := '0';
   signal const_in : std_logic_vector(15 downto 0) := (others => '0');
   signal b_source : std_logic := '0';
   signal fs_control : std_logic_vector(4 downto 0) := (others => '0');
   signal data_in : std_logic_vector(15 downto 0) := (others => '0');
   signal mem_load : std_logic := '0';

 	--Outputs
   signal v : std_logic;
   signal c : std_logic;
   signal n : std_logic;
   signal z : std_logic;
   signal addr_out : std_logic_vector(15 downto 0);
   signal data_out : std_logic_vector(15 downto 0);
   signal reg0 : std_logic_vector(15 downto 0);
   signal reg1 : std_logic_vector(15 downto 0);
   signal reg2 : std_logic_vector(15 downto 0);
   signal reg3 : std_logic_vector(15 downto 0);
   signal reg4 : std_logic_vector(15 downto 0);
   signal reg5 : std_logic_vector(15 downto 0);
   signal reg6 : std_logic_vector(15 downto 0);
   signal reg7 : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: datapath PORT MAP (
          a_select => a_select,
          b_select => b_select,
          dest_select => dest_select,
          write_sig => write_sig,
          clk => clk,
          const_in => const_in,
          b_source => b_source,
          fs_control => fs_control,
          v => v,
          c => c,
          n => n,
          z => z,
          addr_out => addr_out,
          data_out => data_out,
          data_in => data_in,
          mem_load => mem_load,
          reg0 => reg0,
          reg1 => reg1,
          reg2 => reg2,
          reg3 => reg3,
          reg4 => reg4,
          reg5 => reg5,
          reg6 => reg6,
          reg7 => reg7
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	
	
		-- Allow registers to latch data
		write_sig <= '1';
		mem_load <= '0';
		
		
		
		-- Load a test value into R0
		-- Note logic unit is used to move a constant value into a register
		
		-- mov(r0,#0x0f0f)			r0 = "0000 1111 0000 1111"
		dest_select <= "000";
		const_in <= x"0f0f";
		b_source <= '1';				-- Use constant in
		fs_control <= "10000";		-- Use lsr(0)/lsl(0) to access B
		wait for clk_period;

		-- Logic shift by zero bits
		-- maps data on b bus onto output
		-- mov (r1,r0) is essentially what happens
		dest_select <= "001";
		b_select <= "000";
		b_source <= '0';				-- Using r0 on b-bus
		fs_control <= "10000";	
		wait for clk_period;

		-- Logic shift left 	-> 	multiply by two
		-- lsl(r2,r0) 			->		r1 = "0001 1110 0001 1110"
		dest_select <= "010";
		a_select <= "111";			-- a is not be used by logic unit
		b_select <= "000";
		fs_control <= "11000";
		wait for clk_period;
		
		-- Logic shift right -> 	divide by two
		-- lsr(r3,r0) 			->		r1 = "0000 0111 1000 0111"
		dest_select <= "011";
		a_select <= "111";			-- a is not be used by logic unit
		b_select <= "000";
		fs_control <= "10100";
		wait for clk_period;		
				

		
	
		

      wait;
   end process;

END;
