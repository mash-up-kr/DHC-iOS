//
//  NetworkManager.swift
//  Flifin
//
//  Created by 김유빈 on 5/6/25.
//

import Foundation

import Alamofire

protocol NetworkRequestable {
  func request(_ target: RequestTarget) async throws -> DHCNetworkResponse
}

final class NetworkManager: NetworkRequestable {
  private  let responseSerializer = DHCResponseSerializer()

  func request(_ target: RequestTarget) async throws -> DHCNetworkResponse {
    let request: URLRequest
    do {
      request = try target.asURLRequest()
    } catch {
      throw NetworkManagerError.invalidURL
    }

    let response = await AF.request(request)
      .validate()
      .serializingResponse(using: responseSerializer)
      .response

    switch response.result {
    case .success(let decodedResponse):
      return decodedResponse
    case .failure(let error):
      throw NetworkManagerError.requestFailed(underlying: error)
    }
  }
}
