//
//  PinnedMissionItemView.swift
//  Flifin
//
//  Created by 김유빈 on 6/26/25.
//

import SwiftUI

// TODO: 디자인팀 답변 오면, 고정 미션 끝나는 당일 표현 방식 적용하기 (D-day? D-0?)
struct PinnedMissionItemView: View {
  let missionTitle: String
  let remainingDays: Int
  @Binding var isMissionCompleted: Bool

  var body: some View {
    MissionItem(
      missionTitle: missionTitle,
      isPinned: true,
      isMissionCompleted: $isMissionCompleted
    ) {
      DHCBadge(
        badgeTitle: "D-\(remainingDays)",
        badgeStyle: .spendCategory
      )
    }
  }
}

#Preview {
  PinnedMissionItemView(
    missionTitle: "텀블러 들고 다니기",
    remainingDays: 14,
    isMissionCompleted: .constant(true)
  )

  PinnedMissionItemView(
    missionTitle: "텀블러 들고 다니기",
    remainingDays: 0,
    isMissionCompleted: .constant(false)
  )
}
