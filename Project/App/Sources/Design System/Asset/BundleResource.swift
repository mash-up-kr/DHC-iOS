//
//  BundleResource.swift
//  Flifin
//
//  Created by 최혜린 on 7/2/25.
//

import Foundation

extension URL {
  enum Resource {
    case splashLottie
  }
  
  static func urlForResource(_ resource: Resource) -> URL? {
    switch resource {
    case .splashLottie:
      return Bundle.main.url(forResource: "splash", withExtension: "json")
    }
  }
}
