//
//  SpendChartCardView.swift
//  Flifin
//
//  Created by Aiden.lee on 6/23/25.
//

import SwiftUI

public struct SpendChartCardView: View {
  private let title: AttributedString
  private let chartData: [SpendChartData]

  init(title: AttributedString, chartData: [SpendChartData]) {
    self.title = title
    self.chartData = chartData
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: 46) {
      Text(title)
        .textStyle(.h3)
        .foregroundStyle(ColorResource.Text.main.color)

      SpendChartView(data: chartData)
        .frame(height: 200)
    }
    .padding(20)
    .background(
      RoundedRectangle(cornerRadius: 8)
        .fill(ColorResource.Neutral._700.color)
    )
  }
}

#Preview {
  SpendChartCardView(
    title: "이번주에 20대 남성 대비\n25,000원 더 절약했어요",
    chartData: [
      SpendChartData(category: "나", amount: 52000, isHighlighted: true),
      SpendChartData(category: "20대 남성", amount: 120000, isHighlighted: false),
    ]
  )
}
