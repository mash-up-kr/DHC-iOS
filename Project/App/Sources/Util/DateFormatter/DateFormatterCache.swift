//
//  DateFormatterCache.swift
//  Flifin
//
//  Created by Aiden.lee on 6/29/25.
//

import Foundation

import ComposableArchitecture

/// DateFormatter 캐싱 시스템
/// 동일한 dateFormat에 대해 DateFormatter 인스턴스를 재사용하여 성능을 최적화합니다.
@DependencyClient
struct DateFormatterCache {

  private init() {}

  private let cache = MutexLock<[String: DateFormatter]>([:])

  /// 주어진 dateFormat과 locale에 해당하는 DateFormatter를 반환합니다.
  ///
  /// - Parameters:
  ///   - dateFormat: DateFormatter의 dateFormat
  ///   - locale: DateFormatter의 locale, 기본값은 "ko_KR" 입니다.
  /// - Returns: 캐시된 또는 새로 생성된 DateFormatter
  func formatter(for dateFormat: String, locale: Locale = .init(identifier: "ko_KR")) -> DateFormatter {
    let key = "\(dateFormat)_\(locale.identifier)"

    return cache.withLock { storage in
      if let existingFormatter = storage[key] {
        return existingFormatter
      }

      let formatter = DateFormatter()
      formatter.dateFormat = dateFormat
      formatter.locale = locale
      storage[key] = formatter
      return formatter
    }
  }

  /// 캐시된 모든 DateFormatter를 제거합니다.
  /// 메모리 관리가 필요한 경우에만 사용하세요.
  func clearCache() {
    cache.withLock { storage in
      storage.removeAll()
    }
  }
}

extension DateFormatterCache: DependencyKey {
  static let liveValue = DateFormatterCache()
  static let previewValue = DateFormatterCache()
  static let testValue = DateFormatterCache()
}

extension DependencyValues {
  var dateFormatterCache: DateFormatterCache {
    get { self[DateFormatterCache.self] }
    set { self[DateFormatterCache.self] = newValue }
  }
}
