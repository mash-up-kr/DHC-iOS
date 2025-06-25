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

  var body: some View {
    ScrollView {
      VStack {
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
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
      }
    }
  }
}
