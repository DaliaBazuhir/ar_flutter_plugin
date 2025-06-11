# ar_flutter_plugin
Lightweight Flutter plugin to present USDZ models in augmented reality on iPhones and iPads.
=======
## Getting Started

This plugin provides platform-specific implementation for iOS to display AR models in `.usdz` format.

### iOS Setup

To use this plugin on iOS, follow these steps:

1. Open your Flutter project’s iOS workspace in Xcode:


2. Drag your `.usdz` file (e.g., `Shell_Chair.usdz`) into the **Runner > Resources** folder in Xcode.

3. In the popup dialog, **check**:

- **Copy items if needed**

4. Ensure the `.usdz` file is added to the **Runner target**.

---

### Important Notes

- Only `.usdz` files are supported as AR models on iOS.
- The minimum iOS deployment target is **iOS 13.0**.
- This plugin currently supports **iOS only**; Android is not supported.

---

## Example Usage

```dart
await arPlugin.showArScreen(
'Shell_Chair.usdz', // Only pass the filename; the file must be bundled in iOS app resources
scale: 0.01,
);
>>>>>>> 441ad76 (Initial commit - Add Flutter plugin source code)
# ar_flutter_plugin
