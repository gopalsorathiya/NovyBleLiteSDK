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
            url: "https://github.com/gopalsorathiya/NovyBleLiteSDK/releases/download/1.0.0/NovyBleLite.xcframework.zip",
            checksum: "320b5adfc4cd67e7f8eb65c843f6f4017d12e70bfd30e52bc8477d5d92b78c61"
        )
    ]
)
