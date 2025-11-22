2D Game on FPGA with 1080p VGA Controller in Verilog

📝 General Description

This project is a Verilog implementation of a simple 2D game designed to run on an FPGA development board (specifically, the Digilent Basys 3). The project generates a VGA video signal with a resolution of 1920x1080 (1080p).

The game involves controlling a red triangle (the player) on the screen, with the goal of avoiding horizontally moving blue obstacles. Upon collision detection, the game resets to its initial state.

🛠️ Requirements

Hardware

A Digilent Basys 3 development board

A monitor with a VGA input

A VGA cable

Software

Xilinx Vivado Design Suite: The project uses a constraints file (.xdc) specific to this software.

📁 Project Structure

The project consists of the following Verilog modules and a constraints file:

1. vga_top.v
   
This is the top-level module that integrates all other components of the system.

Instantiates a clocking wrapper (design_1_wrapper) to generate the required frequency for the VGA signal.

Instantiates the VGA timing controller (vga_1920X1080).

Instantiates the game logic module (vga_deplasare).

Connects the inputs (clock, reset, buttons) and outputs (VGA RGB, Hsync, Vsync signals) to the external pins of the FPGA.

2. vga_1920X1080.v

This module is responsible for generating the VGA timing signals according to the 1920x1080 @ 60Hz standard.

Uses horizontal (h_counter) and vertical (v_counter) counters to track the current position of the electron beam on the screen.

Generates the h_sync and v_sync synchronization signals.

Produces a display_surface signal that indicates the visible area of the screen.

3. vga_deplasare.v

This module contains the core game logic.

Object Rendering: Draws a red triangle (the player) and blue obstacles on the screen.

User Control: Takes input from the btnU, btnD, btnL, and btnR buttons to move the triangle.

Obstacle Movement: Implements the logic for the automatic horizontal movement of the obstacles.

Collision Detection: Checks for an overlap between the coordinates of the triangle and the obstacles. On collision, it resets the position of the player and the obstacles.

4. Basys3_Master.xdc

This is the constraints file that maps the ports defined in vga_top.v to the physical pins of the Basys 3 board.

Main Clock: Pin W5

Buttons:

rst: Pin U18

btnU: Pin T18

btnD: Pin U17

btnL: Pin W19

btnR: Pin T17

VGA Outputs:

Hsync: Pin P19

Vsync: Pin R19

vgaRed[3:0]: Pins N19, J19, H19, G19

vgaGreen[3:0]: Pins D17, G17, H17, J17

vgaBlue[3:0]: Pins J18, K18, L18, N18

![img1](https://github.com/user-attachments/assets/233a3ab8-4a86-49b9-a720-41fffcbcf739)  
![img2](https://github.com/user-attachments/assets/aad6efb3-906a-4e43-96c3-2119b61978b0)


https://github.com/user-attachments/assets/64e6ef92-92e5-4c3d-950a-b1e785c26745


