# Final Project - Half-Rate Convolutional Code

**Note:** This project is part of my Bachelor's degree in Computer Science Engineering at Politecnico di Milano, Milan (MI), Italy.

**Academic Year:** 2021 / 2022  
**Authors:** Diego Corna, Filippo Corna  

## Table of Contents
1. [Introduction](#introduction)
2. [Functioning Overview](#functioning-overview)
3. [Architecture](#architecture)
    - [Datapath](#datapath)
    - [State Machine](#state-machine)
4. [Experimental Results](#experimental-results)
5. [Conclusions](#conclusions)

## Introduction

The project involves the implementation of a hardware module described in VHDL, which interfaces with memory according to a specific protocol. The module receives a continuous stream of 8-bit words as input and outputs an 8-bit encoded sequence. Each input word is serialized into a continuous 1-bit stream, which is encoded using a ½ convolutional code. The resulting bit stream is then parallelized into 8-bit words and stored in memory.

The encoding process starts when an external `START` signal is raised, and the module operates until it completes the task, indicated by the `DONE` signal.

## Functioning Overview

The translation of words works as follows:
- Each input bit generates two output bits (`p1k` and `p2k`), which are concatenated to form the final output stream.
- The output stream is then parallelized into 8-bit words and stored in memory starting from address 1000.

## Architecture

### Datapath

The datapath is composed of the following components:
- **Reg1**: Stores the 8-bit word to be encoded.
- **MUX (Msel)**: Selects individual bits from Reg1 for encoding.
- **Registers 2-5**: Store pairs of encoded bits, which are concatenated to form the 8-bit output.
- **Reg6**: Stores the number of words to be encoded.
- **Reg7**: Tracks the number of words already encoded.
- **Reg8**: Stores the memory address for writing results.

Additional multiplexers (M1-M5) and comparators control the data flow and ensure the correct encoding sequence.

### State Machine

The state machine controls the encoding process through several states:
- **S0**: Initialization and reset state.
- **S1-S15**: Control various steps such as reading input, encoding, and writing output to memory.

For a detailed description of each state, please refer to the project documentation.

## Experimental Results

The module was tested in both behavioral simulation and post-synthesis. Several test cases were passed, including:
1. Example condition as per specifications.
2. Sequence of 6 words with asynchronous RESET.
3. Maximum-length sequence (255 bytes).
4. Double processing on the same memory.
5. Consecutive processing of 3 different data streams.

## Conclusions

The final implementation meets all specified requirements with no latch issues, and the clock speed is under 100ns. The project allowed us to deepen our understanding of VHDL and hardware design, while also improving our teamwork and communication skills. The design process was smooth, with most challenges being resolved early on, leading to a successful project completion.

## License 📜

See the [LICENSE](LICENSE) file for more details.

