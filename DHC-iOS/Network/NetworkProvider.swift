//
//  NetworkProvider.swift
//  DHC-iOS
//
//  Created by 김유빈 on 4/21/25.
//

import Foundation

import Moya

final class NetworkProvider<T: TargetType> {
  private let provider: MoyaProvider<T>
  
  init() {
    self.provider = MoyaProvider<T>()
  }
  
  func request<D: Decodable>(_ target: T, type: D.Type) async throws -> D {
    return try await withCheckedThrowingContinuation { continuation in
      provider.request(target) { result in
        switch result {
        case let .success(response):
          do {
            _ = try response.filterSuccessfulStatusCodes()
            let decoded = try JSONDecoder().decode(D.self, from: response.data)
            continuation.resume(returning: decoded)
          } catch {
            continuation.resume(throwing: error)
          }
          
        case let .failure(error):
          continuation.resume(throwing: error)
        }
      }
    }
  }
}
