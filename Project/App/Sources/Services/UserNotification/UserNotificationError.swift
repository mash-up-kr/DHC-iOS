//
//  UserNotificationError.swift
//  ProductName
//
//  Created by 김유빈 on 6/19/25.
//

enum UserNotificationError: Error {
  case authorizationDenied
  case unknownError(Error)
}
