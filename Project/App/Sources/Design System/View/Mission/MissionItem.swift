//
//  MissionItem.swift
//  Flifin
//
//  Created by 김유빈 on 6/26/25.
//

import SwiftUI


struct MissionItem<V>: View where V: View {
  let missionTitle: String
  let isPinned: Bool
  @Binding var isMissionCompleted: Bool
  @ViewBuilder var badgeView: () -> V

  var body: some View {
    Button {
      isMissionCompleted.toggle()
    } label: {
      ZStack(alignment: .topLeading) {
        HStack(spacing: 16) {
          HStack(alignment: .top, spacing: 12) {
            badgeView()

            Text(missionTitle)
              .textStyle(.body3)
              .foregroundStyle(ColorResource.Text.Body.primary.color)
              .multilineTextAlignment(.leading)
              .frame(maxWidth: .infinity, alignment: .leading)
          }

          CheckMark(size: .medium, style: isMissionCompleted ? .active : .enabled)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .background(ColorResource.Neutral._700.color)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)

        if isPinned {
          pinView()
        }
      }
    }
  }

  private func pinView() -> some View {
    HStack(spacing: 0) {
      Image(ImageResource.Icon.pin)
        .resizable()
        .frame(width: 24, height: 24)

      Spacer()
        .frame(maxWidth: .infinity)
    }
    .frame(maxWidth: .infinity)
    .padding(.horizontal, 8)
    .padding(.top, -12)
    .padding(.trailing, -8)
  }
}

#Preview {
  VStack(spacing: 24) {
    PinnedMissionItemView(
      missionTitle: "가까운 거리 걸어가기",
      remainingDays: 3,
      isMissionCompleted: .constant(true)
    )
    
    DailyMissionItemView(
      missionTitle: "커피 안 마시기",
      missionLevel: .easy,
      isMissionCompleted: .constant(true)
    )
  }
}
