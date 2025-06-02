//
//  TargetDependency+.swift
//  ProjectDescriptionHelpers
//
//  Created by hyerin on 6/2/25.
//

import ProjectDescription

extension TargetDependency {
	public static func external(externalDependency: ExternalDependency) -> TargetDependency {
		return .external(name: externalDependency.rawValue)
	}
}

public enum ExternalDependency: String {
	case composableArchitecture = "ComposableArchitecture"
	case alamofire = "Alamofire"
}
