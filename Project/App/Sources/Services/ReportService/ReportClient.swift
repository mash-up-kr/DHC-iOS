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
  var fetchMissionHistoryCalendar: @Sendable (_ yearMonth: String) async throws -> MissionHistoryCalendar
}

extension ReportClient: DependencyKey {
  static let liveValue: Self = {
    let networkManager = NetworkManager()

    return ReportClient(fetchReport: {
      try await networkManager
        .request(ReportAPI.analysis)
        .map(to: ReportDTO.self)
        .toDomain()
    }, fetchMissionHistoryCalendar: { yearMonth in
      try await networkManager
        .request(ReportAPI.calendar(yearMonth: yearMonth))
        .map(to: MissionHistoryCalendarDTO.self)
        .toDomain()
    })
  }()

  static let previewValue = Self()
  static let testValue = Self()
}

extension DependencyValues {
  var reportClient: ReportClient {
    get { self[ReportClient.self] }
    set { self[ReportClient.self] = newValue }
  }
}
