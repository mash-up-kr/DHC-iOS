//
//  ColorResource+.swift
//  ProductName
//
//  Created by hyerin on 6/4/25.
//

import SwiftUI

extension ColorResource {
	var color: Color {
		Color(self)
	}

  var uiColor: UIColor {
    UIColor(resource: self)
  }
}
