//
//  AppResetAlertView.swift
//  Flifin
//
//  Created by Aiden.lee on 6/28/25.
//

import SwiftUI

import ComposableArchitecture

struct AppResetAlertView: View {
  @Bindable var store: StoreOf<AppResetAlertReducer>

  var body: some View {
    ZStack {
      ColorResource.Background.main.color.opacity(0.8)
        .ignoresSafeArea()

      VStack(spacing: 12) {
        Button {
          store.send(.cancelButtonTapped)
        } label: {
          Image(ImageResource.Icon.cancel)
            .resizable()
            .frame(width: 28, height: 28)
            .foregroundColor(ColorResource.Neutral._300.color)
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
            action: { store.send(.cancelButtonTapped) }
          )

          CTAButton(
            size: .large,
            style: .tertiary,
            title: "초기화",
            action: { store.send(.confirmButtonTapped) }
          )
        }
        .padding(.horizontal, 20)
      }
      .padding(.vertical, 16)
      .background(ColorResource.Neutral._700.color)
      .clipShape(.rect(cornerRadius: 12))
      .padding(.horizontal, 32)
      .loadingOverlay(isLoading: store.isLoading)
    }
  }
}

// MARK: - Reset Alert Modifier

struct AppResetAlertModifier: ViewModifier {
  let item: Binding<StoreOf<AppResetAlertReducer>?>

  func body(content: Content) -> some View {
    content
      .fullScreenCover(item: item) { store in
        AppResetAlertView(store: store)
          .presentationBackground(.clear)
      }
      .transaction { transaction in
        transaction.disablesAnimations = true
      }
  }
}

extension View {
  func resetAlert(
    item: Binding<StoreOf<AppResetAlertReducer>?>
  ) -> some View {
    modifier(AppResetAlertModifier(item: item))
  }
}

#Preview {
  AppResetAlertView(
    store: .init(
      initialState: AppResetAlertReducer.State(),
      reducer: AppResetAlertReducer.init
    )
  )
}
