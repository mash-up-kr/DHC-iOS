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
  /// 데이터를 채우는 이스터에그
  case addJulyHistory
}

extension ReportAPI: RequestTarget {
  var path: String {
    switch self {
    case .analysis:
      "/view/users/{userID}/analysis"
    case .calendar:
      "/view/users/{userID}/calendar"
    case .addJulyHistory:
      "/api/users/{userID}/add-july-history"
    }
  }

  var method: HTTPMethod {
    switch self {
    case .analysis, .calendar:
      .get
    case .addJulyHistory:
      .post
    }
  }

  var queryParameters: Parameters? {
    switch self {
    case .analysis, .addJulyHistory:
      nil
    case .calendar(let yearMonth):
      ["yearMonth": yearMonth]
    }
  }

  var bodyParameters: (any Encodable)? {
    switch self {
    case .analysis, .calendar, .addJulyHistory:
      nil
    }
  }
}
