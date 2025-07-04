//
//  Date+.swift
//  Flifin
//
//  Created by hyerin on 6/13/25.
//

import Foundation

extension Date {
  var year: Int {
    Calendar.current.component(.year, from: self)
  }

  var month: Int {
    Calendar.current.component(.month, from: self)
  }

  var day: Int {
    Calendar.current.component(.day, from: self)
  }

  var isToday: Bool {
    Calendar.current.isDateInToday(self)
  }
  
  func addDate(day: Int) -> Date {
    Calendar.current.date(byAdding: .day, value: day, to: self) ?? Date()
  }

  init(year: Int, month: Int, day: Int) {
    let calendar = Calendar(identifier: .gregorian)
    let requestedDateComponent = DateComponents(
      calendar: calendar,
      timeZone: .init(identifier: "KST"),
      year: year,
      month: month,
      day: day
    )

    self = calendar.date(from: requestedDateComponent) ?? Date()
  }

  init(hour: Int, minute: Int) {
    let calendar = Calendar(identifier: .gregorian)
    let requestedDateComponent = DateComponents(
      calendar: calendar,
      timeZone: .init(identifier: "KST"),
      hour: hour,
      minute: minute
    )

    self = calendar.date(from: requestedDateComponent) ?? Date()
  }
}
