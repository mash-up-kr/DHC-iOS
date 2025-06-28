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
    
    // Route Action
    case path(StackActionOf<Path>)
    case moveToServiceExplanationView
    
    case delegate(Delegate)
    enum Delegate {
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
  
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .nextButtonTapped:
        // TODO: 온보딩으로 갈지 메인탭으로 갈지 확인 후 이동해야함
        return .send(.moveToServiceExplanationView)
        
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
          // TODO: 개인정보 입력으로 이동
          return .none
          
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
