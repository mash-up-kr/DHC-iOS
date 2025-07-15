//
//  DHCBadge.swift
//  Flifin
//
//  Created by 김유빈 on 6/26/25.
//

import SwiftUI

struct DHCBadge: View {
  let badgeTitle: String
  let badgeStyle: BadgeStyle

  var body: some View {
    Badge(
      badgeTitle: badgeTitle,
      textStyle: badgeStyle.textStyle,
      textColor: badgeStyle.textColor,
      backgroundColor: badgeStyle.backgroundColor
    )
  }
}

extension DHCBadge {
  enum BadgeStyle {
    case spendCategory
    case dDay
    case today
    case missionLevel(MissionLevel)

    var textStyle: Typography.TypographyStyle {
      switch self {
      case .spendCategory:
        return Typography.Head.h8
      case .dDay, .today, .missionLevel:
        return Typography.Body.body6
      }
    }

    var textColor: Color {
      switch self {
      case .spendCategory:
        return ColorResource.Text.Highlights.secondary.color
      case .dDay:
        return ColorResource.Violet._200.color
      case .today:
        return ColorResource.Text.Body.primary.color
      case .missionLevel(let level):
        return level.color
      }
    }

    var backgroundColor: Color {
      switch self {
      case .spendCategory, .today:
        return ColorResource.Background.glassEffect.color
      case .dDay, .missionLevel:
        return ColorResource.Background.badgePrimary.color
      }
    }
  }

  enum MissionLevel {
    case easy
    case medium
    case hard

    var displayName: String {
      switch self {
      case .easy:
        return "Easy"
      case .medium:
        return "Mid"
      case .hard:
        return "Hard"
      }
    }

    var color: Color {
      switch self {
      case .easy:
        return ColorResource.levelEasy.color
      case .medium:
        return ColorResource.Text.Highlights.secondary.color
      case .hard:
        return ColorResource.levelHard.color
      }
    }
  }
}

#Preview {
  VStack(spacing: 8) {
    DHCBadge(
      badgeTitle: "식음료",
      badgeStyle: .spendCategory
    )

    DHCBadge(
      badgeTitle: "2025년 5월 20일",
      badgeStyle: .today
    )

    DHCBadge(
      badgeTitle: "D-12",
      badgeStyle: .dDay
    )

    DHCBadge(
      badgeTitle: "Easy",
      badgeStyle: .missionLevel(.easy)
    )

    DHCBadge(
      badgeTitle: "Medium",
      badgeStyle: .missionLevel(.medium)
    )

    DHCBadge(
      badgeTitle: "Hard",
      badgeStyle: .missionLevel(.hard)
    )
  }
}
