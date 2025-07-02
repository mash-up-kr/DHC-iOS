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
  /// yearMonth는 "yyyy-MM" 포맷
  case calendar(yearMonth: String)
}

extension ReportAPI: RequestTarget {
  var path: String {
    switch self {
    case .analysis:
      "/view/users/{userID}/analysis"
    case .calendar:
      "/view/users/{userID}/calendar"
    }
  }

  var method: HTTPMethod {
    switch self {
    case .analysis, .calendar:
      .get
    }
  }

  var queryParameters: Parameters? {
    switch self {
    case .analysis:
      nil
    case .calendar(let yearMonth):
      ["yearMonth": yearMonth]
    }
  }

  var bodyParameters: Parameters? {
    switch self {
    case .analysis, .calendar:
      nil
    }
  }
}
