//
//  APIEventLogger.swift
//  Flifin
//
//  Created by hyerin on 6/30/25.
//

import Foundation

import Alamofire

final class APIEventLogger: EventMonitor {
  init() {}
  
  let queue = DispatchQueue(label: "myNetworkLogger")
  
  func requestDidFinish(_ request: Request) {
    if let currentRequest = request.request {
      print("""
            ------------------------------------------------------
             🛰 NETWORK Reqeust LOG\n
             - description: \(currentRequest.description)\n
            
             - url: \(currentRequest.url?.absoluteString ?? "")\n
             - method: \(currentRequest.httpMethod ?? "")\n
             - headers: \(currentRequest.allHTTPHeaderFields ?? [:])\n
             - body: \((NSString(data: currentRequest.httpBody ?? Data(), encoding: String.Encoding.utf8.rawValue) ?? "no httpBody").removingPercentEncoding ?? "no httpBody")
            ------------------------------------------------------
            \n\n
            """)
    } else {
      print("""
             🚨 NETWORK Reqeust Error
            """)
    }
  }
  
  func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
    print("""
        ------------------------------------------------------
        🛰 NETWORK Response LOG
        - url: \(request.request?.url?.absoluteString ?? "no URL")\n
        - result: \(response.result)\n
        - statusCode: \(response.response?.statusCode ?? 0)\n
        - data: \(response.data?.toPrettyPrintedString ?? "no Data")\n
        - stringData: \((NSString(data: response.data ?? Data(), encoding: String.Encoding.utf8.rawValue) ?? "no Data"))
        ------------------------------------------------------
        """
    )
  }
}
