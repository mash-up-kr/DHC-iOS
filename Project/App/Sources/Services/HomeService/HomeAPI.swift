//
//  HomeAPI.swift
//  Flifin
//
//  Created by 김유빈 on 7/2/25.
//

import Foundation

import Alamofire

enum HomeAPI {
  case home
}

extension HomeAPI: RequestTarget {
  var path: String {
    switch self {
    case .home:
      return "/view/users/{userID}/home"
    }
  }

  var method: HTTPMethod {
    .get
  }

  var queryParameters: Alamofire.Parameters? {
    switch self {
    case .home:
      nil
    }
  }

  var bodyParameters: (any Encodable)? {
    switch self {
    case .home:
      nil
    }
  }
}
