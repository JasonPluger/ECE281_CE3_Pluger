--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:50:32 03/06/2014
-- Design Name:   
-- Module Name:   C:/Users/C16Jason.Pluger/Documents/Classes/Spring 2014 Classes/ECE 281/ISE Projects/CE3_Pluger/Moore_testbench_Pluger.vhd
-- Project Name:  CE3_Pluger
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MooreElevatorController_Shell
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
 
ENTITY Moore_testbench_Pluger IS
END Moore_testbench_Pluger;
 
ARCHITECTURE behavior OF Moore_testbench_Pluger IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MooreElevatorController_Shell
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         stop : IN  std_logic;
         up_down : IN  std_logic;
         floor : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal stop : std_logic := '0';
   signal up_down : std_logic := '0';

 	--Outputs
   signal floor : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MooreElevatorController_Shell PORT MAP (
          clk => clk,
          reset => reset,
          stop => stop,
          up_down => up_down,
          floor => floor
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

--      wait for clk_period*5;

      -- insert stimulus here 
		reset <= '1';
		wait for clk_period*5;
		reset <= '0';
		wait for clk_period*5;
		
		--move up one floor (1 --> 2)
		up_down <= '1';
		stop <= '0';
		wait for clk_period*1;
		
		--stop on the floor for 2 clk cycles
		up_down <= '0';
		stop <= '1';
		wait for clk_period*4; 
		
		--move up one floor (2 --> 3)
		up_down <= '1';
		stop <= '0';
		wait for clk_period*1;
		
		--stop on the floor for 2 clk cycles
		up_down <= '0';
		stop <= '1';
		wait for clk_period*4;
		
		--move up one floor (3 --> 4)
		up_down <= '1';
		stop <= '0';
		wait for clk_period*1;
		
		--stop on the floor for 2 clk cycles
		up_down <= '0';
		stop <= '1';
		wait for clk_period*4;
		
		--PART 2:
		
		up_down <= '0';
		stop <= '0';
		wait for clk_period*5;

      wait;
   end process;

END;
