//
//  MissionClient.swift
//  Flifin
//
//  Created by 김유빈 on 7/3/25.
//

import Foundation

import ComposableArchitecture

@DependencyClient
struct MissionClient: Sendable {
  var updateMissionStatus: (_ missionId: String, _ finished: Bool) async throws -> Void
  var switchMission: (_ missionID: String) async throws -> SwitchMissionInfo
}

extension MissionClient: DependencyKey {
  static let liveValue: Self = {
    let networkManager = NetworkManager()

    return MissionClient(
      updateMissionStatus: { missionId, finished in
        _ = try await networkManager
          .request(MissionAPI.updateMissionStatus(missionId: missionId, finished: finished))
      },
      switchMission: { missionID in
        try await networkManager
          .request(MissionAPI.switchMission(missionID: missionID))
          .map(to: SwitchMissionDTO.self)
          .toDomain()
      }
    )
  }()

  static let previewValue = MissionClient(
    updateMissionStatus: { _, _ in },
    switchMission: { _ in .sample }
  )

  static let testValue = Self()
}

extension DependencyValues {
  var missionClient: MissionClient {
    get { self[MissionClient.self] }
    set { self[MissionClient.self] = newValue }
  }
}
