//
//  RequestTarget.swift
//  DHC-iOS
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
  var bodyParameters: Parameters? { get }

  func asURLRequest() throws -> URLRequest
}

extension RequestTarget {
  func asURLRequest() throws -> URLRequest {
    var url = baseURL.appendingPathComponent(path)
    
    if let queryParameters {
      var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
      components?.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
      
      guard let modifiedURL = components?.url else {
        throw NetworkManagerError.invalidURL
      }
      
      url = modifiedURL
    }

    var request = URLRequest(url: url)

    request.httpMethod = method.rawValue

    if let headers {
      request.allHTTPHeaderFields = headers.dictionary
    }

    if let bodyParameters {
      request.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters)
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }

    return request
  }
}
