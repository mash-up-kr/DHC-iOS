//
//  SelectGenderView.swift
//  ProductName
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
    VStack(alignment: .leading, spacing: 0) {
      DHCNavigationBar(
        type: .progress(currentProgress: 1, totalProgress: 4)
      )
      
      IntroInfoView(
        style: .page,
        title: "성별은\n어떻게 되시나요?",
        description: "성별에 따라 대운의\n흐름이 달라져요."
      )
      .padding(.bottom, 84)
      
      genderSection
      
      Spacer()
      
      bottomButton
    }
    .background(ColorResource.Background.main.color)
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
  
  private var bottomButton: some View {
    CTAButton(
      size: .extraLarge,
      style: .secondary,
      title: store.bottomButtonTitle,
      action: {
        store.send(.bottomButtonTapped)
      }
    )
    .disabled(store.isBottomButtonDisabled)
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
