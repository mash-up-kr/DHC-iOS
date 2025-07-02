//
//  CalendarCardView.swift
//  Flifin
//
//  Created by Aiden.lee on 6/26/25.
//

import SwiftUI

extension Date {
  /// 동일 날짜 판별을 위한 캘린더 전용 id
  fileprivate var id: String {
    "\(year)-\(month)-\(day)"
  }
}

struct CalendarDateModelKey: Hashable {
  let id: String
  init(date: Date) {
    self.id = date.id
  }
}

struct CalendarDateModel: Identifiable, Equatable {
  let date: Date
  let backgroundColor: Color?
  var id: String {
    date.id
  }
}

struct CalendarCellData: Identifiable {
  let id = UUID()
  let date: Date
  let isCurrentMonth: Bool
  let backgroundColor: Color
  var isToday: Bool {
    date.isToday
  }
}

// MARK: - Calendar Card View

struct CalendarCardView: View {
  @Binding private var displayedMonth: Date
  @State private var calendarCells: [CalendarCellData] = []

  private static let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko_KR")
    dateFormatter.dateFormat = "yyyy년 M월"
    return dateFormatter
  }()

  private let weekdays = ["월", "화", "수", "목", "금", "토", "일"]
  private let dateModels: [CalendarDateModelKey: CalendarDateModel]

  init(displayedMonth: Binding<Date>, dateModels: [CalendarDateModelKey: CalendarDateModel]) {
    self._displayedMonth = displayedMonth
    self.dateModels = dateModels
  }

  var body: some View {
    VStack(spacing: 8) {
      // Header
      calendarHeader

      // Calendar Grid (Weekdays + Dates)
      calendarGrid
        .gesture(
          DragGesture()
            .onEnded { value in
              let threshold: CGFloat = 100
              if value.translation.width > threshold {
                moveToPreviousMonth()
              } else if value.translation.width < -threshold {
                moveToNextMonth()
              }
            }
        )
    }
    .padding(.vertical, 24)
    .padding(.horizontal, 16)
    .background(
      RoundedRectangle(cornerRadius: 16)
        .fill(ColorResource.Neutral._700.color)
    )
    .onAppear {
      calendarCells = calculateCalendarCells()
    }
    .onChange(of: displayedMonth) { _, _ in
      calendarCells = calculateCalendarCells()
    }
  }

  // MARK: - Calendar Header

  private var calendarHeader: some View {
    HStack {
      Button(action: moveToPreviousMonth) {
        Image(ImageResource.Chevron.left)
          .resizable()
          .foregroundColor(ColorResource.Text.main.color)
          .frame(width: 32, height: 32)
      }

      Spacer()

      Text(formattedDisplayedMonth)
        .textStyle(.body3)
        .foregroundColor(ColorResource.Text.main.color)

      Spacer()

      Button(action: moveToNextMonth) {
        Image(ImageResource.Chevron.right)
          .resizable()
          .foregroundColor(ColorResource.Text.main.color)
          .frame(width: 32, height: 32)
      }
    }
    .padding(4)
  }

  // MARK: - Calendar Grid

  private var calendarGrid: some View {
    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
      // Weekday Header
      ForEach(weekdays, id: \.self) { weekday in
        Text(weekday)
          .textStyle(.body3)
          .foregroundStyle(ColorResource.Neutral._200.color)
      }

      // Calendar Cells
      ForEach(calendarCells) { cellData in
        CalendarCellView(cellData: cellData)
      }
    }
  }

  // MARK: - Computed Properties

  private var formattedDisplayedMonth: String {
    CalendarCardView.dateFormatter.string(from: displayedMonth)
  }

  // MARK: - Methods

  private func calculateCalendarCells() -> [CalendarCellData] {
    let calendar = Calendar.current
    guard let startOfMonth = calendar.dateInterval(of: .month, for: displayedMonth)?.start else {
      return []
    }

    // 현재 달 첫 번째 날의 요일 구하기 (1: 일요일, 2: 월요일, ..., 7: 토요일)
    let firstWeekday = calendar.component(.weekday, from: startOfMonth)

    // 월요일부터 시작하도록 조정 (월요일 = 0, 화요일 = 1, ..., 일요일 = 6)
    let mondayBasedFirstWeekday = (firstWeekday == 1) ? 6 : firstWeekday - 2

    // 캘린더 시작일 계산 (해당 주의 월요일)
    let startOfCalendar = calendar
      .date(byAdding: .day, value: -mondayBasedFirstWeekday, to: startOfMonth) ?? startOfMonth

    // 7일 * 6주 = 42개의 셀 생성
    var allCells: [CalendarCellData] = []
    var currentDate = startOfCalendar

    for _ in 0..<42 {
      let isCurrentMonth = calendar.isDate(currentDate, equalTo: displayedMonth, toGranularity: .month)

      let dateModel = dateModels[.init(date: currentDate)]
      allCells.append(
        CalendarCellData(
          date: currentDate,
          isCurrentMonth: isCurrentMonth,
          backgroundColor: dateModel?.backgroundColor ?? ColorResource.Neutral._600.color
        )
      )
      currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
    }

    return allCells
  }

  private func moveToPreviousMonth() {
    displayedMonth = Calendar.current.date(
      byAdding: .month,
      value: -1,
      to: displayedMonth
    ) ?? displayedMonth
  }

  private func moveToNextMonth() {
    displayedMonth = Calendar.current.date(
      byAdding: .month,
      value: 1,
      to: displayedMonth
    ) ?? displayedMonth
  }
}

// MARK: - Calendar Cell View

struct CalendarCellView: View {
  let cellData: CalendarCellData

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 8)
        .fill(cellData.backgroundColor)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(borderColor, lineWidth: cellData.isToday ? 2 : 0)
        )

      Text("\(cellData.date.day)")
        .textStyle(textStyle)
        .foregroundColor(textColor)
    }
    .frame(minHeight: 36)
  }

  private var textStyle: Typography.TypographyStyle {
    cellData.isToday ? Typography.Head.h5 : Typography.Body.body3
  }

  private var textColor: Color {
    cellData.isCurrentMonth ? ColorResource.Text.main.color : ColorResource.Neutral._400.color
  }

  private var borderColor: Color {
    cellData.isToday ? ColorResource.Text.Highlights.secondary.color : Color.clear
  }
}

// MARK: - Preview

#Preview {
  CalendarCardView(
    displayedMonth: .constant(.now),
    dateModels: [
      .init(date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!)
        : .init(
          date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
          backgroundColor: ColorResource.Text.Highlights.primary.color
        ),
    ]
  )
}
