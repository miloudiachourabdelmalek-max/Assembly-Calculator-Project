# 16-bit x86 Assembly Calculator for Uni project (self coded)

A command-line calculator developed in x86 Assembly for a DOS-compatible environment. The program allows users to perform arithmetic operations on numbers entered in different bases: binary, decimal, and hexadecimal.

## Features

### Arithmetic Operations

* **Addition (`+`)** — Adds two numbers.
* **Multiplication (`*`)** — Multiplies two numbers and stores the result in a 32-bit variable.
* **Division (`/`)** — Calculates and displays the quotient and remainder.

### Supported Number Bases

| Base        | Selection | Description                                                 |
| ----------- | --------- | ----------------------------------------------------------- |
| Binary      | `b`       | Base 2, using `0` and `1`                                   |
| Decimal     | `d`       | Base 10, using digits `0`–`9`                               |
| Hexadecimal | `h`       | Base 16, using digits `0`–`9` and uppercase letters `A`–`F` |

The selected base is used for input validation, number conversion, and result display.

### Input Validation

The program includes dedicated procedures to validate user input:

* `EstBinaire` — Checks binary input.
* `EstDecimal` — Checks decimal input.
* `EstHexa` — Checks hexadecimal input.

Invalid input causes the program to request another value.

### Error Handling

* Checks for division by zero before accepting the divisor.
* Includes overflow detection for arithmetic and conversion operations.
* Displays an error message when the overflow handler is triggered.

## Technologies and Concepts

This project explores the following low-level programming concepts:

* 16-bit x86 Assembly
* DOS interrupts using `INT 21h`
* Registers and memory addressing
* Data, code, and stack segments
* Procedures and procedure calls
* Stack operations (`PUSH`, `POP`, `CALL`, `RET`)
* Conditional jumps and loops
* Arithmetic instructions (`ADD`, `MUL`, `DIV`, `SHL`)
* ASCII character validation and numeric conversion
* Binary, decimal, and hexadecimal representations
* Multiword arithmetic and result storage

## Program Structure

| Procedure        | Purpose                                                                       |
| ---------------- | ----------------------------------------------------------------------------- |
| `print`          | Displays a string using DOS interrupt `21h`, function `09h`.                  |
| `disp`           | Converts a numeric value into the selected output base and displays it.       |
| `EstDecimal`     | Validates decimal input.                                                      |
| `EstBinaire`     | Validates binary input.                                                       |
| `EstHexa`        | Validates uppercase hexadecimal input.                                        |
| `stringtonumber` | Converts an input string into a numeric value according to the selected base. |

## How It Works

1. The user selects an arithmetic operation.
2. The user chooses a number base.
3. The program reads and validates the first number.
4. The first input is converted into an integer.
5. The program reads and validates the second number.
6. The second input is converted into an integer.
7. The selected arithmetic operation is performed.
8. The result is converted into the selected base and displayed.

For division, the quotient and remainder are displayed separately.

## Example

```text
enter the operation: "+" for addition, "*" for multiplication, "/" for division

+

enter your base: "b" for binary, "d" for decimal, "h" for hexadecimal

h

enter the first number:
A

enter the second number:
5

your result is:
F
```

This example illustrates the intended hexadecimal behavior: `A` (10) plus `5` equals `F` (15).

## Limitations

* Hexadecimal input currently accepts uppercase letters `A`–`F`.
* Negative-number input is not supported.
* The program uses 16-bit registers for its main arithmetic operations.
* Multiplication result storage uses 32 bits, but displaying the complete 32-bit result requires additional handling.
* Overflow detection and conversion routines require further testing to ensure correctness.

## Possible Improvements

* Support lowercase hexadecimal digits.
* Improve signed and unsigned overflow handling.
* Implement complete 32-bit result conversion and display.
* Strengthen numeric range validation.
* Refactor repeated code into reusable procedures.
* Improve error messages and input handling.

## Author

Developed as an educational project to practice x86 Assembly, low-level arithmetic, memory management, procedures, and number-system conversions.
