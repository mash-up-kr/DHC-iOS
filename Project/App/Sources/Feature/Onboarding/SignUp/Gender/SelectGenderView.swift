//
//  SelectGenderView.swift
//  Flifin
//
//  Created by hyerin on 6/13/25.
//

import SwiftUI

import ComposableArchitecture

struct SelectGenderView: View {
  @Bindable var store: StoreOf<SelectGenderReducer>
  
  init(store: StoreOf<SelectGenderReducer>) {
    self.store = store
  }
  
  var body: some View {
    NavigationStack(
      path: $store.scope(state: \.path, action: \.path)
    ) {
      VStack(alignment: .leading, spacing: 0) {
        DHCNavigationBar(
          type: .progress(currentProgress: 1, totalProgress: 4)
        )
        
        IntroTitleView(
          style: .page,
          title: "성별은\n어떻게 되시나요?",
          description: "성별에 따라 대운의\n흐름이 달라져요."
        )
        .padding(.bottom, 84)
        
        genderSection
        
        Spacer()
        
        CTAButton(
          size: .extraLarge,
          style: .secondary,
          title: "다음",
          action: {
            store.send(.nextButtonTapped)
          }
        )
        .disabled(store.isBottomButtonDisabled)
        .padding(20)
      }
      .background(ColorResource.Background.main.color)
      .navigationBarBackButtonHidden()
    }  destination: { store in
      switch store.case {
      case .birthdayInput(let store):
        BirthdayInputView(store: store)
      case .birthTimeInput(let store):
        BirthTimeInputView(store: store)
      case .selectCategory(let store):
        SelectCategoryView(store: store)
      }
    }
  }
  
  private var genderSection: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("성별")
        .textStyle(.body5)
        .foregroundStyle(ColorResource.Text.Body.primary.color)
      
      HStack(spacing: 8) {
        SelectableButton(
          title: "남성",
          size: .medium,
          action: {
            store.send(.genderButtonTapped(.male))
          },
          isSelected: .constant(store.gender == .male)
        )
        
        SelectableButton(
          title: "여성",
          size: .medium,
          action: {
            store.send(.genderButtonTapped(.female))
          },
          isSelected: .constant(store.gender == .female)
        )
      }
    }
    .padding(20)
  }
}

#Preview {
  SelectGenderView(
    store: Store(
      initialState: .init(),
      reducer: SelectGenderReducer.init
    )
  )
}
