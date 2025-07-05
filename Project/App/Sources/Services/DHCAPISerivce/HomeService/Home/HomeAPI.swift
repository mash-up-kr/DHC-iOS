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
  case fortuneDetail(date: String)
}

extension HomeAPI: RequestTarget {
  var path: String {
    switch self {
    case .home:
      return "/view/users/{userID}/home"
    case .fortuneDetail:
      return "/api/users/{userID}/fortune"
    }
  }

  var method: HTTPMethod {
    switch self {
    case .home, .fortuneDetail:
      .get
    }
  }

  var queryParameters: Alamofire.Parameters? {
    switch self {
    case .home:
      nil
    case .fortuneDetail(let date):
      [
        "date": date,
        "format": "png"
      ]
    }
  }

  var bodyParameters: (any Encodable)? {
    switch self {
    case .home, .fortuneDetail:
      nil
    }
  }
}
