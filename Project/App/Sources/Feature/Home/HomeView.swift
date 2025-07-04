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
  @Dependency(\.dateFormatterCache) private var dateFormatterCache

  var body: some View {
    NavigationStack(
      path: $store.scope(state: \.path, action: \.path)
    ) {
      Group {
        switch store.viewState {
        case .firstLaunch:
          IfLetStore(
            store.scope(state: \.fortuneLoadingComplete, action: \.fortuneLoadingComplete)
          ) { fortuneLoadingCompleteStore in
            FortuneLoadingCompleteView(store: fortuneLoadingCompleteStore)
          } else: {
            homeView
          }
        case .home:
          homeView
        }
      }
      .onAppear {
        store.send(.onAppear)
      }
    }  destination: { store in
      switch store.case {
      case .fortuneDetail(let store):
        FortuneDetailView(store: store)
      }
    }
  }
  
  private var homeView: some View {
    ScrollView {
      VStack(spacing: 0) {
        headerSection

        FortuneCardFrontView(
          backgroundImageURL: .urlForResource(.fortuneCardFrontDefaultView),
          title: "최고의 날",
          fortune: "네잎클로버"
        )
        .radialGradientBackground(
          type: .backgroundGradient01,
          endRadiusMultiplier: 0.4,
          scaleEffectX: 2.5,
          scaleEffectY: 1.6
        )
        .rotationEffect(.init(degrees: 4))
        .padding([.horizontal, .top], 20)
        .padding(.bottom, 60)
        .onTapGesture {
          store.send(.moveToFortuneDetail)
        }

        MissionListView(
          store: store.scope(
            state: \.missionList,
            action: \.missionList
          )
        )
      }
    }
    .radialGradientBackground(
      type: .backgroundGradient02,
      endRadiusMultiplier: 1.2,
      scaleEffectX: 1.8
    )
    .background(ColorResource.Background.main.color)
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
          store.send(.moveToFortuneDetail)
        }
      }
    }
    .padding(.horizontal, 20)
  }

  private var seeMoreButton: some View {
    Button {
      store.send(.moveToFortuneDetail)
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
    let formatter = dateFormatterCache.formatter(for: "M월 d일")
    return formatter.string(from: Date())
  }
}

#Preview {
  HomeView(
    store: Store(
      initialState: .init(homeInfo: HomeInfo.sample, isFirstLaunchOfToday: true),
      reducer: HomeReducer.init
    )
  )
}
