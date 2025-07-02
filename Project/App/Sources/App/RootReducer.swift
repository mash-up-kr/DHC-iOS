//
//  RootReducer.swift
//  Flifin
//
//  Created by Aiden.lee on 6/8/25.
//

import Foundation

import ComposableArchitecture

@Reducer
struct RootReducer {
  @Reducer
  enum Destination {
    case splash(SplashReducer)
    case onboarding(OnboardingReducer)
    case mainTab(MainTabReducer)
    case selectGender(SelectGenderReducer)
  }
  
  @ObservableState
  struct State {
    @Presents var destination: Destination.State?
  }
  
  @Dependency(\.userManager) var userManager
  @Dependency(\.deviceIDManager) var deviceIDManager
  
  enum Action {
    // View Action
    case onAppear
    
    // Internal Action
    case checkDeviceID
    case checkUserID
    
    // Route Action
    case destination(PresentationAction<Destination.Action>)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .destination(.presented(.splash(.delegate(.splashFinished)))):
        state.destination = .onboarding(OnboardingReducer.State())
        return .none
        
      case .destination(.presented(.onboarding(.delegate(.moveToMainTabView)))):
        state.destination = .mainTab(MainTabReducer.State())
        return .none
        
      case .destination(.presented(.onboarding(.delegate(.moveToSelectGenderView)))):
        state.destination = .selectGender(SelectGenderReducer.State())
        return .none
        
      case .destination(.presented(.selectGender(.delegate(.registerCompleted)))):
        // TODO: 홈에서 로직 처리 필요
        state.destination = .mainTab(MainTabReducer.State())
        return .none
        
      case .destination(.presented(.mainTab(.myPageTab(.delegate(.moveToRootView))))):
        return .send(.checkDeviceID)
        
      case .destination:
        return .none
        
      case .onAppear:
        state.destination = .splash(SplashReducer.State())
        return .none
        
      case .checkDeviceID:
        do {
          _ = try deviceIDManager.loadDeviceID()
        } catch {
          let deviceID = deviceIDManager.generateDeviceID()
          try? deviceIDManager.saveDeviceID(uuid: deviceID)
        }
        
        return .send(.checkUserID)
        
      case .checkUserID:
        let userID = userManager.getUserID()
        if userID == nil {
          state.destination = .onboarding(OnboardingReducer.State())
        } else {
          state.destination = .mainTab(MainTabReducer.State())
        }
        
        return .none
      }
    }
    .ifLet(\.$destination, action: \.destination)
  }
}
