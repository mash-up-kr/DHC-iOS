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

struct DHCResponseSerializer: ResponseSerializer {
  func serialize(
    request: URLRequest?,
    response: HTTPURLResponse?,
    data: Data?,
    error: Error?
  ) throws -> DHCNetworkResponse {
    if let error {
      throw NetworkManagerError.requestFailed(underlying: error)
    }

    return DHCNetworkResponse(
      statusCode: response?.statusCode,
      data: data,
      response: response
    )
  }
}
