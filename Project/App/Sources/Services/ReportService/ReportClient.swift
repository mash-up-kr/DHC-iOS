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
  var fetchMissionHistoryCalendar: @Sendable (_ yearMonth: String, _ usesCache: Bool) async throws -> MissionHistoryCalendar
  var addJulyHistory: @Sendable () async throws -> Void
}

extension ReportClient: DependencyKey {
  static let liveValue: Self = {
    let networkManager = NetworkManager()
    nonisolated(unsafe) let cache = MutexLock<[String: MissionHistoryCalendar]>([:])

    return ReportClient(fetchReport: {
      try await networkManager
        .request(ReportAPI.analysis)
        .map(to: ReportDTO.self)
        .toDomain()
    }, fetchMissionHistoryCalendar: { yearMonth, usesCache in
      let cachedResult = cache.withLock {
        $0[yearMonth]
      }

      if usesCache, let cachedResult {
        return cachedResult
      }

      let result = try await networkManager
        .request(ReportAPI.calendar(yearMonth: yearMonth))
        .map(to: MissionHistoryCalendarDTO.self)
        .toDomain()

      cache.withLock {
        $0[yearMonth] = result
      }

      return result
    }, addJulyHistory: {
      _ = try await networkManager
        .request(ReportAPI.addJulyHistory)
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
