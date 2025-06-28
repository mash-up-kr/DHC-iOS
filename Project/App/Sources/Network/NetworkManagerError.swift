//
//  NetworkManagerError.swift
//  Flifin
//
//  Created by 김유빈 on 5/19/25.
//

enum NetworkManagerError: Error {
  case invalidURL
  case requestFailed(underlying: Error)
  case decodingFailed
  case emptyResponse
  case userIDNotFound
  case unknown
}
