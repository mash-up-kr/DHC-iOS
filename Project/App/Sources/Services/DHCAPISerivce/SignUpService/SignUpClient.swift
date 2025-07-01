//
//  SignUpClient.swift
//  Flifin
//
//  Created by hyerin on 6/30/25.
//

import Foundation

import ComposableArchitecture

@DependencyClient
struct SignUpClient: Sendable {
  var searchUser: (UUID) async throws -> String
  var fetchMissionCategories: () async throws -> [MissionCategory]
  var registerUser: (
    _ deviceID: String,
    _ gender: Gender,
    _ birthday: Date,
    _ calendarType: CalendarType,
    _ birthTime: Date?,
    _ missionCategoryList: [String]
  ) async throws -> String
}

extension SignUpClient: DependencyKey {
  static var liveValue: SignUpClient {
    let networkManager = NetworkManager()
    return SignUpClient(
      searchUser: { deviceToken in
        let deviceTokenString = deviceToken.uuidString
        let endpoint = SignUpAPI.searchUser(deviceToken: deviceTokenString)
        
        return try await networkManager
          .request(endpoint)
          .map(to: UserIDDTO.self)
          .toDomain
      },
      fetchMissionCategories: {
        let endpoint = SignUpAPI.missionCategories
        
        return try await networkManager
          .request(endpoint)
          .map(to: MissionCategoryDTO.self)
          .toDomain
      },
      registerUser: { deviceID, gender, birthday, calendarType, birthTime, missionCategoryList in
        @Dependency(\.dateFormatterCache) var dateFormatterCache
        
        let birthdayString = dateFormatterCache.formatter(for: "yyyy-MM-dd").string(from: birthday)
        var birthTimeString = ""
        if let birthTime {
          birthTimeString = dateFormatterCache.formatter(for: "HH:mm:ss").string(from: birthTime)
        }
        
        let request = RegisterUserRequest(
          userToken: deviceID,
          gender: gender,
          birthDate: .init(
            date: birthdayString,
            calendarType: calendarType
          ),
          birthTime: birthTimeString,
          preferredMissionCategoryList: missionCategoryList
        )
        let endpoint = SignUpAPI.registerUser(request)
        
        return try await networkManager
          .request(endpoint)
          .map(to: UserIDDTO.self)
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
