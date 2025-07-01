//
//  ReportClient.swift
//  Flifin
//
//  Created by Aiden.lee on 7/1/25.
//

import Foundation

import ComposableArchitecture

@DependencyClient
struct ReportClient {
  var fetchReport: @Sendable () async throws -> ReportInfo
}

extension ReportClient: DependencyKey {
  static let liveValue: Self = {
    let networkManager = NetworkManager()

    return ReportClient(fetchReport: {
      try await networkManager
        .request(ReportAPI.analysis)
        .map(to: ReportDTO.self)
        .toDomain()
    })
  }()

  static let previewValue = ReportClient(
    fetchReport: { .sample }
  )
  static let testValue = Self()
}

extension DependencyValues {
  var reportClient: ReportClient {
    get { self[ReportClient.self] }
    set { self[ReportClient.self] = newValue }
  }
}
