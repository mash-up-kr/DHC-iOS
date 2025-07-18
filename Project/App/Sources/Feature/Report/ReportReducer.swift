//
//  ReportReducer.swift
//  Flifin
//
//  Created by Aiden.lee on 6/8/25.
//

import DeveloperToolsSupport
import SwiftUI

import ComposableArchitecture

@Reducer
struct ReportReducer {
  @Dependency(\.reportClient) var reportClient
  @Dependency(\.dateFormatterCache) var dateFormatterCache

  @ObservableState
  struct State: Equatable {
    var reportInfo: ReportInfo
    var spendChart: SpendChart?
    var missionHistoryCalendar: MissionHistoryCalendar?
    var currentMonthHistory: MonthlyMissionHistory?
    var currentCalendarMonth = Date.now
    var calendarDateModels: [CalendarDateModelKey: CalendarDateModel] = [:]
    var isLoading = false
    var hapticTrigger = false

    struct SpendChart: Equatable {
      let title: AttributedString
      let chartData: [SpendChartData]
    }
  }

  enum Action: BindableAction {
    case binding(BindingAction<State>)
    case onAppear
    case reportDataResponse(ReportInfo)
    case missionHistoryCalendarResponse(MissionHistoryCalendar)
    case reportDataFailed(Error)
    case missionHistoryCalendarFailed(Error)
    case onShake
    case reload
    case isLoading(Bool)
  }

  var body: some ReducerOf<Self> {
    BindingReducer()
      .onChange(of: \.currentCalendarMonth) { _, _ in
        Reduce { state, _ in
          fetchMissionHistoryCalendar(state.currentCalendarMonth)
        }
      }

    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case .onAppear:
        state.spendChart = makeSpendChart(from: .sample)
        return .send(.reload)

      case .reportDataResponse(let report):
        state.reportInfo = report
        state.spendChart = makeSpendChart(from: report)
        return .none

      case .missionHistoryCalendarResponse(let missionHistory):
        state.missionHistoryCalendar = missionHistory
        state.currentMonthHistory = missionHistory.monthlyHistory.first(where: {
          $0.month == state.currentCalendarMonth.month
        })

        let newDateModels = missionHistory.monthlyHistory
          .flatMap(\.missionHistoryDateList)
          .compactMap {
            makeCalendarDateModel(from: $0)
          }
        let newDateModelDictionary = Dictionary(
          uniqueKeysWithValues: newDateModels.map { (CalendarDateModelKey(date: $0.date), $0) }
        )
        state.calendarDateModels.merge(newDateModelDictionary, uniquingKeysWith: { $1 })
        return .none

      case .reportDataFailed:
        state.isLoading = false
        return .none

      case .missionHistoryCalendarFailed:
        state.isLoading = false
        return .none

      case .onShake:
        state.hapticTrigger.toggle()
        return .run { send in
          try? await reportClient.addJulyHistory()
          await send(.reload)
        }

      case .reload:
        state.currentCalendarMonth = .now
        return .concatenate([
          .send(.isLoading(true)),
          .merge([
            fetchReportData(),
            fetchMissionHistoryCalendar(state.currentCalendarMonth),
          ]),
          .send(.isLoading(false)),
        ])

      case .isLoading(let isLoading):
        state.isLoading = isLoading
        return .none
      }
    }
  }

  private func fetchReportData() -> Effect<Action> {
    .run { send in
      do {
        let report = try await reportClient.fetchReport()
        await send(.reportDataResponse(report))
      } catch {
        await send(.reportDataFailed(error))
      }
    }
  }

  private func fetchMissionHistoryCalendar(_ date: Date) -> Effect<Action> {
    .run { send in
      do {
        let currentYearMonth = formatDateToYYYYmm(from: date)
        let usesCache = !Calendar.current.isDate(date, inSameDayAs: .now)
        let missionHistory = try await reportClient.fetchMissionHistoryCalendar(
          currentYearMonth,
          usesCache
        )
        await send(.missionHistoryCalendarResponse(missionHistory))
      } catch {
        await send(.missionHistoryCalendarFailed(error))
      }
    }
  }

  private func makeSpendChart(from reportInfo: ReportInfo) -> State.SpendChart {
    let title = makeChartTitle(from: reportInfo)

    let chartData: [SpendChartData] = [
      SpendChartData(
        category: "내 소비",
        amount: reportInfo.weeklySpendMoney,
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
    result.font = .head4
    result.foregroundColor = ColorResource.Text.main.color

    var thisWeekText = AttributedString("이번주에")
    thisWeekText.foregroundColor = ColorResource.Text.Highlights.secondary.color

    let comparisonText = AttributedString(
      " \(reportInfo.generationComparison.generation) \(reportInfo.generationComparison.gender.title) 대비\n"
    )

    let spendDifference = reportInfo.generationComparison.averageSpendMoney - reportInfo.weeklySpendMoney
    let amountText = AttributedString("\(abs(spendDifference).formatted(.number))원 ")

    var savedText = AttributedString(spendDifference >= 0 ? "더 절약했어요" : "더 낭비했어요")
    savedText.foregroundColor = ColorResource.Text.Highlights.secondary.color

    result.append(thisWeekText)
    result.append(comparisonText)
    result.append(amountText)
    result.append(savedText)

    return result
  }

  /// 현재 년월을 "yyyy-MM" 포맷으로 반환
  private func formatDateToYYYYmm(from date: Date) -> String {
    let formatter = dateFormatterCache.formatter(for: "yyyy-MM")
    return formatter.string(from: date)
  }

  private func makeCalendarDateModel(from missionHistoryDate: MissionHistoryDate) -> CalendarDateModel? {
    let formatter = dateFormatterCache.formatter(for: "yyyy-MM-dd")
    guard let date = formatter.date(from: missionHistoryDate.date) else {
      return nil
    }

    let missionCompletionStage = CalendarMissionCompletionStage(
      completionCount: missionHistoryDate.finishedMissionCount
    )

    return CalendarDateModel(
      date: date,
      backgroundColor: missionCompletionStage.displayColor
    )
  }
}
