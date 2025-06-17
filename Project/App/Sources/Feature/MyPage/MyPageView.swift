//
//  MyPageView.swift
//  ProductName
//
//  Created by Aiden.lee on 6/8/25.
//

import SwiftUI

import ComposableArchitecture

struct MyPageView: View {
  @Bindable var store: StoreOf<MyPageReducer>

  var body: some View {
    ScrollView {
      VStack(spacing: 1) {
        // 내 사주 정보
        VStack(spacing: 16) {
          FortuneInfoCardView(
            imageURL: URL(string: "https://picsum.photos/id/6/200/200")!,
            fortune: "가을의 흰말"
          )

          BirthdayInfoView(date: "2000년 1월 1일", time: "오후 1시 30분")
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .radialGradientBackground(endRadiusMultiplier: 0.4, scaleEffectX: 2.0)

        // 소비 카테고리
        VStack(alignment: .leading, spacing: 12) {
          Text("선택한 소비 카테고리")
            .font(.body3)
            .foregroundColor(ColorResource.Neutral._50.color)

          ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
              // 상태 구성 후 ForEach 구문으로 변경
              CategoryCardView(
                imageURL: URL(string: "https://picsum.photos/id/7/200/200")!,
                title: "이동·교통"
              )
              CategoryCardView(
                imageURL: URL(string: "https://picsum.photos/id/8/200/200")!,
                title: "디지털·구독"
              )
              CategoryCardView(
                imageURL: URL(string: "https://picsum.photos/id/9/200/200")!,
                title: "사교·모임"
              )
            }
          }
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 20)

        Rectangle()
          .fill(ColorResource.Background.glassEffect.color)
          .frame(height: 7)

        // 설정
        VStack(alignment: .leading, spacing: 12) {
          Text("설정")
            .font(.body3)
            .foregroundColor(ColorResource.Neutral._50.color)

          VStack {
            SettingListRowView(
              title: "앱 초기화",
              icon: "icon/signOut",
              action: {
                print("앱 초기화 버튼 클릭")
              }
            )

            Divider()
              .background(ColorResource.Background.glassEffect.color)

            SettingListRowView(
              title: "알림 설정",
              icon: "icon/signOut",
              toggleValue: .constant(true)
            )
          }
          .padding(.vertical, 12)
          .padding(.horizontal, 16)
          .frame(maxWidth: .infinity)
          .background(ColorResource.Neutral._700.color)
          .cornerRadius(12)
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 20)
      }
    }
  }
}
