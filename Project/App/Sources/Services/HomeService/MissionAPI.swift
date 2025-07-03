//
//  MissionAPI.swift
//  Flifin
//
//  Created by 김유빈 on 7/3/25.
//

import Foundation

import Alamofire

enum MissionAPI {
  case updateMissionStatus(missionId: String, finished: Bool)
}

extension MissionAPI: RequestTarget {
  var path: String {
    switch self {
    case .updateMissionStatus(let missionID, _):
      return "/view/users/{userID}/missions/\(missionID)"
    }
  }

  var method: HTTPMethod {
    .put
  }

  var queryParameters: Alamofire.Parameters? {
    nil
  }

  var bodyParameters: Alamofire.Parameters? {
    switch self {
    case .updateMissionStatus(_, let finished):
      return ["finished": finished]
    }
  }
}
