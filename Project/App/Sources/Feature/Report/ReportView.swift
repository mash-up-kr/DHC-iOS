//
//  ReportView.swift
//  Flifin
//
//  Created by Aiden.lee on 6/8/25.
//

import SwiftUI

import ComposableArchitecture

struct ReportView: View {
  @Bindable var store: StoreOf<ReportReducer>
  @State private var currentPage = Date()

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
      LargeNavigationTitleView(title: "리포트")
        .unredacted()

      VStack(spacing: 0) {
        VStack(alignment: .leading, spacing: 12) {
          Text("소비 분석")
            .textStyle(.h5)
            .foregroundStyle(ColorResource.Neutral._50.color)

          MissionSummaryView(
            imageResource: .moneyWithWings,
            title: "지금까지 총",
            description: "\(store.reportInfo.totalSavedMoney.formatted(.number))원 아꼈어요!"
          )

          if let spendChart = store.spendChart {
            SpendChartCardView(
              title: spendChart.title,
              chartData: spendChart.chartData
            )
          }
        }
        .padding(20)

        VStack(alignment: .leading, spacing: 12) {
          Text("미션 분석")
            .textStyle(.h5)
            .foregroundStyle(ColorResource.Neutral._50.color)

          if let currentMonthHistory = store.currentMonthHistory {
            MissionSummaryView(
              imageResource: .moneyWithWings,
              title: "\(currentMonthHistory.month)월달",
              description: "미션 평균 성공률 \(currentMonthHistory.averageSucceedProbability)%"
            )
          }

          CalendarCardView(
            displayedMonth: $store.currentCalendarMonth,
            dateModels: store.calendarDateModels
          )
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
      }
    }
    .onAppear {
      store.send(.onAppear)
    }
    .contentMargins(.bottom, 46)
    .radialGradientBackground(
      type: .backgroundGradient02,
      endRadiusMultiplier: 1.2,
      scaleEffectX: 1.8
    )
    .background(ColorResource.Background.main.color)
    .redacted(reason: store.isRedacted ? .placeholder : [])
  }
}
