# Pic-LineFollower
Uses the pic16f684 to execute the line follower code written in assembly.

## Getting Started
The information below will help you understand how the circuit and code works so you will be able to make adjustments to suit your project. 

## Hardware Notes
### QTI Sensor
The QTI sensors will output 1(5V) when sees a black and output a 0(0V) when it sees a white. This will allow the line follower to detect the black line on a white surface. 
### LM293 Comparator 
The LM293 contains a double comparator inside. One comparator will be used for the right sensor and the other comparator will be used for the left sensor. You may use two seperate comparactors however, the robot will be less compact. The datasheet and information on buying the chip can be found in the following link. You cna also find the pinout diagram below 
http://www.ti.com/product/LM293
![LM293 Comparator](https://www.theengineeringprojects.com/wp-content/uploads/2017/08/Introduction-to-LM293_9.png)
### L293D 
![L293D pin outs](https://components101.com/sites/default/files/component_pin/L293D-Pinout.png)
