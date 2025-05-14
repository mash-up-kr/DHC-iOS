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
  var parameters: Parameters? { get }

  func asURLRequest() throws -> URLRequest
}

extension RequestTarget {
  func asURLRequest() throws -> URLRequest {
    let url = baseURL.appendingPathComponent(path)
    var request = try URLRequest(url: url, method: method, headers: headers)
    request = try URLEncoding.default.encode(request, with: parameters)

    return request
  }
}
