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
  let birthTime: String
  let preferredMissionCategoryList: [String]
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
