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
  case registerUser(RegisterUserRequest)
}

extension SignUpAPI: RequestTarget {
  var path: String {
    switch self {
      case .searchUser:
        "/api/users"
      case .missionCategories:
        "/api/mission-categories"
      case .registerUser:
        "/api/users/register"
    }
  }
  
  var method: HTTPMethod {
    switch self {
      case .searchUser, .missionCategories:
        .get
      case .registerUser:
        .post
    }
  }
  
  var headers: HTTPHeaders? {
    switch self {
    case .searchUser, .missionCategories:
      nil
    case .registerUser:
      [
        "Content-Type": "application/json"
      ]
    }
  }
  
  var queryParameters: Parameters? {
    switch self {
    case .searchUser(let deviceToken):
      [
        "userToken": deviceToken
      ]
    case .missionCategories:
      ["format": "png"]
    case .registerUser:
      nil
    }
  }
  
  var bodyParameters: (any Encodable)? {
    switch self {
      case .searchUser, .missionCategories:
        nil
      case .registerUser(let request):
        request
    }
  }
}


