//
//  SignUpAPI.swift
//  Flifin
//
//  Created by hyerin on 6/30/25.
//

import Foundation

import Alamofire

enum SignUpAPI {
  case searchUser(deviceToken: String)
  case missionCategories
}

extension SignUpAPI: RequestTarget {
  var path: String {
    switch self {
      case .searchUser:
        "/api/users"
      case .missionCategories:
        "/api/mission-categories"
    }
  }
  
  var method: HTTPMethod {
    switch self {
      case .searchUser, .missionCategories:
        .get
    }
  }
  
  var queryParameters: Parameters? {
    switch self {
    case .missionCategories:
      nil
      case .searchUser(let deviceToken):
        [
          "userToken": deviceToken
        ]
    }
  }

  var bodyParameters: Parameters? {
    switch self {
      case .searchUser, .missionCategories:
        nil
    }
  }
}


