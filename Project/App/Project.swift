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
			infoPlist: .extendingDefault(
				with: [
					"UIAppFonts": [
						"WantedSans-Bold.otf",
						"WantedSans-SemiBold.otf",
						"WantedSans-Medium.otf",
						"WantedSans-regular.otf"
					]
				]
			),
			sources: ["Sources/**"],
			resources: ["Resources/**"],
			dependencies: [
				.external(externalDependency: .alamofire),
				.external(externalDependency: .composableArchitecture)
			],
			settings: .settings(
				base: [
					"DEVELOPMENT_TEAM": "MYR6MP3VKX",
					"CODE_SIGN_STYLE": "Manual",
					"PROVISIONING_PROFILE_SPECIFIER": "match Development com.mashup.DHC-iOS",
					"CODE_SIGN_IDENTITY": "Apple Development: Hyerin Choe (QKKN56KGD9)"
				]
			)
		)
	],
	resourceSynthesizers: [
		.custom(name: "Fonts", parser: .fonts, extensions: ["otf"]),
	]
)
