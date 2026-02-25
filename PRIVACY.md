# Privacy Policy

Last Updated: February 24, 2026

The ExpressLRS Mobile application ("the App") is designed with a "Privacy First" philosophy. We believe that your hardware configuration, credentials, and location are private data that should remain under your control.

## 1. Information Collection and Use

### Local Storage
The App stores the following data locally on your device using encrypted or system-protected storage (such as SharedPreferences and Application Documents):
- **WiFi Credentials**: Home and Device WiFi SSIDs and Passwords used for firmware flashing.
- **Binding Phrases**: Used to coordinate your ExpressLRS hardware.
- **Regulatory Settings**: Your preferred regulatory domain (e.g., FCC, LBT).
- **Firmware Cache**: Downloaded firmware files for flashing.

**This data is stored only on your device and is never transmitted to our servers or any third parties by the App.**

### Crash Reporting (Sentry)
To help us improve the App and resolve technical issues, we use **Sentry**, a third-party crash reporting service. When the App crashes or encounters a critical error, it may automatically send an anonymous report containing:
- Device hardware model and OS version.
- App version.
- Stack traces and error messages.

These reports do **not** include your Binding Phrase, WiFi passwords, or personal identity. We use this information solely for debugging and performance optimization.

### Firmware Downloads
When you request a firmware update, the App communicates with **GitHub API** and **ExpressLRS servers** to download the necessary files. This process involves standard HTTP requests which may log your IP address on those external servers, subject to their respective privacy policies.

## 2. Device Permissions

The App requires certain permissions to function correctly:
- **Network Access**: Required to download firmware and communicate with ELRS devices over WiFi.
- **Location (Fine/Coarse)**: Required on Android to perform WiFi scanning and identify nearby ELRS Access Points. The App does **not** track your movement or store your coordinates.
- **Storage/Files**: Required to save and manage firmware files in the App's local cache.

## 3. Data Security
We implement standard security measures to protect your data locally. However, please be aware that no method of electronic storage is 100% secure. We recommend using device-level security (passcodes, biometrics) to protect the data stored within the App.

## 4. Changes to This Policy
We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last Updated" date.

## 5. Contact Us
If you have any questions about this Privacy Policy, please contact the maintainers via the [official ExpressLRS Discord](https://discord.gg/expresslrs) or our [GitHub Repository](https://github.com/ExpressLRS/ExpressLRS).
