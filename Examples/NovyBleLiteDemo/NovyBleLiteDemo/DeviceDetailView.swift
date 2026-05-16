//
//  DeviceDetailView.swift
//  NovyBleLiteDemo
//
//  Created by Gopal sorathiya on 16/05/26.
//

import Foundation
import SwiftUI
import NovyBleLite

struct DeviceDetailView: View {

    @ObservedObject var vm: BLEViewModel
    let device: ScanDevice

    var body: some View {

        List {

            Section("Connection") {

                Button("Connect") {
                    vm.connect(device: device)
                }

                Button("Disconnect") {
                    vm.disconnect()
                }

                Text("MTU: \(vm.ble.mtu)")
            }

            Section("Services") {

                ForEach(vm.services, id: \.uuid) { service in

                    VStack(alignment: .leading) {

                        Text(service.uuid)

                        ForEach(service.characteristics, id: \.uuid) { char in

                            VStack(alignment: .leading) {

                                Text(char.uuid)
                                    .font(.caption)

                                HStack {

                                    Button("Read") {
                                        vm.read(uuid: char.uuid)
                                    }

                                    Button("Notify") {
                                        vm.enableNotifications(
                                            uuid: char.uuid
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(device.name ?? "")
    }
}
