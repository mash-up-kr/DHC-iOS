//
//  NetworkManager.swift
//  DHC-iOS
//
//  Created by 김유빈 on 5/6/25.
//

import Foundation

import Alamofire

final class NetworkManager {
  static let shared = NetworkManager()
  private init() {}

  func request<T: Decodable>(_ target: RequestTarget, type: T.Type) async throws -> T {
    let request = try target.asURLRequest()
    let response = await AF.request(request)
      .validate()
      .serializingDecodable(T.self)
      .response

    switch response.result {
    case .success(let decoded):
      return decoded
    case .failure(let error):
      throw error
    }
  }
}
