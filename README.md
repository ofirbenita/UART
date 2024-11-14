UART Design and Simulation
This project features a Verilog-based design and simulation of a UART (Universal Asynchronous Receiver-Transmitter) module, including baud rate generation, transmission (TX), and reception (RX) functionality. The purpose of the project is to develop a functional UART interface capable of serial data transmission and reception with adjustable baud rates.

Project Overview
The project includes:

UART Module: Implements the core UART functionality for data transmission and reception.
Baud Rate Generator: A configurable module to generate the correct clock ticks based on a given baud rate.
Testbench: A test environment in Verilog to verify the functionality of the UART design. This includes stimulus for the UART module, along with monitoring for TX and RX signals, and verification of data integrity through DIN (input data) and DOUT (output data).
Key Features
Configurable Baud Rate: The design allows for easy adjustment of the baud rate by setting parameters, making the UART module adaptable to various communication standards.
TX/RX Data Verification: The testbench verifies that the transmitted data matches the received data, ensuring reliable data transfer.
Simulation Logs: Simulation outputs include detailed logs for TX and RX status, as well as any error or status messages generated during testing.
Simulation Environment
The design is simulated using Vivado 2019.1, with testbench files and waveforms to visualize signal behavior over time. tx_done_tick and rx_done_tick signals are used to indicate the completion of transmission and reception cycles, which are verified within the testbench.

Usage
Clone the repository and open the project in Vivado or your preferred simulation tool.
Run the provided simulation scripts to view waveform outputs.
Adjust parameters as needed for custom baud rates and clock frequencies.
Future Improvements
Extend support for additional UART configurations, such as parity bits and variable data frame sizes.
Integrate error detection mechanisms for enhanced reliability.
This project serves as a foundational UART implementation, suitable for learning and adapting to custom serial communication needs.

