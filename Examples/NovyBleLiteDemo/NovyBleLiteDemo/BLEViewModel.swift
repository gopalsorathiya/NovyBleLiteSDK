//
//  BLEViewModel.swift
//  NovyBleLiteDemo
//
//  Created by Gopal sorathiya on 16/05/26.
//

import Foundation
import SwiftUI
import NovyBleLite
import Combine

@MainActor
final class BLEViewModel: ObservableObject {

    let ble = NovybleManager()

    @Published var devices: [ScanDevice] = []
    @Published var services: [Service] = []
    @Published var logs: [String] = []

    @Published var connected = false
    @Published var scanning = false

    func startScan() {

        scanning = true
        logs.append("🔍 Started Scan")

        Task {

            for await result in ble.scan() {

                self.devices = result
            }

            scanning = false
            logs.append("🛑 Scan Finished")
        }
    }

    func stopScan() {
        ble.stopScan()
        scanning = false
        logs.append("🛑 Scan Stopped")
    }

    func connect(device: ScanDevice) {

        Task {

            logs.append("🔗 Connecting \(device.name ?? "")")

            let result = await ble.connect(device.id)

            switch result {

            case .success:

                connected = true
                logs.append("✅ Connected")

                await discoverServices()

            case .failure(let error):

                logs.append("❌ \(error.localizedDescription)")
            }
        }
    }

    func disconnect() {

        Task {

            _ = await ble.disconnect()

            connected = false
            services.removeAll()

            logs.append("🔌 Disconnected")
        }
    }

    func discoverServices() async {

        let result = await ble.discoverServices()

        switch result {

        case .success(let services):

            self.services = services
            logs.append("📦 Services Found: \(services.count)")

        case .failure(let error):

            logs.append("❌ \(error.localizedDescription)")
        }
    }

    func read(uuid: String) {

        Task {

            let result = await ble.read(uuid)

            switch result {

            case .success(let data):

                let value = String(data: data, encoding: .utf8) ?? data.description
                logs.append("📥 Read \(uuid): \(value)")

            case .failure(let error):

                logs.append("❌ Read Error: \(error.localizedDescription)")
            }
        }
    }

    func write(uuid: String, text: String) {

        Task {

            guard let data = text.data(using: .utf8) else { return }

            let result = await ble.write(
                uuid,
                data: data
            )

            switch result {

            case .success:
                logs.append("📤 Write Success")

            case .failure(let error):
                logs.append("❌ Write Error: \(error.localizedDescription)")
            }
        }
    }

    func enableNotifications(uuid: String) {

        Task {

            let result = await ble.setNotification(
                uuid,
                enabled: true
            )

            switch result {

            case .success:

                logs.append("🔔 Notifications Enabled")

                Task {

                    for await value in ble.notifications(uuid) {

                        let text = String(
                            data: value.data,
                            encoding: .utf8
                        ) ?? value.data.description

                        logs.append("📡 Notify: \(text)")
                    }
                }

            case .failure(let error):

                logs.append("❌ Notify Error: \(error.localizedDescription)")
            }
        }
    }
}
