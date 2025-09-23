# 24-bit Divider (SystemVerilog)

## Overview

This repository contains the implementation of a 24-bit divider written in SystemVerilog. The divider uses a restoring division algorithm to compute the quotient and remainder of two input numbers. The design supports parameterization and synchronous operation using a clock and reset signal.

##Features

- ** Parameterizable Design: The divider supports a configurable bit width via the N parameter (default: 48-bit inputs).
- ** Restoring Division Algorithm: Uses a step-by-step process of shifting, subtracting, and restoring to compute the division.
- ** Synchronous Operation: Controlled by a clock (clk) and active-low reset (rstn) signals.
- ** Normalization Check: Outputs whether the result requires normalization.
- ** Final Quotient and Remainder: Outputs both the quotient and remainder after the division process.

![34_2021_1832_Fig1_HTML](https://github.com/user-attachments/assets/89c92fa2-7087-420a-8b74-7ad6a9fb885a)

## State Machine

The divider operates in four states:

- **SHIFT:** Left-shift the `aq` register.
- **SUB:** Subtract the divisor from the shifted remainder.
- **RESTORE:** Check if the remainder needs to be restored and adjust the quotient accordingly.
- **END:** Final state, outputs the quotient and remainder.

## Simulations and Results

<img width="947" alt="Screenshot 2024-09-30 215213" src="https://github.com/user-attachments/assets/4a02deb7-b5f2-48a4-8b57-9a0cbe64ae08">


