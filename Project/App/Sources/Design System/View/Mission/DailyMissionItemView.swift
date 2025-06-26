//
//  DailyMissionItemView.swift
//  Flifin
//
//  Created by 김유빈 on 6/26/25.
//

import SwiftUI

extension DailyMissionItemView {
  enum MissionLevel {
    case easy
    case medium
    case hard

    var displayName: String {
      switch self {
      case .easy:
        return "Easy"
      case .medium:
        return "Medium"
      case .hard:
        return "Hard"
      }
    }

    var textColor: Color {
      switch self {
      case .easy:
        return ColorResource.levelEasy.color
      case .medium:
        return ColorResource.levelMedium.color
      case .hard:
        return ColorResource.levelHard.color
      }
    }
  }
}

struct DailyMissionItemView: View {
  let missionTitle: String
  let missionLevel: DHCBadge.MissionLevel
  @Binding var isMissionCompleted: Bool

  var body: some View {
    MissionItem(
      missionTitle: missionTitle,
      isPinned: false,
      isMissionCompleted: $isMissionCompleted
    ) {
      DHCBadge(
        badgeTitle: missionLevel.displayName,
        badgeStyle: .missionLevel(missionLevel)
      )
    }
  }
}

#Preview {
  DailyMissionItemView(
    missionTitle: "커피 안 마시기",
    missionLevel: .easy,
    isMissionCompleted: .constant(true)
  )

  DailyMissionItemView(
    missionTitle: "1시간 걸어가기",
    missionLevel: .medium,
    isMissionCompleted: .constant(false)
  )

  DailyMissionItemView(
    missionTitle: "2줄 테스트\n무지출무지출무지출무지출무지출무",
    missionLevel: .hard,
    isMissionCompleted: .constant(false)
  )
}
