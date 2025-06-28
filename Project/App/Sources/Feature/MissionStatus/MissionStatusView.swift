//
//  MissionStatusView.swift
//  Flifin
//
//  Created by Aiden.lee on 6/8/25.
//

import SwiftUI

import ComposableArchitecture

struct MissionStatusView: View {
  @Bindable var store: StoreOf<MissionStatusReducer>
  @State private var currentPage: Date = Date()

  private let dates = [
    Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
    Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
    Calendar.current.date(byAdding: .day, value: 10, to: Date())!,
  ]

  private var dateModels: [CalendarDateModel] {
    dates.map {
      CalendarDateModel(
        date: $0,
        backgroundColor: ColorResource.Text.Highlights.primary.color
      )
    }
  }

  var body: some View {
    ScrollView {
      LargeNavigationTitleView(title: "통계")

      VStack(spacing: 0) {
        VStack(alignment: .leading, spacing: 12) {
          Text("소비 분석")
            .textStyle(.h5)
            .foregroundStyle(ColorResource.Neutral._50.color)

          MissionSummaryView(
            imageResource: .moneyWithWings,
            title: "지금까지 총",
            description: "130,000원 아꼈어요!"
          )

          SpendChartCardView(
            title: "이번주에 20대 남성 대비\n25,000원 더 절약했어요",
            chartData: [
              SpendChartData(category: "나", amount: 52000, isHighlighted: true),
              SpendChartData(category: "20대 남성", amount: 120000, isHighlighted: false),
            ]
          )
        }
        .padding(20)

        VStack(alignment: .leading, spacing: 12) {
          Text("미션 분석")
            .textStyle(.h5)
            .foregroundStyle(ColorResource.Neutral._50.color)

          MissionSummaryView(
            imageResource: .moneyWithWings,
            title: "5월달",
            description: "미션 평균 성공률 82%"
          )

          CalendarCardView(
            dateModels: [
              .init(
                date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
                backgroundColor: ColorResource.Text.Highlights.primary.color
              ),
              .init(
                date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                backgroundColor: ColorResource.Text.Highlights.primary.color
              ), .init(
                date: Calendar.current.date(byAdding: .day, value: 4, to: Date())!,
                backgroundColor: ColorResource.Text.Highlights.primary.color
              ),
            ]
          )
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
      }
    }
  }
}
