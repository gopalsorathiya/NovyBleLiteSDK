//
//  ScanView.swift
//  NovyBleLiteDemo
//
//  Created by Gopal sorathiya on 16/05/26.
//

import Foundation
import SwiftUI
import NovyBleLite

struct ScanView: View {

    @StateObject private var vm = BLEViewModel()

    var body: some View {

        NavigationStack {

            VStack {

                HStack {

                    Button(vm.scanning ? "Stop Scan" : "Start Scan") {

                        if vm.scanning {
                            vm.stopScan()
                        } else {
                            vm.startScan()
                        }
                    }
                    .buttonStyle(.borderedProminent)

                    Spacer()

                    Circle()
                        .fill(vm.ble.isPoweredOn ? .green : .red)
                        .frame(width: 14)
                }
                .padding()

                List(vm.devices, id: \.id) { device in

                    NavigationLink {

                        DeviceDetailView(
                            vm: vm,
                            device: device
                        )

                    } label: {

                        VStack(alignment: .leading) {

                            Text(device.name ?? "")

                            Text(device.id.uuidString)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                ConsoleView(logs: vm.logs)
            }
            .navigationTitle("Novyble Lite")
        }
    }
}
