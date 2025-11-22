VGA Visual Indicator for Pmod PIR Motion Sensor

A simple FPGA project that displays a full-screen color indicator on a VGA monitor based on input from a Pmod PIR motion sensor.

📝 General Description

This project demonstrates a practical application of integrating an external sensor with an FPGA board to provide visual feedback on a monitor. The system functions as a security or presence indicator, changing the entire screen's color based on the state of a passive infrared (PIR) motion sensor.

The design is intended for a Digilent Basys 3 board and a Pmod PIR, generating a stable video signal at a 1920x1080 (Full HD) resolution.

⚙️ Hardware Requirements
Digilent Basys 3 Board

Digilent Pmod PIR Motion Sensor

A monitor with a VGA input and cable

🚦 Functionality

The system's logic is straightforward and changes the screen color based on the sensor's state:

🟢 Green Screen: No motion is detected (Motion_detected is low).

🔴 Red Screen: Motion is detected (Motion_detected is high).

⚫ Black Screen: During VGA blanking intervals to maintain a standard signal.

📁 Project Structure

The project is modular, with each file having a clear responsibility:

vga_top.v

The top-level module that integrates all components. It instantiates a Clocking Wizard to generate the 148.5 MHz clock, the VGA timing controller, and the sensor logic module. It also connects the Motion_detected input port to the internal logic.

vga_1920X1080.v

A VGA timing controller that generates the horizontal sync (h_sync) and vertical sync (v_sync) signals for a 1920x1080 pixel resolution. It informs the rest of the system when it is in the active display area via the display_on signal.

Pmod_PIR.v

Contains the main application logic. It receives the Motion_detected signal and, depending on its value, sets the vgaRed, vgaGreen, and vgaBlue color outputs.

Basys3_Master.xdc

The Xilinx Design Constraints file that maps the ports from vga_top.v to the physical pins of the Basys 3 board. Most importantly, it maps the Motion_detected input to pin J1, corresponding to the first pin of the Pmod JA connector.


https://github.com/user-attachments/assets/b0ebd9f4-5e1e-4f29-be75-3de506c82bb4

