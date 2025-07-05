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
  case todayMissionDone(date: String)
  case fortuneDetail(date: String)
}

extension HomeAPI: RequestTarget {
  var path: String {
    switch self {
    case .home:
      return "/view/users/{userID}/home"
    case .fortuneDetail:
      return "/api/users/{userID}/fortune"
    case .todayMissionDone:
      return "/view/users/{userID}/done"
    }
  }

  var method: HTTPMethod {
    switch self {
    case .home, .fortuneDetail:
      .get
    case .todayMissionDone:
      .post
    }
  }

  var queryParameters: Alamofire.Parameters? {
    switch self {
    case .home, .todayMissionDone:
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
      return nil
    case .todayMissionDone(let date):
      return ["date": date]
    }
  }
}
