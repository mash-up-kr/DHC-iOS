//
//  BundleResource.swift
//  Flifin
//
//  Created by 최혜린 on 7/2/25.
//

import Foundation

extension URL {
  enum Resource {
    case fortuneCardFrontDefaultView
    case fortuneCardBackView
    case splashLottie
    case onboardingVideo
  }
  
  static func urlForResource(_ resource: Resource) -> URL? {
    switch resource {
    case .fortuneCardFrontDefaultView:
      return Bundle.main.url(forResource: "fortuneCardFrontDefaultView", withExtension: "png")
    case .fortuneCardBackView:
      return Bundle.main.url(forResource: "fortuneCardBackView", withExtension: "png")
    case .splashLottie:
      return Bundle.main.url(forResource: "splash", withExtension: "json")
    case .onboardingVideo:
      return Bundle.main.url(forResource: "onboardingVideo", withExtension: "mp4")
    }
  }
}
