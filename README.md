# NovyBleLiteSDK

<p align="center">
Modern Bluetooth Low Energy SDK for iOS built with Swift Concurrency.
</p>

<p align="center">
  <a href="https://github.com/gopalsorathiya/NovyBleLiteSDK/releases">
    <img src="https://img.shields.io/github/v/release/gopalsorathiya/NovyBleLiteSDK" />
  </a>

  <a href="LICENSE">
    <img src="https://img.shields.io/badge/license-Apache%202.0-blue.svg" />
  </a>

  <img src="https://img.shields.io/badge/iOS-13%2B-black" />
  <img src="https://img.shields.io/badge/Swift-5.9-orange" />
</p>

---

# Features

- BLE Device Scanning
- Device Connection
- Service Discovery
- Read Characteristics
- Write Characteristics
- Notifications / Indications
- Async/Await APIs
- SwiftUI Friendly
- Lightweight Integration
- XCFramework Distribution
- SPM Support

---

# Why NovyBleLiteSDK?

CoreBluetooth is powerful but complex.

NovyBleLiteSDK simplifies BLE development with modern Swift APIs.

Instead of delegate-heavy architecture:

```swift
centralManager.scanForPeripherals(...)
```

Use:

```swift
for await devices in manager.scan() {

}
```

Clean.
Modern.
Production-ready.

---

# Installation

## Swift Package Manager

### Xcode

```text
File
→ Add Package Dependencies
```

Add:

```text
https://github.com/gopalsorathiya/NovyBleLiteSDK
```

---

# Manual XCFramework Integration

1. Download latest release:

```text
NovyBleLite.xcframework.zip
```

2. Drag into Xcode project

3. Enable:

```text
Embed & Sign
```

---

# Required Permissions

Add to `Info.plist`:

```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>Bluetooth is required to connect nearby BLE devices.</string>

<key>NSBluetoothPeripheralUsageDescription</key>
<string>Bluetooth access is required.</string>
```

---

# Quick Start

## Import SDK

```swift
import NovyBleLite
```

---

# Initialize

```swift
let manager = NovyBleManager()
```

---

# Scan Devices

```swift
Task {

    for await devices in manager.scan() {

        print(devices)
    }
}
```

---

# Connect Device

```swift
let result = await manager.connect(device.id)

switch result {

case .success:
    print("Connected")

case .failure(let error):
    print(error)
}
```

---

# Discover Services

```swift
let result = await manager.discoverServices()

switch result {

case .success(let services):
    print(services)

case .failure(let error):
    print(error)
}
```

---

# Read Characteristic

```swift
let result = await manager.read("2A29")

switch result {

case .success(let data):

    let value = String(
        data: data,
        encoding: .utf8
    )

    print(value ?? "")

case .failure(let error):
    print(error)
}
```

---

# Write Characteristic

```swift
let data = "Hello".data(using: .utf8)!

let result = await manager.write(
    "FFE1",
    data: data
)
```

---

# Notifications

```swift
await manager.setNotification(
    "FFE1",
    enabled: true
)

Task {

    for await value in manager.notifications("FFE1") {

        print(value.data)
    }
}
```

---

# Architecture

```text
App
 ↓
NovyBleManager
 ↓
NovyBleClient
 ↓
CoreBluetooth
```

---

# Included Features

| Feature | Supported |
|---|---|
| Scan | ✅ |
| Connect | ✅ |
| Read | ✅ |
| Write | ✅ |
| Notify | ✅ |
| Async/Await | ✅ |
| SwiftUI | ✅ |

---

# Demo App

Example app included:

- BLE Scanner
- Device Inspector
- Live Notifications
- Console Logs
- Service Explorer

---

# Roadmap

## Lite SDK

- Stable BLE APIs
- Better scanning filters
- Logging improvements
- Performance optimizations

## Pro SDK

- OTA / DFU
- Background Restore
- Auto Reconnect
- Device Automation
- MQTT Bridge
- Cloud Sync
- Enterprise Support

---

# Sponsor / Donate

If this SDK helps your project, consider supporting development.

## GitHub Sponsors

https://github.com/sponsors/gopalsorathiya

## UPI Support

```text
gopalsorathiya@okhdfcbank
```

Your support helps maintain:
- BLE tooling
- SDK updates
- bug fixes
- documentation
- demo apps

---

# Commercial Support

Need enterprise BLE features or custom integrations?

Contact:

```text
gopalsorathiya@gmail.com
```

Services:
- BLE Architecture
- SDK Integration
- Custom Firmware Apps
- BLE Performance Optimization
- OTA Solutions
- White-label BLE Apps

---

# License

Apache License 2.0

See the LICENSE file for details.

---

# Author

Gopal Sorathiya

Built with ❤️ for the BLE developer community.
