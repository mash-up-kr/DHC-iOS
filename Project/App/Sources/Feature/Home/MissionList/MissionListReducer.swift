//
//  MissionListReducer.swift
//  Flifin
//
//  Created by 김유빈 on 7/1/25.
//

import ComposableArchitecture

@Reducer
struct MissionListReducer {
  @Dependency(\.missionClient) var missionClient

  init() {}

  @ObservableState
  struct State: Equatable {
    var isTooltipVisible = false
    var longTermMission: HomeInfo.Mission
    var todayDailyMissionList: [HomeInfo.Mission] = []

    init(
      longTermMission: HomeInfo.Mission,
      todayDailyMissionList: [HomeInfo.Mission]
    ) {
      self.longTermMission = longTermMission
      self.todayDailyMissionList = todayDailyMissionList
    }
  }

  enum Action {
    // View Action
    case tooltipTapped
    case longTermMissionTapped
    case dailyMissionTapped(missionID: String)

    // Internal Action
    case updateLongTermMission(HomeInfo.Mission)
    case updateDailyMissions([HomeInfo.Mission])
    case missionStatusUpdateResult(Result<String, Error>)

    // Route Action
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .tooltipTapped:
        state.isTooltipVisible.toggle()
        return .none

      case .updateLongTermMission(let mission):
        state.longTermMission = mission
        return .none

      case .updateDailyMissions(let missions):
        state.todayDailyMissionList = missions
        return .none

      case .longTermMissionTapped:
        state.longTermMission.isFinished.toggle()

        let mission = state.longTermMission

        return .run { send in
          do {
            try await missionClient.updateMissionStatus(
              mission.id,
              mission.isFinished
            )
            await send(
              .missionStatusUpdateResult(
                .success(mission.id)
              )
            )
          } catch {
            await send(
              .missionStatusUpdateResult(
                .failure(error)
              )
            )
          }
        }

      case .dailyMissionTapped(let missionID):
        guard let index = state.todayDailyMissionList
          .firstIndex(
            where: {
              $0.id == missionID
            }
          )
        else {
          return .none
        }

        state.todayDailyMissionList[index].isFinished.toggle()
        let updatedMission = state.todayDailyMissionList[index]

        return .run { send in
          do {
            try await missionClient.updateMissionStatus(updatedMission.id, updatedMission.isFinished)
            await send(.missionStatusUpdateResult(.success(updatedMission.id)))
          } catch {
            await send(.missionStatusUpdateResult(.failure(error)))
          }
        }

      case .missionStatusUpdateResult(let result):
        if case .failure(let error) = result {
          print(error)
        }
        return .none
      }
    }
  }
}
