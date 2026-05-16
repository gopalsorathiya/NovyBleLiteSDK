//
//  ConsoleView.swift
//  NovyBleLiteDemo
//
//  Created by Gopal sorathiya on 16/05/26.
//

import Foundation
import SwiftUI

struct ConsoleView: View {

    let logs: [String]

    var body: some View {

        ScrollView {

            LazyVStack(alignment: .leading) {

                let reversedLogs = Array(logs.reversed())

                ForEach(reversedLogs.indices, id: \.self) { index in

                    Text(reversedLogs[index])
                        .font(.caption.monospaced())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 2)
                }
            }
            .padding()
        }
        .frame(height: 180)
        .background(Color.black.opacity(0.05))
    }
}
