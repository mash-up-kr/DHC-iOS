//
//  LaunchManager.swift
//  Flifin
//
//  Created by 최혜린 on 7/3/25.
//

import Foundation

import ComposableArchitecture

@DependencyClient
struct LaunchManager {
  var isFirstLaunchOfToday: () -> Bool = { true }
  var setLastLaunchDate: () -> Void
  var deleteLastLaunchDate: () -> Void
}

extension LaunchManager: DependencyKey {
  static var liveValue: LaunchManager = {
    @ObservationIgnored
    @Shared(.appStorage("lastLaunchDate")) var lastLaunchDate: String?
    @Dependency(\.dateFormatterCache) var dateFormatterCache
    
    return LaunchManager(
      isFirstLaunchOfToday: {
        if let lastLaunchDate {
          let today = dateFormatterCache.formatter(for: "yyyy-MM-dd").string(from: Date())
          return today != lastLaunchDate
        } else {
          return true
        }
      },
      setLastLaunchDate: {
        let today = dateFormatterCache.formatter(for: "yyyy-MM-dd").string(from: Date())
        $lastLaunchDate.withLock { lastLaunchDate in
          lastLaunchDate = today
        }
      },
      deleteLastLaunchDate: {
        $lastLaunchDate.withLock { lastLaunchDate in
          lastLaunchDate = nil
        }
      }
    )
  }()

  static let previewValue = LaunchManager(
    isFirstLaunchOfToday: { false },
    setLastLaunchDate: {},
    deleteLastLaunchDate: {}
  )

  static let testValue = Self()
}

extension DependencyValues {
  var launchManager: LaunchManager {
    get { self[LaunchManager.self] }
    set { self[LaunchManager.self] = newValue }
  }
}
