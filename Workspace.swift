//
//  Workspace.swift
//  ProjectManifests
//
//  Created by hyerin on 6/2/25.
//

import ProjectDescription

let workspace = Workspace(
	name: "Flifin",
	projects: [
		"Project/App"
	],
	generationOptions: .options(
		autogeneratedWorkspaceSchemes: .disabled
	)
)
