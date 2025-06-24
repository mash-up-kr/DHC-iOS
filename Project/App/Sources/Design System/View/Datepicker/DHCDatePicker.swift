//
//  DHCDatePicker.swift
//  Flifin
//
//  Created by hyerin on 6/12/25.
//

import SwiftUI

struct DHCDatePicker: View {
  @Binding var date: Date
  private let type: DatePickerComponents
  
  init(
    type: DatePickerComponents,
    date: Binding<Date>
  ) {
    self.type = type
    self._date = date
  }
  
  var body: some View {
    DatePicker(
      "",
      selection: $date,
      displayedComponents: type
    )
    .datePickerStyle(.wheel)
    .environment(\.locale, Locale(identifier: "ko"))
    .environment(\.timeZone, TimeZone(identifier: "Asia/Seoul") ?? .current)
    .labelsHidden()
    .colorMultiply(ColorResource.Text.Highlights.secondary.color)
  }
}

#Preview {
  DHCDatePickerPreview()
}

struct DHCDatePickerPreview: View {
  @State private var date: Date = Date()
  @State private var time: Date = Date()
  private var selectedDate: String {
    date.description
  }
  private var selectedTime: String {
    time.description
  }
  
  var body: some View {
    VStack {
      DHCDatePicker(
        type: .date,
        date: $date
      )
      
      Text(selectedDate)
      
      DHCDatePicker(
        type: .hourAndMinute,
        date: $time
      )
      
      Text(selectedTime)
    }
    .background(ColorResource.Background.main.color)
  }
}
