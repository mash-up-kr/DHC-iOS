//
//  SignUpAPI.swift
//  Flifin
//
//  Created by hyerin on 6/30/25.
//

import Foundation

import Alamofire

enum SignUpAPI {
  case missionCategories
}

extension SignUpAPI: RequestTarget {
  var path: String {
    switch self {
    case .missionCategories:
      "/api/mission-categories"
    }
  }

  var method: HTTPMethod {
    switch self {
    case .missionCategories:
      .get
    }
  }

  var queryParameters: Parameters? {
    switch self {
    case .missionCategories:
      nil
    }
  }

  var bodyParameters: Parameters? {
    switch self {
    case .missionCategories:
      nil
    }
  }
}


