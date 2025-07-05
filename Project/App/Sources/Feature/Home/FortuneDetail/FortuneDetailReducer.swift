//
//  FortuneDetailReducer.swift
//  Flifin
//
//  Created by 최혜린 on 6/22/25.
//

import ComposableArchitecture

import SwiftUI

enum FortuneDetailType {
  case intro
  case detail
}

@Reducer
struct FortuneDetailReducer {
  @Dependency(\.homeAPIClient) var homeAPIClient
  @Dependency(\.dateFormatterCache) var dateFormatterCache
  
  init() {}

  @ObservableState
  struct State: Equatable {
    let type: FortuneDetailType
    var rawTodayString: String // yyyy-MM-dd 형식
    var formattedTodayString: String // yyyy년 MM월 dd일 형식
    var detailInfo: FortuneDetail?

    init(
      type: FortuneDetailType,
      rawTodayString: String = "",
      formattedTodayString: String = "",
      detailInfo: FortuneDetail? = nil
    ) {
      self.type = type
      self.rawTodayString = rawTodayString
      self.formattedTodayString = formattedTodayString
      self.detailInfo = detailInfo
    }
  }

  enum Action {
    // View Action
    case onAppear
    case nextButtonTapped
    case backButtonTapped
    
    // Internal Action
    case fetchFortuneDetail
    case fortuneDetailResponse(FortuneDetail)
    case fortuneDetailError(Error)
    case updateTodayDate
    
    // Route Action
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        return .concatenate(
          .send(.updateTodayDate),
          .send(.fetchFortuneDetail)
        )
        
      case .nextButtonTapped:
        return .none
        
      case .backButtonTapped:
        return .none
        
      case .fetchFortuneDetail:
        switch state.type {
        case .detail:
          return .run { [state] send in
            do {
              let fortuneDetail = try await homeAPIClient.fetchFortuneDetail(state.rawTodayString)
              let formattedModel = formatModel(from: fortuneDetail)
              await send(.fortuneDetailResponse(formattedModel))
            } catch {
              await send(.fortuneDetailError(error))
            }
          }
        case .intro:
          state.detailInfo = .introInfo(date: state.formattedTodayString)
          return .none
        }
        
      case .fortuneDetailResponse(let viewModel):
        state.detailInfo = viewModel
        return .none
        
      case .fortuneDetailError:
        return .none
        
      case .updateTodayDate:
        let rawTodayString = dateFormatterCache.formatter(for: "yyyy-MM-dd").string(from: Date())
        let formattedTodayString = dateFormatterCache.formatter(for: "yyyy년 MM월 dd일").string(from: Date())
        state.rawTodayString = rawTodayString
        state.formattedTodayString = formattedTodayString
        return .none
      }
    }
  }
}

extension FortuneDetailReducer {
  private func formatModel(from model: FortuneDetail) -> FortuneDetail {
    var newModel = model
    
    let date = dateFormatterCache.formatter(for: "yyyy-MM-dd").date(from: model.scoreInfo.date) ?? Date()
    let formattedDate = dateFormatterCache.formatter(for: "yyyy년 M월 d일").string(from: date)
    
    newModel.scoreInfo.date = formattedDate
    
    return newModel
  }
}
