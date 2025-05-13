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




// 테스트

struct Post: Decodable {
  let userId: Int
  let id: Int
  let title: String
  let body: String
}

enum PostTarget: RequestTarget {
  case getPost(id: Int)

  var baseURL: URL {
    URL(string: "https://jsonplaceholder.typicode.com")!
  }

  var path: String {
    switch self {
    case .getPost(let id):
      return "/posts/\(id)"
    }
  }

  var method: HTTPMethod {
    .get
  }

  var headers: HTTPHeaders? {
    nil
  }

  var parameters: Parameters? {
    nil
  }
}



