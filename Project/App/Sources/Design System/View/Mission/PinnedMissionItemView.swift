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
  let isActive: Bool
  @Binding var isMissionCompleted: Bool

  var body: some View {
    MissionItem(
      missionTitle: missionTitle,
      isPinned: true,
      isActive: isActive,
      isMissionCompleted: $isMissionCompleted
    ) {
      DHCBadge(
        badgeTitle: badgeTitle,
        badgeStyle: .spendCategory,
        isActive: isActive
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
    isActive: true,
    isMissionCompleted: .constant(true)
  )

  PinnedMissionItemView(
    missionTitle: "텀블러 들고 다니기",
    remainingDays: 0,
    isActive: false,
    isMissionCompleted: .constant(false)
  )
}
