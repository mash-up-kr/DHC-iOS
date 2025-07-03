//
//  ReportAPI.swift
//  Flifin
//
//  Created by Aiden.lee on 7/1/25.
//

import Foundation

import Alamofire

enum ReportAPI {
  case analysis
}

extension ReportAPI: RequestTarget {
  var path: String {
    switch self {
    case .analysis:
      "/view/users/{userID}/analysis"
    }
  }

  var method: HTTPMethod {
    switch self {
    case .analysis:
      .get
    }
  }

  var queryParameters: Parameters? {
    switch self {
    case .analysis:
      nil
    }
  }

  var bodyParameters: (any Encodable)? {
    switch self {
    case .analysis:
      nil
    }
  }
}
