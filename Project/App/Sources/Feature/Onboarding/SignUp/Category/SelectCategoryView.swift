//
//  SelectCategoryView.swift
//  Flifin
//
//  Created by hyerin on 6/17/25.
//

import SwiftUI

import ComposableArchitecture

struct SelectCategoryView: View {
  let store: StoreOf<SelectCategoryReducer>
  private let columns: [GridItem] = [GridItem(spacing: 13.5), GridItem()]
  
  init(store: StoreOf<SelectCategoryReducer>) {
    self.store = store
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      DHCNavigationBar(
        type: .progress(currentProgress: 4, totalProgress: 4),
        backButtonAction: {
          store.send(.backButtonTapped)
        }
      )
      
      IntroTitleView(
        style: .page,
        title: "개선하고 싶은 소비습관\n카테고리를 선택해 주세요.",
        description: "최소 3개이상 선택해야 해요."
      )
      
      Spacer(minLength: 23)
      
      categoryGridView
      
      CTAButton(
        size: .extraLarge,
        style: .secondary,
        title: "개인정보 기입완료",
        action: {
          store.send(.nextButtonTapped)
        }
      )
      .disabled(store.isNextButtonDisabled)
      .padding(20)
    }
    .background(ColorResource.Background.main.color)
    .navigationBarBackButtonHidden()
    .onAppear {
      store.send(.onAppear)
    }
  }
  
  private var categoryGridView: some View {
    ScrollView {
      LazyVGrid(
        columns: columns,
        spacing: 15,
        content: {
          ForEach(store.missionCategories, id: \.name) { category in
            CategoryCardButton(
              imageURL: category.imageURL,
              title: category.displayName,
              isSelected: Binding(
                get: {
                  store.selectedCategories.contains(category.name)
                },
                set: { isSelected in
                  store.send(.categoryButtonTapped(categoryName: category.name, isSelected: isSelected))
                }
              )
            )
          }
        }
      )
    }
    .scrollBounceBehavior(.basedOnSize)
    .scrollIndicators(.hidden)
    .padding(.horizontal, 20)
    .padding(.vertical, 36)
  }
}

#Preview {
  SelectCategoryView(
    store: Store(
      initialState: .init(gender: .male, calendarType: .lunar, birthday: Date(), birthTime: Date()),
      reducer: SelectCategoryReducer.init
    )
  )
}
