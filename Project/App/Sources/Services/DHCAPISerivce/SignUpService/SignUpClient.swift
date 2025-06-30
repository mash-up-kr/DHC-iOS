//
//  SignUpClient.swift
//  Flifin
//
//  Created by hyerin on 6/30/25.
//

import ComposableArchitecture

@DependencyClient
struct SignUpClient: Sendable {
  var fetchMissionCategories: () async throws -> [MissionCategory]
}

extension SignUpClient: DependencyKey {
  static var liveValue: SignUpClient {
    let networkManager = NetworkManager()
    return SignUpClient(
      fetchMissionCategories: {
        let endpoint = SignUpAPI.missionCategories
        
        return try await networkManager
          .request(endpoint)
          .map(to: MissionCategoryDTO.self)
          .toDomain
      }
    )
  }
  
  static var previewValue: SignUpClient {
    return SignUpClient()
  }
  
  static var testValue: SignUpClient {
    return SignUpClient()
  }
}

extension DependencyValues {
  var signUpClient: SignUpClient {
    get { self[SignUpClient.self] }
    set { self[SignUpClient.self] = newValue }
  }
}
