//
//  MissionListView.swift
//  Flifin
//
//  Created by 김유빈 on 6/29/25.
//

import SwiftUI

import ComposableArchitecture

struct MissionListView: View {
  @Bindable var store: StoreOf<MissionListReducer>
  @Dependency(\.dateFormatterCache) var dateFormatterCache

  var body: some View {
    VStack(alignment: .leading, spacing: 24) {
      pinnedMissionSection
      dailyMissionSection
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  private var pinnedMissionSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      HStack(spacing: 12) {
        HStack(spacing: 8) {
          Text("소비습관 미션")
            .textStyle(.h4_1)
            .foregroundStyle(ColorResource.Text.Body.primary.color)

          Button {
            store.send(.tooltipTapped)
          } label: {
            Image(ImageResource.Icon.info)
              .renderingMode(.template)
              .foregroundStyle(ColorResource.Neutral._400.color)
              .frame(width: 24, height: 24)
          }
          .overlay {
            if store.isTooltipVisible {
              HomeToolTipView(
                message: "좋은 금융 습관 형성을 위해\n2주간 매일 진행하는 미션이에요!"
              )
              .offset(y: -50)
            }
          }
        }

        DHCBadge(
          badgeTitle: store.longTermMission.category,
          badgeStyle: .spendCategory
        )
      }

      PinnedMissionItemView(
        missionTitle: store.longTermMission.title,
        remainingDays: remainingDays(
          until: store.longTermMission.endDate
        ),
        isMissionCompleted: Binding(
          get: { store.longTermMission.isFinished },
          set: { _ in store.send(.longTermMissionTapped) }
        )
      )
    }
    .padding(.horizontal, 20)
  }

  private var dailyMissionSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("금전운 기반 일일 미션")
        .textStyle(.h4_1)
        .foregroundStyle(ColorResource.Text.Body.primary.color)
        .frame(maxWidth: .infinity, alignment: .leading)

      ForEach(store.todayDailyMissionList, id: \.id) { mission in
        DailyMissionItemView(
          missionTitle: mission.title,
          missionLevel: missionLevel(for: mission.difficulty),
          isMissionCompleted: Binding(
            get: { mission.isFinished },
            set: { _ in store.send(.dailyMissionTapped(missionID: mission.id)) }
          )
        )
      }
    }
    .padding(.horizontal, 20)
  }

  private func remainingDays(until dateString: String) -> Int {
    let formatter = dateFormatterCache.formatter(for: "yyyy-MM-dd")

    guard let endDate = formatter.date(from: dateString) else {
      return 0
    }

    let calendar = Calendar.current
    let today = calendar.startOfDay(for: Date())
    let end = calendar.startOfDay(for: endDate)

    return max(calendar.dateComponents([.day], from: today, to: end).day ?? 0, 0)
  }

  private func missionLevel(for difficulty: Int) -> DHCBadge.MissionLevel {
    switch difficulty {
    case 1: return .easy
    case 2: return .medium
    case 3: return .hard
    default: return .easy
    }
  }
}

#Preview {
  MissionListView(
    store: Store(
      initialState: MissionListReducer
        .State(
          longTermMission: HomeInfo.sample.longTermMission,
          todayDailyMissionList: HomeInfo.sample.dailyMissionList
        ),
      reducer: MissionListReducer.init
    )
  )
}
