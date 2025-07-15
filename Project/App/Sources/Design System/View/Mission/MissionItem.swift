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
  let isActive: Bool
  @Binding var isMissionCompleted: Bool
  @ViewBuilder var badgeView: () -> V

  var body: some View {
    HStack(spacing: 16) {
      HStack(alignment: .top, spacing: 12) {
        badgeView()

        Text(missionTitle)
          .textStyle(.body3)
          .foregroundStyle(
            isActive ? ColorResource.Text.Body.primary.color : ColorResource.Neutral
              ._400.color
          )
          .multilineTextAlignment(.leading)
          .frame(maxWidth: .infinity, alignment: .leading)
      }

      Button {
        isMissionCompleted.toggle()
      } label: {
        CheckMark(
          size: .medium,
          style: isActive
            ? (isMissionCompleted ? .active : .enabled)
            : .disabled
        )
      }
      .disabled(!isActive)
    }
    .frame(maxWidth: .infinity)
    .padding(.horizontal, 16)
    .padding(.vertical, 20)
    .background(ColorResource.Neutral._700.color)
    .clipShape(RoundedRectangle(cornerRadius: 12))
    .overlay(alignment: .topLeading) {
      if isPinned {
        pinView()
      }
    }
  }

  private func pinView() -> some View {
    Image(ImageResource.Icon.pin)
      .resizable()
      .frame(width: 24, height: 24)
      .padding(.horizontal, -12)
      .padding(.top, -12)
  }
}

#Preview {
  VStack(spacing: 24) {
    MissionItem(
      missionTitle: "가까운 거리 걸어가기",
      isPinned: true,
      isActive: true,
      isMissionCompleted: .constant(true),
    ) {
      DHCBadge(
        badgeTitle: "D-3",
        badgeStyle: .dDay,
        isActive: true
      )
    }

    MissionItem(
      missionTitle: "가까운 거리 걸어가기",
      isPinned: true,
      isActive: false,
      isMissionCompleted: .constant(false),
    ) {
      DHCBadge(
        badgeTitle: "D-3",
        badgeStyle: .dDay,
        isActive: false
      )
    }
  }
}
