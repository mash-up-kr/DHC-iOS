//
//  NetworkRequestInterceptor.swift
//  Flifin
//
//  Created by Aiden.lee on 6/28/25.
//

import Foundation

import Alamofire
import ComposableArchitecture

struct NetworkRequestInterceptor: RequestInterceptor {
  @Dependency(\.userManager) var userManager

  func adapt(
    _ urlRequest: URLRequest,
    for session: Session,
    completion: @escaping (Result<URLRequest, any Error>) -> Void
  ) {
    var modifiedRequest = urlRequest

    // URL이 존재하는지 확인
    guard let url = urlRequest.url else {
      completion(.success(urlRequest))
      return
    }

    let path = url.path

    // {userID} 패턴이 포함된 경우 실제 userID로 교체
    if path.contains("{userID}") {
      guard let actualUserID = userManager.getUserID() else {
        // userID가 없는 경우 에러 반환
        completion(.failure(NetworkManagerError.userIDNotFound))
        return
      }

      guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
        completion(.failure(NetworkManagerError.invalidURL))
        return
      }

      // {userID}를 실제 userID로 교체
      urlComponents.path = path.replacingOccurrences(of: "{userID}", with: actualUserID)

      // 새로운 URL 생성
      let newURL = urlComponents.url

      // 수정된 URL로 URLRequest 업데이트
      modifiedRequest.url = newURL
    }

    completion(.success(modifiedRequest))
  }
}
