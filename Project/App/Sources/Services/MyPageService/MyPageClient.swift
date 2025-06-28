//
//  MyPageClient.swift
//  Flifin
//
//  Created by Aiden.lee on 6/29/25.
//

import Foundation

import ComposableArchitecture

@DependencyClient
struct MyPageClient {
  var fetchMyPageInfo: () async throws -> MyPageInfo
}

extension MyPageClient: DependencyKey {
  static let liveValue: Self = {
    let networkManager = NetworkManager()

    return MyPageClient(fetchMyPageInfo: {
      try await networkManager
        .request(MyPageAPI.myPage)
        .map(to: MyPageDTO.self)
        .toDomain()
    })
  }()

  static let previewValue = MyPageClient(
    fetchMyPageInfo: {
      .init(
        animalCard: .init(
          name: "가을의 흰말",
          cardImageURL: URL(string: "https://picsum.photos/id/7/200/200")
        ),
        birthDate: .init(date: "2000-01-01", birthTime: "09:30:00"),
        preferredMissionCategoryList: [
          .init(displayName: "식음료", imageURL: URL(string: "https://picsum.photos/id/8/200/200")),
          .init(displayName: "이동/교통", imageURL: URL(string: "https://picsum.photos/id/9/200/200")),
        ]
      )
    }
  )
  static let testValue = Self()
}

extension DependencyValues {
  var myPageClient: MyPageClient {
    get { self[MyPageClient.self] }
    set { self[MyPageClient.self] = newValue }
  }
}
