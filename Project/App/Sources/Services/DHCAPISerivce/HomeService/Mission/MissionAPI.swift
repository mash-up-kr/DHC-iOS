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
  case switchMission(missionID: String)
}

extension MissionAPI: RequestTarget {
  var path: String {
    switch self {
    case .updateMissionStatus(let missionID, _), .switchMission(let missionID):
      return "/api/users/{userID}/missions/\(missionID)"
    }
  }

  var method: HTTPMethod {
    .put
  }
  
  var headers: HTTPHeaders? {
    switch self {
    case .updateMissionStatus, .switchMission:
      [
        "Content-Type": "application/json"
      ]
    }
  }

  var queryParameters: Alamofire.Parameters? {
    nil
  }

  var bodyParameters: (any Encodable)? {
    switch self {
    case .updateMissionStatus(_, let finished):
      return ["finished": finished]
    case .switchMission:
      return ["switch": true]
    }
  }
}
