//
//  Font.swift
//  ProductName
//
//  Created by hyerin on 6/4/25.
//

import SwiftUI

enum Typography {
	protocol TypographyStyle {
		var font: Font { get }
		var fontSize: CGFloat { get }
		var lineHeight: CGFloat { get }
		var letterSpacing: CGFloat { get }
	}
}

// MARK: - Head Styles
extension Typography {
	enum Head: CaseIterable, TypographyStyle {
		case h0, h1, h2, h3, h4, h5, h6, h7, h8
		
		var font: Font {
			switch self {
				case .h0: return Font.head0
				case .h1: return Font.head1
				case .h2: return Font.head2
				case .h3: return Font.head3
				case .h4: return Font.head4
				case .h5: return Font.head5
				case .h6: return Font.head6
				case .h7: return Font.head7
				case .h8: return Font.head8
			}
		}
		
		var fontSize: CGFloat {
			switch self {
				case .h0: return 32
				case .h1: return 28
				case .h2: return 24
				case .h3: return 20
				case .h4: return 18
				case .h5: return 16
				case .h6: return 15
				case .h7: return 14
				case .h8: return 13
			}
		}
		
		var lineHeight: CGFloat {
			return fontSize * 1.35
		}
		
		var letterSpacing: CGFloat {
			return fontSize * -0.01
		}
	}
}

// MARK: - Body Styles
extension Typography {
	enum Body: CaseIterable, TypographyStyle {
		case body0, body1, body2, body3, body4, body5, body6
		
		var font: Font {
			switch self {
				case .body0: return Font.body0
				case .body1: return Font.body1
				case .body2: return Font.body2
				case .body3: return Font.body3
				case .body4: return Font.body4
				case .body5: return Font.body5
				case .body6: return Font.body6
			}
		}
		
		var fontSize: CGFloat {
			switch self {
				case .body0: return 28
				case .body1: return 20
				case .body2: return 18
				case .body3: return 16
				case .body4: return 15
				case .body5: return 14
				case .body6: return 13
			}
		}
		
		var lineHeight: CGFloat {
			return fontSize * 1.45 // 145%
		}

		var letterSpacing: CGFloat {
			fontSize * -0.005
		}
	}
}

// MARK: - Extensions
extension Text {
	func textStyle(_ style: Typography.Head) -> some View {
		self.font(style.font)
			.lineSpacing(style.lineHeight - style.fontSize)
			.kerning(style.letterSpacing)
	}
	
	func textStyle(_ style: Typography.Body) -> some View {
		self.font(style.font)
			.lineSpacing(style.lineHeight - style.fontSize)
			.kerning(style.letterSpacing)
	}
  
  func textStyle(_ style: Typography.TypographyStyle) -> some View {
    self.font(style.font)
      .lineSpacing(style.lineHeight - style.fontSize)
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
