// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "NovyBleLite",
    
    platforms: [
        .iOS(.v13)
    ],
    
    products: [
        .library(
            name: "NovyBleLite",
            targets: ["NovyBleLite"]
        )
    ],
    
    targets: [
        .binaryTarget(
            name: "NovyBleLite",
            url: "https://github.com/gopalsorathiya/NovyBleLiteSDK/releases/download/1.0.2/NovyBleLite.xcframework.zip",
            checksum: "253492e363edaf2e7ee65485ad99ada3709ba56c1fe16d334283941725622305"
        )
    ]
)
