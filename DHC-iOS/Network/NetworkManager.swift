//
//  NetworkManager.swift
//  DHC-iOS
//
//  Created by 김유빈 on 5/6/25.
//

import Foundation

import Alamofire

protocol NetworkRequestable {
  func request(_ target: RequestTarget) async throws -> DHCNetworkResponse
}

final class NetworkManager: NetworkRequestable {
  func request(_ target: RequestTarget) async throws -> DHCNetworkResponse {
    let request = try target.asURLRequest()

    let response = await AF.request(request)
      .validate()
      .serializingResponse(using: DHCResponseSerializer())
      .response

    switch response.result {
    case .success(let decodedResponse):
      return decodedResponse
    case .failure(let error):
      throw error
    }
  }
}
