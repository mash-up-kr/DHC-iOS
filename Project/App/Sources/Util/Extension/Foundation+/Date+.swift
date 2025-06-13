//
//  Date+.swift
//  ProductName
//
//  Created by hyerin on 6/13/25.
//

import Foundation

extension Date {
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
