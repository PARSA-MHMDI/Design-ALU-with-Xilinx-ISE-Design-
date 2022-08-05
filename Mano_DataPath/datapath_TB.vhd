
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY datapath_TB IS
END datapath_TB;
 
ARCHITECTURE behavior OF datapath_TB IS 
 
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
			
			
			
			--temp: output registers
			reg0		: out std_logic_vector(15 downto 0);
			reg1		: out std_logic_vector(15 downto 0);
			reg2		: out std_logic_vector(15 downto 0);
			reg3		: out std_logic_vector(15 downto 0);
			reg4		: out std_logic_vector(15 downto 0);
			reg5		: out std_logic_vector(15 downto 0);
			reg6		: out std_logic_vector(15 downto 0);
			reg7		: out std_logic_vector(15 downto 0)
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
	
	-- temp
	signal reg0 : std_logic_vector(15 downto 0);
	signal reg1 : std_logic_vector(15 downto 0);
	signal reg2 : std_logic_vector(15 downto 0);
	signal reg3 : std_logic_vector(15 downto 0);
	signal reg4 : std_logic_vector(15 downto 0);
	signal reg5 : std_logic_vector(15 downto 0);
	signal reg6 : std_logic_vector(15 downto 0);
	signal reg7 : std_logic_vector(15 downto 0);
	
	
   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
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
      -- hold reset state for 100 ns.
--      wait for 100 ns;	

      wait for clk_period*2;

		-- Load inital values from memory
		dest_select <= "000";
		data_in <="0000000000000011";
		mem_load <= '1';
		wait for clk_period*2;
		
		dest_select <= "001";
		data_in <="0000000000000001";
		mem_load <= '1';
		wait for clk_period*2;
		
		a_select <= "000";
		b_select <= "001";
		b_source <= '0';
		dest_select <= "010";
		mem_load <= '0';
		const_in <= "1010101010101010";
		
		
		-- Start arithmetic operations
	
		fs_control <= "00000";
		wait for clk_period*2;
		
		fs_control <= "00001";
		wait for clk_period*2;
		
		fs_control <= "00010";
		wait for clk_period*2;
		
		fs_control <= "00011";
		wait for clk_period*2;
		
		fs_control <= "00100";
		wait for clk_period*2;
		
		fs_control <= "00101";
		wait for clk_period*2;
		
		fs_control <= "00110";
		wait for clk_period*2;
		
		fs_control <= "00111";
		wait for clk_period*2;
		
		
		
		-- Start logic operations
		
		fs_control <= "01000";
		wait for clk_period*2;
		
		fs_control <= "01010";
		wait for clk_period*2;
		
		fs_control <= "01100";
		wait for clk_period*2;
		
		fs_control <= "01110";
		wait for clk_period*2;
		
		
		
		-- start shift operations
		
		fs_control <= "10000";
		wait for clk_period*2;
		
		fs_control <= "10100";
		wait for clk_period*2;
		
		fs_control <= "11000";
		wait for clk_period*2;
		
		

      wait;
   end process;

END;
