# SKV_FSM — Verilog Finite State Machine Design

## Overview

**SKV_FSM** is a digital logic design project implemented in Verilog HDL. The project focuses on designing and simulating a Finite State Machine (FSM) that processes a continuous serial input stream and generates an output based on the current state and input condition.

The project demonstrates fundamental concepts of RTL design, state-transition logic, sequential circuits, clocked behavior, and testbench-based functional verification.

## Objectives

- Design a Finite State Machine using Verilog HDL.
- Implement state-transition logic using Boolean expressions.
- Understand blocking (`=`) and non-blocking (`<=`) assignments.
- Implement synchronous, active-low reset behavior.
- Develop a testbench to generate clock signals and input sequences.
- Verify state transitions and output behavior through simulation.

## Design Description

The FSM uses a 1-bit serial input, `din`, and a 2-bit state register to represent four possible states.

### Module Interface

| Signal | Direction | Width | Description |
|---|---|---|---|
| `clk` | Input | 1 bit | Clock signal |
| `rst_n` | Input | 1 bit | Active-low synchronous reset |
| `din` | Input | 1 bit | Serial input |
| `next_state` | Output | 2 bits | Calculated next state |
| `current_state` | Output | 2 bits | Current FSM state |
| `unlock` | Output | 1 bit | Output asserted when the specified state and input conditions are satisfied |

### State Transition Logic

The FSM contains four possible states: `00`, `01`, `10`, and `11`.

Its next-state equations are:

```verilog
c = current_state[1] & din;

next_state[0] = c |
                ((~current_state[1]) &
                 (~current_state[0]) & din);

next_state[1] = c |
                ((~current_state[1]) &
                 current_state[0] & (~din));
```

The output logic is:

```verilog
if (current_state == 2'b11 && din == 1'b1)
    unlock <= 1'b1;
else
    unlock <= 1'b0;
```

The `unlock` output is asserted when the current state is `11` and the sampled input is `1`.

### State Transition Table

| Current State | `din = 0` | `din = 1` |
|---|---|---|
| `00` | `00` | `01` |
| `01` | `10` | `00` |
| `10` | `00` | `11` |
| `11` | `00` | `11` |

The FSM updates its state on the positive edge of the clock. When `rst_n` is low at a positive clock edge, the state and output are reset.

## Testbench and Verification

A separate Verilog testbench, `SKV_FSM_tb`, is used to simulate the design.

The testbench is responsible for:

- Generating the clock signal.
- Applying reset and serial input sequences.
- Instantiating the FSM as the Device Under Test (DUT).
- Observing `current_state`, `next_state`, and `unlock`.
- Testing different input patterns and state transitions.
- Ending the simulation using `$finish`.

A reusable task such as `apply_bit()` can be used to apply input bits at the negative edge of the clock, avoiding race conditions with the FSM's positive-edge-triggered logic.

Example input sequence:

```text
din = 1 0 1 1 1 1 0
```

The state transitions and output behavior can be inspected using the simulator's waveform viewer.

## Concepts Demonstrated

- Verilog HDL and RTL design
- Finite State Machine implementation
- Boolean algebra and combinational next-state logic
- Sequential logic and state registers
- Clock generation and reset handling
- Blocking and non-blocking assignments
- Testbench tasks and procedural constructs
- Simulation-based functional verification
- Waveform analysis and debugging

## Tools and Technologies

- **Hardware Description Language:** Verilog HDL
- **Simulation and waveform analysis:** Compatible Verilog simulator, such as Xilinx Vivado Simulator
- **Version control:** Git and GitHub

## Repository Structure

A suggested repository structure is:

```text
SKV_FSM/
├── rtl/
│   └── SKV_FSM.v
├── testbench/
│   └── SKV_FSM_tb.v
├── simulation/
│   └── waveforms/
└── README.md
```

The directory structure can be adapted to match the actual files in the repository.

## Future Improvements

- Add self-checking testbench assertions.
- Automate testing of all state/input combinations.
- Add randomized input sequence testing.
- Explore alternative FSM encodings.
- Compare Moore and Mealy output implementations.
- Synthesize the RTL and analyze resource utilization and timing.

## Learning Outcomes

This project provides practical experience in translating Boolean state-transition equations into synthesizable RTL, understanding clocked state updates, and verifying sequential digital designs through simulation.

## License

Choose an appropriate open-source license before distributing this project, such as the MIT License.

---

**Project:** SKV_FSM  
**Category:** Digital Design / RTL Design  
**Language:** Verilog HDL
