//
//  SpendChartView.swift
//  Flifin
//
//  Created by Aiden.lee on 6/22/25.
//

import Charts
import SwiftUI

struct SpendChartData: Identifiable, Equatable {
  let id = UUID()
  let category: String
  let amount: Double
  let isHighlighted: Bool

  /// 금액 포맷팅 (예: 52000 -> "52,000원")
  var formatAmount: String {
    amount.formatted(.number) + "원"
  }
}

struct SpendChartView: View {
  private let data: [SpendChartData]
  private let maxAmount = 120000

  init(data: [SpendChartData]) {
    self.data = data
  }

  var body: some View {
    Chart(data) { item in
      BarMark(
        x: .value("Category", item.category),
        y: .value("Amount", item.amount),
        width: .fixed(48)
      )
      .foregroundStyle(
        item.isHighlighted ? ColorResource.Text.Highlights.primary.color : ColorResource.Neutral._400.color
      )
      .cornerRadius(8)
      .annotation(position: .top, spacing: 4) {
        SpendChartAnnotationView(item: item)
      }
    }
    .chartYScale(domain: 0...maxAmount)
    .chartYAxis {
      AxisMarks(position: .leading, values: .stride(by: 30000)) { value in
        AxisGridLine()
          .foregroundStyle(ColorResource.Neutral._600.color)

        AxisValueLabel {
          if let intValue = value.as(Int.self) {
            Text(formatYAxisLabel(intValue))
              .textStyle(.body6)
              .foregroundStyle(ColorResource.Neutral._200.color)
              .frame(width: 40, alignment: .leading)
              .padding(.trailing, 16)
          }
        }
      }
    }
    .chartXAxis {
      AxisMarks(position: .bottom) { item in
        AxisValueLabel {
          if let stringValue = item.as(String.self) {
            Text(stringValue)
              .padding(.top, 10)
              .textStyle(.h7)
              .foregroundStyle(
                isHighlightedCategory(stringValue)
                  ? ColorResource.Text.Highlights.secondary.color
                  : ColorResource.Neutral._300.color
              )
          }
        }
      }
    }
  }

  /// Y축 라벨 포맷팅 (예: 25000 -> "2.5 만원")
  private func formatYAxisLabel(_ amount: Int) -> String {
    if amount == 0 {
      return "0 원"
    }

    let amountInTenThousandWon = Double(amount) / 10000.0
    if amountInTenThousandWon.truncatingRemainder(dividingBy: 1) == 0 {
      return "\(Int(amountInTenThousandWon)) 만원"
    } else {
      return String(format: "%.1f 만원", amountInTenThousandWon)
    }
  }

  /// 주어진 카테고리가 하이라이트 되어야 하는지 확인합니다.
  private func isHighlightedCategory(_ category: String) -> Bool {
    data.first(where: { $0.category == category })?.isHighlighted ?? false
  }
}

#Preview {
  SpendChartView(data: [
    SpendChartData(category: "나", amount: 52000, isHighlighted: true),
    SpendChartData(category: "20대 남성", amount: 100000, isHighlighted: false),
  ])
  .background(Color.black)
}
