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
  var completeMission: (_ missionId: String, _ finished: Bool) async throws -> Void
}

extension MissionClient: DependencyKey {
  static let liveValue: Self = {
    let networkManager = NetworkManager()

    return MissionClient(
      completeMission: { missionId, finished in
        _ = try await networkManager
          .request(MissionAPI.updateMissionStatus(missionId: missionId, finished: finished))
      }
    )
  }()

  static let previewValue = MissionClient(
    completeMission: { _, _ in }
  )

  static let testValue = MissionClient(
    completeMission: { _, _ in }
  )
}

extension DependencyValues {
  var missionClient: MissionClient {
    get { self[MissionClient.self] }
    set { self[MissionClient.self] = newValue }
  }
}
