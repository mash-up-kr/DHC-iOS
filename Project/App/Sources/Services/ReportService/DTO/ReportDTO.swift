//
//  ReportDTO.swift
//  Flifin
//
//  Created by Aiden.lee on 7/1/25.
//

import Foundation

struct ReportDTO: Decodable {
  let totalSavedMoney: String
  let weeklySpendMoney: String
  let generationMoneyViewResponse: GenerationMoneyViewResponse
}

extension ReportDTO {
  struct GenerationMoneyViewResponse: Decodable {
    let generation: String
    let gender: String
    let averageSpendMoney: String
  }
}

extension ReportDTO {
  func toDomain() -> ReportInfo {
    ReportInfo(
      totalSavedMoney: Double(totalSavedMoney) ?? 0,
      weeklySpendMoney: Double(weeklySpendMoney) ?? 0,
      generationComparison: .init(
        generation: generationMoneyViewResponse.generation,
        gender: ReportInfo.GenerationComparison.Gender(
          rawValue: generationMoneyViewResponse.gender
        ) ?? .unknown,
        averageSpendMoney: Double(generationMoneyViewResponse.averageSpendMoney) ?? 0
      )
    )
  }
}
