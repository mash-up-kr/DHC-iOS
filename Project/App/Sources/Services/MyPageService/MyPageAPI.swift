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
}

extension MyPageAPI: RequestTarget {
  var path: String {
    switch self {
    case .myPage:
      "/view/users/{userID}/myPage"
    }
  }

  var method: HTTPMethod {
    switch self {
    case .myPage:
      .get
    }
  }

  var queryParameters: Parameters? {
    switch self {
    case .myPage:
      nil
    }
  }

  var bodyParameters: Parameters? {
    switch self {
    case .myPage:
      nil
    }
  }
}
