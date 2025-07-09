//
//  RegisterUserRequest.swift
//  Flifin
//
//  Created by hyerin on 6/30/25.
//

import Foundation

struct RegisterUserRequest: Encodable {
  let userToken: String
  let gender: Gender
  let birthDate: BirthDateInfo
  let birthTime: String?
  let preferredMissionCategoryList: [String]
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(userToken, forKey: .userToken)
    try container.encode(gender, forKey: .gender)
    try container.encode(birthDate, forKey: .birthDate)
    try container.encode(preferredMissionCategoryList, forKey: .preferredMissionCategoryList)
    try container.encode(birthTime, forKey: .birthTime)
  }
  
  private enum CodingKeys: String, CodingKey {
    case userToken, gender, birthDate, birthTime, preferredMissionCategoryList
  }
}

extension RegisterUserRequest {
  struct BirthDateInfo: Encodable {
    let date: String
    let calendarType: CalendarType
  }
}

enum Gender: String, Encodable {
  case male = "MALE"
  case female = "FEMALE"
  
  var title: String {
    switch self {
      case .male:
        return "남성"
      case .female:
        return "여성"
    }
  }
}

enum CalendarType: String, Encodable {
  case lunar = "LUNAR" // 음력
  case solar = "SOLAR" // 양력
}
