# ExpressLRS Logic Validator

This tool is used to verify the internal assembly logic of ExpressLRS firmware binaries. It compares two binaries bit-by-bit and identifies discrepancies, mirroring the logic used in the main application.

## Prerequisites

- [Dart SDK](https://dart.dev/get-dart) (v3.0.0 or later)

## Usage

1. **Install dependencies:**
   ```bash
   dart pub get
   ```

2. **Run the validator:**
   ```bash
   dart run logic_validator.dart
   ```

## Workflow

- The tool will search for `.bin` and `.gz` files in the current folder and in `../../binaries/`.
- It performs zero-copy memory management for high-performance comparison of large segments.
- It utilizes `package:binary` extension types for bit-level analysis parity with the main app.
- Detailed discrepancy logs are written to `../../logs/`.
