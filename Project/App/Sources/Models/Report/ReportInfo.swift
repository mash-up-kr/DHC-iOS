//
//  ReportInfo.swift
//  Flifin
//
//  Created by Aiden.lee on 7/1/25.
//

import Foundation

struct ReportInfo: Equatable {
  let totalSavedMoney: Double
  let weeklySavedMoney: Double
  let monthlySpendMoney: Double
  let generationComparison: GenerationComparison
}

extension ReportInfo {
  struct GenerationComparison: Equatable {
    let generation: String
    let gender: Gender
    let averageSpendMoney: Double

    enum Gender: String, Codable {
      case male = "MALE"
      case female = "FEMALE"
      case unknown = "UNKNOWN"

      var title: String {
        switch self {
        case .male: "남성"
        case .female: "여성"
        case .unknown: "Unknown"
        }
      }
    }
  }
}

extension ReportInfo {
  static let sample = ReportInfo(
    totalSavedMoney: 130000,
    weeklySavedMoney: 28000,
    monthlySpendMoney: 45600.00,
    generationComparison: GenerationComparison(
      generation: "20대",
      gender: .male,
      averageSpendMoney: 70400.00
    )
  )
}
