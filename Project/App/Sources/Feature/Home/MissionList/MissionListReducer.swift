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
    var isTodayMissionDone: Bool

    init(
      longTermMission: HomeInfo.Mission,
      todayDailyMissionList: [HomeInfo.Mission],
      isTodayMissionDone: Bool
    ) {
      self.longTermMission = longTermMission
      self.todayDailyMissionList = todayDailyMissionList
      self.isTodayMissionDone = isTodayMissionDone
    }
  }

  enum Action {
    case delegate(Delegate)

    // View Action
    case tooltipTapped
    case longTermMissionTapped
    case dailyMissionTapped(missionID: String)
    case switchMissionButtonTapped(missionID: String)

    enum Delegate {
      case presentToast(String)
    }

    // Internal Action
    case updateLongTermMission(HomeInfo.Mission)
    case updateDailyMissions([HomeInfo.Mission])
    case updateTodayMissionDone(Bool)
    case missionStatusUpdateResult(Result<String, Error>)
    case switchMissionResponse(Result<SwitchMissionInfo, Error>)
    
    // Route Action
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .delegate:
        return .none

      case .tooltipTapped:
        state.isTooltipVisible.toggle()
        return .none

      case .updateLongTermMission(let mission):
        state.longTermMission = mission
        return .none

      case .updateDailyMissions(let missions):
        state.todayDailyMissionList = missions
        return .none
        
      case .updateTodayMissionDone(let isDone):
        state.isTodayMissionDone = isDone
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

            if mission.isFinished {
              await send(
                .delegate(
                  .presentToast(
                    ToastMessages.mission.randomElement()!
                  )
                )
              )
            }
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

            if updatedMission.isFinished {
              await send(
                .delegate(
                  .presentToast(
                    ToastMessages.mission.randomElement()!
                  )
                )
              )
            }
          } catch {
            await send(.missionStatusUpdateResult(.failure(error)))
          }
        }

      case .switchMissionButtonTapped(let missionID):
        return .run { send in
          do {
            let switchMissionInfo = try await missionClient.switchMission(missionID: missionID)
            await send(.switchMissionResponse(.success(switchMissionInfo)))
          } catch {
            await send(.switchMissionResponse(.failure(error)))
          }
        }

      case .switchMissionResponse(let result):
        switch result {
        case .success(let switchMissionInfo):
          state.longTermMission = switchMissionInfo.longTermMission
          state.todayDailyMissionList = switchMissionInfo.dailyMissionList
          return .none
        case .failure(let error):
          print(error)
          return .none
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
