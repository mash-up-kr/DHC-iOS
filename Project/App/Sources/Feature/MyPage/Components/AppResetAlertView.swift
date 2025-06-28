//
//  AppResetAlertView.swift
//  Flifin
//
//  Created by Aiden.lee on 6/28/25.
//

import SwiftUI

struct AppResetAlertView: View {
  let onReset: () -> Void
  let onCancel: () -> Void

  var body: some View {
    ZStack {
      ColorResource.Background.main.color.opacity(0.8)
        .ignoresSafeArea()

      VStack(spacing: 12) {
        HStack {
          Button(action: onCancel) {
            Image(ImageResource.Icon.cancel)
              .foregroundColor(.gray)
          }
        }
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity, alignment: .trailing)

        VStack(spacing: 16) {
          RoundedRectangle(cornerRadius: 12)
            .fill(ColorResource.Neutral._500.color)
            .frame(height: 100)
            .overlay(
              Text("그래픽 들어갈 자리")
                .foregroundColor(.white)
            )
            .padding(.horizontal, 16)

          VStack(spacing: 4) {
            Text("정말 앱을 초기화 하시겠어요?")
              .textStyle(.h3)
              .foregroundColor(ColorResource.Text.Body.primary.color)

            Text("앱을 초기화하면 다시 복구할 수 없어요")
              .textStyle(.body3)
              .foregroundColor(ColorResource.Neutral._300.color)
          }
          .padding(.horizontal, 20)
          .multilineTextAlignment(.center)
        }

        VStack(spacing: 4) {
          CTAButton(
            size: .large,
            style: .primary,
            title: "이전으로 돌아가기",
            action: onCancel
          )

          CTAButton(
            size: .large,
            style: .tertiary,
            title: "초기화",
            action: onReset
          )
        }
        .padding(.horizontal, 20)
      }
      .padding(.vertical, 16)
      .background(ColorResource.Neutral._700.color)
      .cornerRadius(12)
      .padding(.horizontal, 32)
    }
  }
}

// MARK: - Reset Alert Modifier

struct AppResetAlertModifier: ViewModifier {
  @Binding var isPresented: Bool
  let onReset: () -> Void
  let onCancel: () -> Void

  func body(content: Content) -> some View {
    content
      .fullScreenCover(isPresented: $isPresented) {
        AppResetAlertView(
          onReset: onReset,
          onCancel: onCancel
        )
        .presentationBackground(.clear)
      }
      .transaction { transaction in
        transaction.disablesAnimations = true
      }
  }
}

extension View {
  func resetAlert(
    isPresented: Binding<Bool>,
    onReset: @escaping () -> Void,
    onCancel: @escaping () -> Void = {}
  ) -> some View {
    modifier(
      AppResetAlertModifier(
        isPresented: isPresented,
        onReset: onReset,
        onCancel: onCancel
      )
    )
  }
}

#Preview {
  AppResetAlertView(
    onReset: { print("Reset tapped") },
    onCancel: { print("Cancel tapped") }
  )
}
