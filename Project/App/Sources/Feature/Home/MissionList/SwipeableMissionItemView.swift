//
//  SwipeableMissionItemView.swift
//  Flifin
//
//  Created by 최혜린 on 7/17/25.
//

import SwiftUI

struct SwipeableMissionItemView: View {
  let missionTitle: String
  let isPinned: Bool
  let isActive: Bool
  let isSwipeEnabled: Bool
  let badgeTitle: String
  let badgeStyle: DHCBadge.BadgeStyle
  let onSwitchMission: () -> Void
  
  @Binding var isMissionCompleted: Bool
  @State private var dragOffset: CGFloat = 0
  @State private var isShowingAction = false
  
  private let actionButtonWidth: CGFloat = 137
  private let hapticFeedback = UIImpactFeedbackGenerator(style: .medium)
  
  var body: some View {
    ZStack {
      actionButton
        .frame(maxWidth: .infinity, alignment: .leading)
        .opacity(isShowingAction ? 1 : 0)
      
      MissionItem(
        missionTitle: missionTitle,
        isPinned: isPinned,
        isActive: isActive,
        isMissionCompleted: $isMissionCompleted
      ) {
        DHCBadge(
          badgeTitle: badgeTitle,
          badgeStyle: badgeStyle,
          isActive: isActive
        )
      }
      .offset(x: dragOffset)
      .if(isSwipeEnabled) {
        $0.gesture(
          DragGesture()
            .onChanged { value in
              handleDragChanged(value)
            }
            .onEnded { value in
              handleDragEnded(value)
            }
        )
      }
    }
    .animation(.spring(response: 0.4, dampingFraction: 0.8), value: dragOffset)
    .animation(.spring(response: 0.3, dampingFraction: 0.9), value: isShowingAction)
  }
  
  private var actionButton: some View {
    Button {
      withAnimation(
        .spring(response: 0.3, dampingFraction: 0.9)
      ) {
        dragOffset = 0
        isShowingAction = false
      }
      onSwitchMission()
    } label: {
      VStack(spacing: 4) {
        ImageResource.Icon.update.image
          .resizable()
          .frame(width: 20, height: 20)
        
        Text("미션 바꾸기")
          .textStyle(.body3)
          .foregroundStyle(ColorResource.Text.main.color)
      }
      .frame(maxHeight: .infinity)
      .padding(.trailing, 20)
      .frame(width: actionButtonWidth)
      .background(ColorResource.Violet._400.color)
    }
    .padding(.leading, -20)
  }
  
  private func handleDragChanged(_ value: DragGesture.Value) {
    guard isActive else { return }
    
    let translation = value.translation.width
    
    // 우측으로만 드래그 허용 (양수 값만)
    if translation > 0 {
      dragOffset = min(translation, actionButtonWidth)
      
      // 임계점 도달 시 햅틱 피드백
      if !isShowingAction && dragOffset > actionButtonWidth * 0.3 {
        isShowingAction = true
        hapticFeedback.impactOccurred()
      } else if isShowingAction && dragOffset <= actionButtonWidth * 0.3 {
        isShowingAction = false
      }
    }
  }
  
  private func handleDragEnded(_ value: DragGesture.Value) {
    guard isActive else { return }
    
    let translation = value.translation.width
    let velocity = value.velocity.width
    
    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
      // 속도가 빠르거나 충분히 드래그한 경우 액션 버튼 표시
      if velocity > 500 || translation > actionButtonWidth * 0.5 {
        dragOffset = actionButtonWidth - 40
        isShowingAction = true
      } else {
        dragOffset = 0
        isShowingAction = false
      }
    }
  }
}
