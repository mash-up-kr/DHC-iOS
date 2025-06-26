//
//  Font.swift
//  Flifin
//
//  Created by hyerin on 6/4/25.
//

import UIKit.UIFont
import SwiftUI

enum Typography {
	protocol TypographyStyle {
    var uiFont: UIFont { get }
		var lineHeight: CGFloat { get }
		var letterSpacing: CGFloat { get }
    var font: Font { get }
	}
}

// MARK: - Head Styles
extension Typography {
	enum Head: CaseIterable, TypographyStyle {
		case h0, h1, h2, h2_1, h3, h4, h4_1, h5, h5_1, h6, h7, h8
		
    var uiFont: UIFont {
			switch self {
      case .h0: return UIFont.head0
      case .h1: return UIFont.head1
      case .h2: return UIFont.head2
      case .h2_1: return UIFont.head2_1
      case .h3: return UIFont.head3
      case .h4: return UIFont.head4
      case .h4_1: return UIFont.head4_1
      case .h5: return UIFont.head5
      case .h5_1: return UIFont.head5_1
      case .h6: return UIFont.head6
      case .h7: return UIFont.head7
      case .h8: return UIFont.head8
			}
		}
    
    var font: Font {
      Font(uiFont)
    }
		
		var lineHeight: CGFloat {
			switch self {
				case .h0: return 44
				case .h1: return 38
        case .h2, .h2_1: return 32
				case .h3: return 28
        case .h4, .h4_1: return 24
        case .h5, .h5_1: return 22
        case .h6, .h7: return 20
				case .h8: return 18
			}
		}
		
		var letterSpacing: CGFloat {
      switch self {
        case .h0, .h1: return -0.4
        case .h2, .h2_1, .h3: return -0.2
        case .h4, .h4_1, .h5, .h5_1: return -0.1
        case .h6, .h7, .h8: return 0
      }
		}
	}
}

// MARK: - Body Styles
extension Typography {
	enum Body: CaseIterable, TypographyStyle {
		case body0, body1, body2, body3, body4, body5, body6, body7
		
    var uiFont: UIFont {
			switch self {
      case .body0: return UIFont.body0
      case .body1: return UIFont.body1
      case .body2: return UIFont.body2
      case .body3: return UIFont.body3
      case .body4: return UIFont.body4
      case .body5: return UIFont.body5
      case .body6: return UIFont.body6
      case .body7: return UIFont.body7
			}
		}
    
    var font: Font {
      Font(uiFont)
    }

		var lineHeight: CGFloat {
      switch self {
        case .body0: return 40
        case .body1: return 28
        case .body2: return 26
        case .body3: return 24
        case .body4: return 22
        case .body5, .body6: return 20
        case .body7: return 18
      }
		}

		var letterSpacing: CGFloat {
      switch self {
        case .body0, .body1, .body2: return -0.2
        case .body3: return -0.1
        case .body4, .body5, .body6, .body7: return 0
      }
		}
	}
}

// MARK: - Extensions
extension View {
	func textStyle(_ style: Typography.Head) -> some View {
		self
      .font(style.font)
      .lineSpacing(style.lineHeight - style.uiFont.lineHeight)
      .padding(.vertical, (style.lineHeight  - style.uiFont.lineHeight) / 2)
			.kerning(style.letterSpacing)
	}
	
	func textStyle(_ style: Typography.Body) -> some View {
    self
      .font(style.font)
      .lineSpacing(style.lineHeight - style.uiFont.lineHeight)
      .padding(.vertical, (style.lineHeight  - style.uiFont.lineHeight) / 2)
      .kerning(style.letterSpacing)
	}
  
  func textStyle(_ style: Typography.TypographyStyle) -> some View {
    self
      .font(style.font)
      .lineSpacing(style.lineHeight - style.uiFont.lineHeight)
      .padding(.vertical, (style.lineHeight  - style.uiFont.lineHeight) / 2)
      .kerning(style.letterSpacing)
  }
}

// MARK: - Preview
struct TypographyExampleView: View {
	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 20) {
				
				// Head Examples
				Group {
					Text("Head Styles").font(.headline).padding(.bottom, 10)
					
					Text("H0 - Domhwang").textStyle(.h0)
					Text("H1 - Domhwang").textStyle(.h1)
					Text("H2 - Domhwang").textStyle(.h2)
					Text("H3 - Domhwang").textStyle(.h3)
					Text("H4 - Domhwang").textStyle(.h4)
					Text("H5 - Domhwang").textStyle(.h5)
					Text("H6 - Domhwang").textStyle(.h6)
					Text("H7 - Domhwang").textStyle(.h7)
					Text("H8 - Domhwang").textStyle(.h8)
				}
				
				Divider().background(Color.white).padding(.vertical)
				
				// Body Examples
				Group {
					Text("Body Styles").font(.headline).padding(.bottom, 10)
					
					Text("Body0 - Domhwang").textStyle(.body0)
					Text("Body1 - Domhwang").textStyle(.body1)
					Text("Body2 - Domhwang").textStyle(.body2)
					Text("Body3 - Domhwang").textStyle(.body3)
					Text("Body4 - Domhwang").textStyle(.body4)
					Text("Body5 - Domhwang").textStyle(.body5)
					Text("Body6 - Domhwang").textStyle(.body6)
				}
			}
			.padding()
		}
	}
}

#Preview {
	TypographyExampleView()
		.background(Color.black)
		.foregroundStyle(Color.white)
}
