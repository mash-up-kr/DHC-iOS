//
//  API.swift
//  DHC-iOS
//
//  Created by 김유빈 on 4/21/25.
//

import Foundation

import Moya

// TODO: 명세서 나오면 API case 추가하기

enum API { }

extension API: TargetType {
  var baseURL: URL { URL(string: "")! }
  
  var path: String {
    switch self { }
  }
  
  var method: Moya.Method {
    switch self { }
  }
    
  var task: Task {
    switch self { }
  }
  
  var headers: [String : String]? {
    switch self { }
  }
  
  var validationType: ValidationType { .successCodes }
}
