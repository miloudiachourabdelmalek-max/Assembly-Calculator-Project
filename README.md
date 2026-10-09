# 16-bit Assembly Calculator

A command-line calculator written in x86 Assembly for DOS, using BIOS/DOS-compatible software interrupts through `INT 21h`.

The program allows the user to enter two numbers, select an arithmetic operation, and choose a number base for input and output.

## Features

* **Arithmetic operations**

  * Addition (`+`)
  * Multiplication (`*`)
  * Division (`/`), displaying both the quotient and remainder

* **Number bases**

  * Binary (`b`)
  * Decimal (`d`)
  * Hexadecimal (`h`) — presented in the menu but not yet implemented

* **Input validation**

  * Checks that decimal input contains only digits.
  * Checks that binary input contains only `0` and `1`.
  * Requests new input when validation fails.

* **Arithmetic error handling**

  * Includes signed overflow detection for selected arithmetic operations.
  * Displays an error message when the overflow handler is triggered.

## Technologies and Concepts

* 16-bit x86 Assembly
* DOS interrupts (`INT 21h`)
* Registers and memory addressing
* Data, code, and stack segments
* Procedures and procedure calls
* Stack operations (`PUSH`, `POP`, `CALL`, `RET`)
* Conditional jumps and loops
* Arithmetic instructions (`ADD`, `MUL`, `DIV`, `SHL`)
* ASCII-to-integer conversion
* Integer-to-ASCII output conversion

## How It Works

1. The program asks the user to select an arithmetic operation.
2. The user selects the number base.
3. The program reads and validates the first number.
4. The program reads and validates the second number.
5. The input strings are converted into integer values.
6. The selected arithmetic operation is executed.
7. The result is converted into the selected output base and displayed.

For division, the program displays the quotient and remainder separately.

## Example

```text
enter the operation: "+" for addition, "*" for multiplication, "/" for division

+

enter your base: "b" for binary, "d" for decimal, "h" for hexadecimal

d

enter the first number:
12

enter the second number:
5

your result is:
17
```

For division, the program displays both the quotient and the remainder.

## Limitations

* Hexadecimal input and output are not implemented yet.
* Negative-number input is not supported.
* The program uses 16-bit registers, which limit the range of representable results.
* Overflow detection and division-by-zero handling need further improvement.
* Input length and numeric range checks should be strengthened.

## Learning Objectives

This project explores low-level programming concepts, including register manipulation, memory organization, procedure calls, stack management, numeric representation, input validation, and arithmetic operations.

## Future Improvements

* Implement hexadecimal input and output.
* Improve overflow detection for signed and unsigned arithmetic.
* Add division-by-zero handling.
* Support negative numbers.
* Refactor repeated arithmetic code into reusable procedures.
* Improve input range validation and error messages.

## Author

Developed as an educational project to practice 16-bit x86 Assembly programming.
