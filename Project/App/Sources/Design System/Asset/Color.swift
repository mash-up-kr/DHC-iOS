//
//  Color.swift
//  ProductName
//
//  Created by hyerin on 6/4/25.
//

import SwiftUI

extension ColorResource {
	enum Background {
		case main
		
		var color: Color {
			switch self {
				case .main:
					return ColorResource.Neutral._900.color
			}
		}
	}
	
	enum Text {
		case main
		
		var color: Color {
			switch self {
				case .main:
					return ColorResource.Neutral._30.color
			}
		}
		
		enum Highlights {
			case secondary
			case primary
			
			var color: Color {
				switch self {
					case .secondary:
						return ColorResource.Violet._200.color
					case .primary:
						return ColorResource.Violet._400.color
				}
			}
		}
		
		enum Body {
			case primary
			
			var color: Color {
				switch self {
					case .primary:
						return ColorResource.Neutral._100.color
				}
			}
		}
	}
}
