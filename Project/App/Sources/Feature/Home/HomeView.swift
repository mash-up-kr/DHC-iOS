//
//  HomeView.swift
//  Flifin
//
//  Created by Aiden.lee on 6/8/25.
//

import SwiftUI

import ComposableArchitecture

struct HomeView: View {
  @Bindable var store: StoreOf<HomeReducer>

  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
        headerSection

        Rectangle().frame(width: 144, height: 200)
          // TODO: card 넣기
          .frame(maxWidth: .infinity)
          .padding([.horizontal, .top], 20)
          .padding(.bottom, 60)

        MissionListView(
          store: store.scope(
            state: \.missionList,
            action: \.missionList
          )
        )
      }
    }
    .radialGradientBackground(type: .backgroundGradient02)
    .onAppear { 
      store.send(.onAppear)
    }
  }

  // MARK: 상단 타이틀 섹션
  private var headerSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text(todayDateString)
        .textStyle(.body3)
        .foregroundStyle(ColorResource.Neutral._300.color)

      HStack(alignment: .top, spacing: 0) {
        VStack(alignment: .leading, spacing: 12) {
          Text(store.homeInfo.todayDailyFortune.fortuneTitle) // TODO: 타이틀 연결
            .textStyle(.h2)
            .foregroundStyle(ColorResource.Text.Body.primary.color)

          seeMoreButton
        }
        .frame(maxWidth: .infinity, alignment: .leading)

        FortuneCoreView(score: store.homeInfo.todayDailyFortune.score) {
          // TODO: '오늘의 금전운' 화면으로 이동하기
        }
      }
    }
    .padding(.horizontal, 20)
  }

  private var seeMoreButton: some View {
    Button {
      // TODO: '오늘의 금전운' 화면으로 이동
    } label: {
      HStack(spacing: 4) {
        Text("더보기")
          .textStyle(.body6)

        Image(ImageResource.Chevron.right)
          .resizable()
          .renderingMode(.template)
          .frame(width: 20, height: 20)
      }
      .padding(.leading, 12)
      .padding(.trailing, 8)
      .padding(.vertical, 4)
      .foregroundStyle(ColorResource.Neutral._300.color)
      .background {
        RoundedRectangle(cornerRadius: .infinity)
          .foregroundStyle(ColorResource.Neutral._700.color)
      }
    }
  }

  private var todayDateString: String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = "M월 d일"
    return formatter.string(from: Date())
  }
}

#Preview {
  HomeView(
    store: Store(
      initialState: .init(homeInfo: HomeInfo.sample),
      reducer: HomeReducer.init
    )
  )
}
