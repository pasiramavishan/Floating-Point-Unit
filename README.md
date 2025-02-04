# Single Precision Floating Point Unit (IEEE-754)

## Overview
This project implements a **Single Precision Floating Point Unit (FPU)** that performs **addition, subtraction, multiplication, and division** using the IEEE-754 standard for 32-bit floating-point numbers.

## Features
- **IEEE-754 Compliance**: Supports 32-bit floating-point representation.
- **Arithmetic Operations**: 
  - Addition (`+`)
  - Subtraction (`-`)
  - Multiplication (`*`)
  - Division (`/`)
- **Efficient Design**: Implemented in SystemVerilog for FPGA or ASIC synthesis.
- **Pipeline Support**: Optimized for performance.
- **Error Handling**: Handles special cases like NaN, infinity, and denormalized numbers.

## IEEE-754 Format
Each 32-bit floating-point number consists of:
- **1-bit sign** (0 for positive, 1 for negative)
- **8-bit exponent** (biased by 127)
- **23-bit fraction (mantissa)**

```
 SEEEEEEE EMMMMMMMM MMMMMMMM MMMMMMMM
```

## Operation Details
- **Addition & Subtraction**:
  - Align exponents
  - Perform addition/subtraction on mantissas
  - Normalize the result

- **Multiplication**:
  - Multiply mantissas
  - Add exponents (adjusting for bias)
  - Normalize the result

- **Division**:
  - Divide mantissas
  - Subtract exponents (adjusting for bias)
  - Normalize the result


https://github.com/user-attachments/assets/57f0f933-0bb7-496a-a7d6-f510334dcff3

