// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings(
	// Customize the product types for specific package product
	// Default is .staticFramework
	// productTypes: ["Alamofire": .framework,]
  productTypes: [:]
)
#endif

let package = Package(
  name: "DHC",
  dependencies: [
    .package(url: "https://github.com/Alamofire/Alamofire.git", exact: .init(stringLiteral: "5.10.2")),
    .package(
      url: "https://github.com/pointfreeco/swift-composable-architecture.git",
      exact: .init(stringLiteral: "1.19.1")
    ),
    .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", .upToNextMajor(from: "3.1.0")),
  ]
)
