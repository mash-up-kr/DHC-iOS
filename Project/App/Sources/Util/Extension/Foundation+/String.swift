//
//  String.swift
//  Flifin
//
//  Created by hyerin on 7/15/25.
//

import Foundation

extension String {
  var formatToNumber: String {
    let requestIntValue = Int(self) ?? 0

    let numberFormatter: NumberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal

    let result: String = numberFormatter.string(for: requestIntValue) ?? "0"

    return result
  }
}
