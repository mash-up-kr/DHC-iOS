//
//  MyPageAPI.swift
//  Flifin
//
//  Created by Aiden.lee on 6/29/25.
//

import Foundation

import Alamofire

enum MyPageAPI {
  case myPage
  case resetApp
}

extension MyPageAPI: RequestTarget {
  var path: String {
    switch self {
    case .myPage:
      "/view/users/{userID}/myPage"
    case .resetApp:
      "/api/users/{userID}"
    }
  }

  var method: HTTPMethod {
    switch self {
    case .myPage:
      .get
    case .resetApp:
      .delete
    }
  }

  var queryParameters: Parameters? {
    switch self {
    case .myPage, .resetApp:
      nil
    }
  }

  var bodyParameters: Parameters? {
    switch self {
    case .myPage, .resetApp:
      nil
    }
  }
}
