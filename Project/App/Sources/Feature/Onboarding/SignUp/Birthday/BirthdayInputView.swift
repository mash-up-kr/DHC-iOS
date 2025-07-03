//
//  BirthdayInputView.swift
//  Flifin
//
//  Created by hyerin on 6/13/25.
//

import SwiftUI

import ComposableArchitecture

struct BirthdayInputView: View {
  @Bindable var store: StoreOf<BirthdayInputReducer>
  
  init(store: StoreOf<BirthdayInputReducer>) {
    self.store = store
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      DHCNavigationBar(
        type: .progress(currentProgress: 2, totalProgress: 4),
        backButtonAction: {
          store.send(.backButtonTapped)
        }
      )
      
      IntroTitleView(
        style: .page,
        title: "생년월일을\n알려주세요",
        description: "생년월일이 정확할수록\n더 적합한 정보를 제공해 드릴 수 있어요"
      )
      
      Spacer(minLength: 24)
      
      birthdaySection
      
      DHCDatePicker(
        type: .date,
        date: $store.birthday.sending(\.birthdayChanged)
      )
      .frame(maxWidth: .infinity)
      
      nextButton
    }
    .background(ColorResource.Background.main.color)
    .navigationBarBackButtonHidden()
  }

  private var birthdaySection: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("생년월일")
        .textStyle(.body5)
        .foregroundStyle(ColorResource.Text.Body.primary.color)
      
      HStack(spacing: 8) {
        SelectableButton(
          title: "양력",
          size: .small,
          action: {
            store.send(.calendarTypeButtonTapped(.solar))
          },
          isSelected: .constant(store.calendarType == .solar)
        )
        
        SelectableButton(
          title: "음력",
          size: .small,
          action: {
            store.send(.calendarTypeButtonTapped(.lunar))
          },
          isSelected: .constant(store.calendarType == .lunar)
        )
      }
    }
    .padding(20)
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
  BirthdayInputView(
    store: Store(
      initialState: .init(gender: .male),
      reducer: BirthdayInputReducer.init
    )
  )
}
