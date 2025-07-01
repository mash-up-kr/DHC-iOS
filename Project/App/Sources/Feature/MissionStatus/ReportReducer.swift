//
//  ReportReducer.swift
//  Flifin
//
//  Created by Aiden.lee on 6/8/25.
//

import DeveloperToolsSupport
import Foundation

import ComposableArchitecture

@Reducer
struct ReportReducer {
  @Dependency(\.reportClient) var reportClient

  @ObservableState
  struct State: Equatable {
    var reportInfo: ReportInfo
    var spendChart: SpendChart?
    var isLoading = false
    var isRedacted = false

    struct SpendChart: Equatable {
      let title: AttributedString
      let chartData: [SpendChartData]
    }
  }

  enum Action {
    case onAppear
    case fetchReportData
    case reportDataResponse(ReportInfo)
    case reportDataFailed(Error)
  }

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        state.spendChart = makeSpendChart(from: .sample)
        return .send(.fetchReportData)

      case .fetchReportData:
        state.isLoading = true
        state.isRedacted = true

        return .run { send in
          do {
            let report = try await reportClient.fetchReport()
            await send(.reportDataResponse(report))
          } catch {
            await send(.reportDataFailed(error))
          }
        }

      case .reportDataResponse(let report):
        state.isLoading = false
        state.isRedacted = false
        state.reportInfo = report
        state.spendChart = makeSpendChart(from: report)
        return .none

      case .reportDataFailed:
        state.isLoading = false
        return .none
      }
    }
  }

  private func makeSpendChart(from reportInfo: ReportInfo) -> State.SpendChart {
    let title = makeChartTitle(from: reportInfo)

    let chartData: [SpendChartData] = [
      SpendChartData(
        category: "내 소비",
        amount: reportInfo.weeklySavedMoney,
        isHighlighted: true
      ),
      SpendChartData(
        category: "\(reportInfo.generationComparison.generation) \(reportInfo.generationComparison.gender.title) 소비",
        amount: reportInfo.generationComparison.averageSpendMoney,
        isHighlighted: false
      ),
    ]

    return State.SpendChart(
      title: title,
      chartData: chartData
    )
  }

  private func makeChartTitle(from reportInfo: ReportInfo) -> AttributedString {
    var result = AttributedString()
    result.font = .head3
    result.foregroundColor = ColorResource.Text.main.color

    var thisWeekText = AttributedString("이번주에")
    thisWeekText.foregroundColor = ColorResource.Text.Highlights.secondary.color

    let comparisonText = AttributedString(
      " \(reportInfo.generationComparison.generation) \(reportInfo.generationComparison.gender.title) 대비\n"
    )

    let spendDifference = reportInfo.generationComparison.averageSpendMoney - reportInfo.monthlySpendMoney
    let amountText = AttributedString("\(abs(spendDifference).formatted(.number))원 ")

    var savedText = AttributedString(spendDifference >= 0 ? "더 절약했어요" : "더 낭비했어요")
    savedText.foregroundColor = ColorResource.Text.Highlights.secondary.color

    result.append(thisWeekText)
    result.append(comparisonText)
    result.append(amountText)
    result.append(savedText)

    return result
  }
}
