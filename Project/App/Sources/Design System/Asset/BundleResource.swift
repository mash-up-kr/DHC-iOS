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
    case clover
    case knife
    case greenFace
    case redFace
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
    case .clover:
      return Bundle.main.url(forResource: "clover", withExtension: "png")
    case .knife:
      return Bundle.main.url(forResource: "knife", withExtension: "png")
    case .greenFace:
      return Bundle.main.url(forResource: "greenFace", withExtension: "png")
    case .redFace:
      return Bundle.main.url(forResource: "redFace", withExtension: "png")
    }
  }
}
