//
//  PinnedMissionItemView.swift
//  Flifin
//
//  Created by 김유빈 on 6/26/25.
//

import SwiftUI

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
        badgeTitle: badgeTitle,
        badgeStyle: .spendCategory
      )
    }
  }
  
  private var badgeTitle: String {
    remainingDays == 0 ? "D-day" : "D-\(remainingDays)"
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
