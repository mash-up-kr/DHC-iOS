//
//  NetworkResponse.swift
//  Flifin
//
//  Created by 김유빈 on 5/19/25.
//

import Foundation

import Alamofire

struct DHCNetworkResponse {
  let statusCode: Int?
  let data: Data?
  let response: HTTPURLResponse?
}

extension DHCNetworkResponse {
  func map<T: Decodable>(to type: T.Type) throws -> T {
    guard let data else {
      throw NetworkManagerError.emptyData
    }
    
    do {
      return try JSONDecoder().decode(type, from: data)
    } catch let error as DecodingError {
      #if DEBUG
      print("🐞 [Decode] error:", error)
      if let jsonString = String(data: data, encoding: .utf8) {
        print("🐞 [Decode] raw json:", jsonString)
      }
      switch error {
      case .typeMismatch(let type, let context):
        print("🐞 [Decode] typeMismatch:", type, context.codingPath, context.debugDescription)
      case .valueNotFound(let type, let context):
        print("🐞 [Decode] valueNotFound:", type, context.codingPath, context.debugDescription)
      case .keyNotFound(let key, let context):
        print("🐞 [Decode] keyNotFound:", key, context.codingPath, context.debugDescription)
      case .dataCorrupted(let context):
        print("🐞 [Decode] dataCorrupted:", context.codingPath, context.debugDescription)
      @unknown default:
        print("🐞 [Decode] unknown error")
      }
      if let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
        print("🐞 [Decode] top-level keys:", dict.keys)
      }
      #endif
      throw NetworkManagerError.decodingFailed
    } catch {
      #if DEBUG
      print("🐞 [Decode] undefined error:", error)
      #endif
      throw NetworkManagerError.unknown
    }
  }
}

struct DHCResponseSerializer: ResponseSerializer {
  func serialize(
    request: URLRequest?,
    response: HTTPURLResponse?,
    data: Data?,
    error: Error?
  ) throws -> DHCNetworkResponse {
    if let error {
      throw NetworkManagerError.requestFailed(underlying: error, statusCode: response?.statusCode ?? -1)
    }

    return DHCNetworkResponse(
      statusCode: response?.statusCode,
      data: data,
      response: response
    )
  }
}
