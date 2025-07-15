//
//  HomePopup.swift
//  Flifin
//
//  Created by 김유빈 on 7/4/25.
//

import SwiftUI

struct HomePopup: View {
  let todaySavedAmount: String?
  let onSeeStatistics: () -> Void
  let onDismiss: () -> Void

  var body: some View {
    VStack(spacing: 12) {
      Button {
        onDismiss()
      } label: {
        Image(ImageResource.Icon.cancel)
          .resizable()
          .frame(width: 28, height: 28)
          .frame(maxWidth: .infinity, alignment: .trailing)
          .padding(.horizontal, 12)
      }

      VStack(spacing: 16) {
        DHCBadge(
          badgeTitle: "미션 성공",
          badgeStyle: .today
        )

        Text("대단해요!")
          .textStyle(.body2)
          .foregroundStyle(ColorResource.Neutral._200.color)

        VStack(spacing: 2) {
          HStack(spacing: 2) {
            Text("오늘 총")

            Text("\((todaySavedAmount ?? "0").formatToNumber)원")
              .foregroundStyle(LinearGradient(.text01))

            Text("을")
          }

          Text("절약했어요")
        }
        .textStyle(.h2_1)
        .foregroundStyle(ColorResource.Text.main.color)
      }

      ImageResource.celebration.image
        .resizable()
        .scaledToFit()

      VStack(spacing: 4) {
        CTAButton(
          size: .large,
          style: .primary,
          title: "통계 확인하기"
        ) {
          onSeeStatistics()
        }

        CTAButton(
          size: .large,
          style: .tertiary,
          title: "확인했어요"
        ) {
          onDismiss()
        }
      }
      .padding(.horizontal, 20)
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 16)
    .background(ColorResource.Neutral._700.color)
    .clipShape(RoundedRectangle(cornerRadius: 12))
  }
}

#Preview {
  HomePopup(todaySavedAmount: "3300") {} onDismiss: {}
}
