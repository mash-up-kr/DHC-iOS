//
//  MissionListView.swift
//  Flifin
//
//  Created by 김유빈 on 6/29/25.
//

import SwiftUI

struct MissionListView: View {
    var body: some View {
      VStack(spacing: 24) {
        pinnedMissionSection

        dailyMissionSection
      }
      .padding(.horizontal, 20)
    }
  
  private var pinnedMissionSection: some View {
    VStack(spacing: 4) {
      HStack(spacing: 12) {
        HStack(spacing: 8) {
          Text("소비습관 미션")
            .textStyle(.h4_1)
            .foregroundStyle(ColorResource.Text.Body.primary.color)

          Button {
            // TODO: 툴팁 띄우기
          } label: {
            Image(ImageResource.Icon.info)
              .renderingMode(.template)
              .foregroundStyle(ColorResource.Neutral._400.color)
              .frame(width: 24, height: 24)
          }
        }

        Text("Category") // TODO: 소비 카테고리 -> Badge 컴포넌트로 대체하기 / 카테고리 연결
      }
      .frame(maxWidth: .infinity, alignment: .leading)

      // TODO: PinnedMissionItemView 넣기
    }
  }
  
  private var dailyMissionSection: some View {
    VStack(spacing: 16) {
      Text("금전운 기반 일일 미션")
        .textStyle(.h4_1)
        .foregroundStyle(ColorResource.Text.Body.primary.color)

      // TODO: DailyMissionItemView 넣기
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

#Preview {
    MissionListView()
}
