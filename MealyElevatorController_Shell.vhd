----------------------------------------------------------------------------------
-- Company: USAFA/DFEC
-- Engineer: Silva
-- 
-- Create Date:    10:33:47 07/07/2012 
-- Design Name: 
-- Module Name:    MooreElevatorController_Silva - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--declare what the entity will be (what we can see from the OUTSIDE (ins/outs))
entity MealyElevatorController_Shell is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           stop : in  STD_LOGIC;
           up_down : in  STD_LOGIC;
           floor : out  STD_LOGIC_VECTOR (3 downto 0);
			  nextfloor : out std_logic_vector (3 downto 0));
end MealyElevatorController_Shell;

--declare what will go on INSIDE the box (signals, types, etc.)
architecture Behavioral of MealyElevatorController_Shell is

--declare ENUMERATED type. i.e. "custom" type
type floor_state_type is (floor1, floor2, floor3, floor4);

signal floor_state : floor_state_type;

begin

---------------------------------------------------------
--Code your Mealy machine next-state process below
--Question: Will it be different from your Moore Machine?
---------------------------------------------------------
floor_state_machine: process(clk)
begin
--Insert your state machine below:
	--clk'event and clk='1' is VHDL-speak for a rising edge
	if clk'event and clk='1' then --b/c we're checking to see that clk = '1', we're using "active high" checking
		--reset is ACTIVE HIGH and will return the elevator to floor1
		--Question: is reset synchronous or asynchronous?
		--Answer with question: are there nested if statements that check
--			for clock then check for reset? --> Yes, indeed.
		if reset='1' then
			floor_state <= floor1;
		--now we will code our next-state logic
		else
			case floor_state is
				--when our current state is floor1
				when floor1 =>
					--if up_down is set to "go up" and stop is set to 
					--"don't stop" which floor do we want to go to?
					if (up_down='1' and stop='0') then 
						--floor2 right?? This makes sense!
						floor_state <= floor2;
					--otherwise we're going to stay at floor1
					else
						floor_state <= floor1;
					end if;
				--when our current state is floor2
				when floor2 => 
					--if up_down is set to "go up" and stop is set to 
					--"don't stop" which floor do we want to go to?
					if (up_down='1' and stop='0') then 
						floor_state <= floor3; 			
					--if up_down is set to "go down" and stop is set to 
					--"don't stop" which floor do we want to go to?
					elsif (up_down='0' and stop='0') then 
						floor_state <= floor1;
					--otherwise we're going to stay at floor2
					else
						floor_state <= floor2;
					end if;
				
--COMPLETE THE NEXT STATE LOGIC ASSIGNMENTS FOR FLOORS 3 AND 4
				when floor3 =>
				--if "go up" and "don't stop", then go up.
					if (up_down='1' and stop='0') then 
						floor_state <= floor4;
				--if not "go up" and not "stop", move down
					elsif (up_down='0' and stop='0') then 
						floor_state <= floor2;
				--if not "go up" and "stop" is engaged, then stop...duh.
					else
						floor_state <= floor3;	
					end if;
				when floor4 =>
				--if not "go up" and "don't stop", then go down to floor3
					if (up_down='0' and stop='0') then 
						floor_state <= floor3;	
				--otherwise, stay on floor4; stay if updown is still engaged, or if stop is engaged.
					else 
						floor_state <= floor4;
					end if;
				
				--This line accounts for phantom states. i.e. catch-all
				when others =>
					floor_state <= floor1;
			end case;
		end if;
	end if;
end process;

-----------------------------------------------------------
--Code your Ouput Logic for your Mealy machine below
--Remember, now you have 2 outputs (floor and nextfloor)
-----------------------------------------------------------
floor <= "0001" when (floor_state = floor1) else
			"0010" when (floor_state = floor2) else
			"0011" when (floor_state = floor3) else
			"0010" when (floor_state = floor4) else
			"0001";
					--nextFloor is 1 when: we're on the bottom floor and staying down,
												--we're on the bottom floor and stopped(regardless of what upDown is)
												--we're on floor2 and coming down
nextfloor <= "0001" when (floor_state = floor1 and up_down='0' and stop='0') else
				 "0001" when (floor_state = floor1 and stop='1') else
				 "0001" when (floor_state = floor2 and up_down='0' and stop='0') else
				 --nextFloor is 2 when: we're on floor 1 and going up
											 --we're on floor 2 and stopped
											 --we're on floor 3 coming down
 				 "0010" when (floor_state = floor1 and up_down='1' and stop='0') else
				 "0010" when (floor_state = floor2 and stop='1') else
				 "0010" when (floor_state = floor3 and up_down='0' and stop='0') else
				 --nextFloor is 3 when: we're on floor 2 and going up
											 --we're on floor 3 and stopped
											 --we're on floor 4 coming down
 				 "0011" when (floor_state = floor2 and up_down='1' and stop='0') else
				 "0011" when (floor_state = floor2 and stop='1') else
				 "0011" when (floor_state = floor4 and up_down='0' and stop='0') else
				 --nextFloor is 1 when: we're on the top floor and staying up,
												--we're on the top floor and stopped(regardless of what upDown is)
												--we're on floor3 and going up
				 "0100" when (floor_state = floor4 and up_down='1') else
				 "0100" when (floor_state = floor4 and stop='1') else
				 "0100" when (floor_state = floor3 and up_down='1' and stop='0');

end Behavioral;

