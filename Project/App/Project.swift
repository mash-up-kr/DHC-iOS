import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
	name: "App",
	targets: [
		.target(
			name: "ProductName",
			destinations: .iOS,
			product: .app,
			productName: "ProductName",
			bundleId: "com.mashup.DHC-iOS",
			deploymentTargets: .iOS("18.0"),
			infoPlist: .default,
			sources: ["Sources/**"],
			resources: ["Resources/**"],
			dependencies: [
				.external(externalDependency: .alamofire),
				.external(externalDependency: .composableArchitecture)
			]
		)
	]
)
