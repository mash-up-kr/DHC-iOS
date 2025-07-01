//
//  OnboardingReducer.swift
//  Flifin
//
//  Created by hyerin on 6/17/25.
//

import SwiftUI

import ComposableArchitecture

@Reducer
struct OnboardingReducer {
  init() {}
  
  @ObservableState
  struct State: Equatable {
    var path = StackState<Path.State>()
    
    init() {
    }
  }
  
  enum Action {
    // View Action
    case nextButtonTapped
    
    // Internal Action
    case searchUser(deviceID: UUID)
    
    // Route Action
    case path(StackActionOf<Path>)
    case moveToServiceExplanationView
    
    case delegate(Delegate)
    enum Delegate {
      case moveToSelectGenderView
      case moveToMainTabView
    }
  }
  
  @Reducer
  enum Path {
    case serviceExplanation(ServiceExplanationReducer)
    case fortunePickExample(FortunePickExampleReducer)
    case fortuneDetail(FortuneDetailReducer)
    case missionExample(MissionExampleReducer)
  }
  
  @Dependency(\.deviceIDManager) var deviceIDManager
  @Dependency(\.signUpClient) var signUpClient
  @Dependency(\.userManager) var userManager
  
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
        case .nextButtonTapped:
          var deviceID: UUID
          
          do {
            deviceID = try deviceIDManager.loadDeviceID()
          } catch {
            deviceID = deviceIDManager.generateDeviceID()
            try? deviceIDManager.saveDeviceID(uuid: deviceID)
          }
          
          return .send(.searchUser(deviceID: deviceID))
          
        case .searchUser(let deviceID):
          return .run { send in
            do {
              let userID = try await signUpClient.searchUser(deviceID)
              userManager.setUserID(userID)
              await send(.delegate(.moveToMainTabView))
            } catch {
              await send(.moveToServiceExplanationView)
            }
          }
          
        case let .path(action):
          switch action {
            case .element(id: _, action: .serviceExplanation(.nextButtonTapped)):
              state.path.append(.fortunePickExample(FortunePickExampleReducer.State()))
              return .none
              
            case .element(id: _, action: .fortunePickExample(.nextButtonTapped)):
              state.path.append(.fortuneDetail(FortuneDetailReducer.State(type: .intro)))
              return .none
              
            case .element(id: _, action: .fortuneDetail(.nextButtonTapped)):
              state.path.append(.missionExample(MissionExampleReducer.State()))
              return .none
              
            case .element(id: _, action: .missionExample(.nextButtonTapped)):
            return .send(.delegate(.moveToSelectGenderView))
              
            default:
              return .none
          }
          
        case .moveToServiceExplanationView:
          state.path.append(.serviceExplanation(ServiceExplanationReducer.State()))
          return .none

      case .delegate:
        return .none
      }
    }
    .forEach(\.path, action: \.path)
  }
}

extension OnboardingReducer.Path.State: Equatable {}
