ECE281_CE3_Pluger
=================

###Moore Testbench/Waveform Description
View my Moore testbench waveform ![here](https://github.com/JasonPluger/ECE281_CE3_Pluger/blob/master/Moore_Testbench_Waveform1.PNG "here")


I believe my design is functional because I went through each step of the waveform simulation and matched it to not only my testbench code to ensure that it was actully outputting what I told it to, but also to reason. By this I mean to say that I checked to make sure that whenever the inputs were up_down = '1' and stop = '0', that the floor number actually incremented. I checked to make sure that the elevator was remaining at each floor for at least 2 clock cycles (I kept it at each for 4), and also that at the end it traversed down through each floor and ended, finally, at the bottom floor of one.

###Mealy Testbench/Waveform Description
Please take a gander at my Mealy finite state machine waveform ![here](https://github.com/JasonPluger/ECE281_CE3_Pluger/blob/master/Mealy_testbench_Waveform1.PNG "here")


I believe my waveform is mostly correct with a few small exceptions. I went through my waveform similar to above in that I traversed each combination of upDown and stop to see that they were manifesting themselves properly in the waveform, and that I was achieving the desired results with the floor and nextFloor numbers. I found that my implemenation was correct mostly. One place I saw discrepencies was when I rose to floor 3 and stopped there for a number of clock cycles. I found that even though it was in a state of upDown being low and stop being high, my nextFloor was still registering as being floor 4 despite the fact that I programmed it to remain as saying nextFloor was floor3 (because we can either move up or down from floor3 and therefore don't know our nextFloor for certain until we change states further). 


####Answers to Questions in vhd comments:
Question: is reset synchronous or asynchronous?
		Answer: Are there nested if statements that check for clock and THEN check for reset? --> Yes, indeed so it's synchronous.
		
Question: Will it be different from your Moore Machine?
    Answer: It will not be, no. The only thing that changes in the Mealy machine is that we have an additional output parameter that keeps track of what the next floor we'll be traveling to is.
    
Question: What is the clock frequency if the clk_period is 10ns?
    Answer: f = 1/T so the frequency is 100MHz. 
Question: What value would we set to simulate a 50MHz clock?
    Answer: T = 1/f so period would be 20ns.
    

