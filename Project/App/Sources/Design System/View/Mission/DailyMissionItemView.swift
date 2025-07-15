//
//  DailyMissionItemView.swift
//  Flifin
//
//  Created by 김유빈 on 6/26/25.
//

import SwiftUI

struct DailyMissionItemView: View {
  let missionTitle: String
  let missionLevel: DHCBadge.MissionLevel
  let isActive: Bool
  @Binding var isMissionCompleted: Bool

  var body: some View {
    MissionItem(
      missionTitle: missionTitle,
      isPinned: false,
      isActive: isActive,
      isMissionCompleted: $isMissionCompleted
    ) {
      DHCBadge(
        badgeTitle: missionLevel.displayName,
        badgeStyle: .missionLevel(missionLevel),
        isActive: isActive
      )
    }
  }
}

#Preview {
  DailyMissionItemView(
    missionTitle: "커피 안 마시기",
    missionLevel: .easy,
    isActive: true,
    isMissionCompleted: .constant(true)
  )

  DailyMissionItemView(
    missionTitle: "1시간 걸어가기",
    missionLevel: .medium,
    isActive: true,
    isMissionCompleted: .constant(false)
  )

  DailyMissionItemView(
    missionTitle: "2줄 테스트\n무지출무지출무지출무지출무지출무",
    missionLevel: .hard,
    isActive: true,
    isMissionCompleted: .constant(false)
  )
}
