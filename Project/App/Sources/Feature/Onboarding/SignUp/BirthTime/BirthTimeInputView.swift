//
//  BirthTimeInputView.swift
//  Flifin
//
//  Created by hyerin on 6/13/25.
//

import SwiftUI

import ComposableArchitecture

struct BirthTimeInputView: View {
  @Bindable var store: StoreOf<BirthTimeInputReducer>
  
  init(store: StoreOf<BirthTimeInputReducer>) {
    self.store = store
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      DHCNavigationBar(
        type: .progress(currentProgress: 3, totalProgress: 4),
        backButtonAction: {
          store.send(.backButtonTapped)
        }
      )
      
      IntroTitleView(
        style: .page,
        title: "태어난 시간을\n알려주세요",
        description: "태어난 시간이 정확할수록\n더 적합한 정보를 제공해 드릴 수 있어요"
      )
      
      Spacer(minLength: 24)
      
      birthTimeSection
      
      datePicker
      
      nextButton
    }
    .background(ColorResource.Background.main.color)
    .navigationBarBackButtonHidden()
  }

  private var birthTimeSection: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("태어난 시간")
        .textStyle(.body5)
        .foregroundStyle(ColorResource.Text.Body.primary.color)
      
      CheckButton(
        title: "잘 모르겠어요",
        action: {
          store.send(.noIdeaButtonTapped)
        },
        isChecked: .constant(store.isNoIdeaButtonChecked)
      )
    }
    .padding(20)
  }
  
  private var datePicker: some View {
    DHCDatePicker(
      type: .hourAndMinute,
      date: $store.birthTime.sending(\.birthTimeChanged)
    )
    .frame(maxWidth: .infinity)
    .overlay {
      if store.isNoIdeaButtonChecked {
        Rectangle()
          .foregroundStyle(ColorResource.Background.main.color.opacity(0.4))
      }
    }
  }
  
  private var nextButton: some View {
    CTAButton(
      size: .extraLarge,
      style: .secondary,
      title: "다음",
      action: {
        store.send(.nextButtonTapped)
      }
    )
    .padding(20)
  }
}

#Preview {
  BirthTimeInputView(
    store: Store(
      initialState: .init(gender: .male, calendarType: .lunar, birthday: Date()),
      reducer: BirthTimeInputReducer.init
    )
  )
}
