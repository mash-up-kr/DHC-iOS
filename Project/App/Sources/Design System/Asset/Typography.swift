//
//  Font.swift
//  ProductName
//
//  Created by hyerin on 6/4/25.
//

import SwiftUI

struct Typography {
	enum FontWeight {
		case bold
		case semiBold
		case medium
		case regular
		
		var font: ProductNameFontConvertible {
			switch self {
				case .bold: return ProductNameFontFamily.WantedSans.bold
				case .semiBold: return ProductNameFontFamily.WantedSans.semiBold
				case .medium: return ProductNameFontFamily.WantedSans.medium
				case .regular: return ProductNameFontFamily.WantedSans.regular
			}
		}
	}
	
	protocol TypographyStyle {
		var fontSize: CGFloat { get }
		var lineHeight: CGFloat { get }
		var fontWeight: FontWeight { get }
		var letterSpacing: CGFloat { get }
	}
}

// MARK: - Head Styles
extension Typography {
	enum Head: CaseIterable, TypographyStyle {
		case h0, h1, h2, h3, h4, h5, h6, h7, h8
		
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
		
		var fontWeight: FontWeight {
			switch self {
				case .h0, .h1, .h6, .h7: return .bold
				case .h2, .h3, .h4, .h5, .h8: return .semiBold
			}
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
		
		var fontWeight: FontWeight {
			switch self {
				case .body0, .body1, .body2, .body3, .body4, .body5: return .medium
				case .body6: return .regular
			}
		}
		
		var letterSpacing: CGFloat {
			fontSize * -0.005
		}
	}
}

// MARK: - Extensions
extension Font {
	static func head(_ style: Typography.Head) -> Font {
		return style.fontWeight.font.swiftUIFont(size: style.fontSize)
	}
	
	static func body(_ style: Typography.Body) -> Font {
		return style.fontWeight.font.swiftUIFont(size: style.fontSize)
	}
}

extension Text {
	func headStyle(_ style: Typography.Head) -> some View {
		self.font(.head(style))
			.lineSpacing(style.lineHeight - style.fontSize)
			.kerning(style.letterSpacing)
	}
	
	func bodyStyle(_ style: Typography.Body) -> some View {
		self.font(.body(style))
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
					
					Text("H0 - Domhwang").headStyle(.h0)
					Text("H1 - Domhwang").headStyle(.h1)
					Text("H2 - Domhwang").headStyle(.h2)
					Text("H3 - Domhwang").headStyle(.h3)
					Text("H4 - Domhwang").headStyle(.h4)
					Text("H5 - Domhwang").headStyle(.h5)
					Text("H6 - Domhwang").headStyle(.h6)
					Text("H7 - Domhwang").headStyle(.h7)
					Text("H8 - Domhwang").headStyle(.h8)
				}
				
				Divider().background(Color.white).padding(.vertical)
				
				// Body Examples
				Group {
					Text("Body Styles").font(.headline).padding(.bottom, 10)
					
					Text("Body0 - Domhwang").bodyStyle(.body0)
					Text("Body1 - Domhwang").bodyStyle(.body1)
					Text("Body2 - Domhwang").bodyStyle(.body2)
					Text("Body3 - Domhwang").bodyStyle(.body3)
					Text("Body4 - Domhwang").bodyStyle(.body4)
					Text("Body5 - Domhwang").bodyStyle(.body5)
					Text("Body6 - Domhwang").bodyStyle(.body6)
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
