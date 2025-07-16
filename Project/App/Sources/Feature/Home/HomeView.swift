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
    } destination: { store in
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
        .rotationEffect(.init(degrees: 4))
        .padding(.top, 20)
        .padding(.bottom, 12)
        .onTapGesture {
          store.send(.moveToFortuneDetail)
        }
        
        ImageResource.fortuneCardShadow.image
          .padding(.bottom, 12)
        
        MissionListView(
          store: store.scope(
            state: \.missionList,
            action: \.missionList
          )
        )
      }
    }
    .scrollIndicators(.hidden)
    .contentMargins(.bottom, store.bottomContentMargin)
    .overlay(alignment: .bottomTrailing) {
      if !store.homeInfo.isTodayMissionDone {
        FloatingButton(title: "오늘 미션 끝내기") {
          store.send(.presentBottomSheet(true))
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 24)
      }
    }
    .clipShape(Rectangle())
    .radialGradientBackground(
      type: .backgroundGradient02,
      endRadiusMultiplier: 1.2,
      scaleEffectX: 1.8
    )
    .background(ColorResource.Background.main.color)
    .onAppear {
      store.send(.onAppear)
    }
    .adaptiveBottomSheet(
      isPresented: $store.presentBottomSheet.sending(\.presentBottomSheet)
    ) {
      DHCBottomSheetContent(
        configuration:
        .init(
          title: "오늘의 미션을\n정말 마무리할까요?",
          description: "아직 미션이 남아있어요!",
          showCloseButton: false,
          interactiveDisabled: false,
          firstButton:
          .init(
            title: "네! 완료했어요",
            action: {
              store.send(.confirmTodayMissionDoneButtonTapped)
            }
          ),
          secondButton:
          .init(
            title: "이전으로 돌아가기",
            action: {
              store.send(.cancelTodayMissionDoneButtonTapped)
            }
          )
        )
      )
    }
    .overlay {
      if store.presentMissionDonePopup {
        ColorResource._0_F_1114.color
          .ignoresSafeArea()

        HomePopup(todaySavedAmount: store.todaySavedMoney) { // TODO: 절약 금액 연결하기
          store.send(.popupConfirmButtonTapped)
        } onDismiss: {
          store.send(.popupDismissButtonTapped)
        }
        .padding(.horizontal, 28)
      }
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
          Text(store.homeInfo.dailyFortune.title)
            .textStyle(.h2)
            .foregroundStyle(ColorResource.Text.Body.primary.color)

          seeMoreButton
        }
        .frame(maxWidth: .infinity, alignment: .leading)

        FortuneCoreView(score: store.homeInfo.dailyFortune.score) {
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
