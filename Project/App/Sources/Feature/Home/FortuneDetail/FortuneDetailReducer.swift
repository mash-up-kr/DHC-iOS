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
    var detailInfo: FortuneDetailViewModel

    init(
      type: FortuneDetailType,
      rawTodayString: String = "",
      formattedTodayString: String = "",
      detailInfo: FortuneDetailViewModel = .introInfo(date: "")
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
    case fortuneDetailResponse(FortuneDetailViewModel)
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
              let viewModel = convertToViewModel(from: fortuneDetail)
              await send(.fortuneDetailResponse(viewModel))
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
  private func convertToViewModel(from domainModel: FortuneDetail) -> FortuneDetailViewModel {
    let tipViewModels: [TipInfo] = domainModel.tipInfos.map { domainModel in
        .init(
          imageURL: domainModel.imageURL,
          title: domainModel.title,
          content: domainModel.content,
          contentColor: domainModel.contentColorHex
        )
    }
    let date = dateFormatterCache.formatter(for: "yyyy-MM-dd").date(from: domainModel.scoreInfo.date) ?? Date()
    let formattedDate = dateFormatterCache.formatter(for: "yyyy년 MM월 dd일").string(from: date)
    
    return .init(
      scoreInfo: .init(
        date: formattedDate,
        score: "\(domainModel.scoreInfo.score)점",
        summary: domainModel.scoreInfo.summary,
        gradientType: FortuneScore(score: domainModel.scoreInfo.score).textGradient
      ),
      cardInfo: .init(
        backgroundImageURL: domainModel.cardInfo.backgroundImageURL,
        title: domainModel.cardInfo.title,
        fortune: domainModel.cardInfo.fortune
      ),
      detailMessage: domainModel.detailMessage,
      tipInfos: tipViewModels
    )
  }
}
