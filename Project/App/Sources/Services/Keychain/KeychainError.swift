//
//  KeychainError.swift
//  Flifin
//
//  Created by 김유빈 on 6/12/25.
//

enum KeychainError: Error {
  case stringEncodingFailed
  case saveFailed
  case loadFailed
  case deleteFailed
}
