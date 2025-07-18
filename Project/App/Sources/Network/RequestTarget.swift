//
//  RequestTarget.swift
//  Flifin
//
//  Created by 김유빈 on 5/9/25.
//

import Foundation

import Alamofire

protocol RequestTarget {
  var baseURL: URL { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var headers: HTTPHeaders? { get }
  var queryParameters: Parameters? { get }
  var bodyParameters: (any Encodable)? { get }

  func asURLRequest() throws -> URLRequest
}

extension RequestTarget {
  var baseURL: URL {
    DHCEnvironment.baseURL
  }

  var headers: HTTPHeaders? {
    return nil
  }

  func asURLRequest() throws -> URLRequest {
    var url = baseURL.appendingPathComponent(path)

    if let queryParameters {
      let queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
      url = url.appending(queryItems: queryItems)
    }

    var request = URLRequest(url: url)

    request.httpMethod = method.rawValue

    if let headers { request.headers = headers }

    if let bodyParameters {
      do {
        request.httpBody = try JSONEncoder().encode(bodyParameters)
      }
    }

    return request
  }
}
