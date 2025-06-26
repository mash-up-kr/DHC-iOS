//
//  CategoryInfo.swift
//  ProductName
//
//  Created by hyerin on 6/17/25.
//

import Foundation

struct CategoryInfo: Equatable, Hashable {
  let title: String
  let url: URL
  let id: Int
  
#if DEV
  static let mock: [CategoryInfo] = [
    .init(
      title: "식음료",
      url: "https://cdn.freebiesupply.com/images/large/2x/apple-logo-transparent.png",
      id: 0
    ),
    .init(
      title: "이동, 교통",
      url: "https://cdn.freebiesupply.com/images/large/2x/apple-logo-transparent.png",
      id: 1
    ),
    .init(
      title: "디지털, 구독",
      url: "https://cdn.freebiesupply.com/images/large/2x/apple-logo-transparent.png",
      id: 2
    ),
    .init(
      title: "쇼핑",
      url: "https://cdn.freebiesupply.com/images/large/2x/apple-logo-transparent.png",
      id: 3
    ),
    .init(
      title: "취미, 문화",
      url: "https://cdn.freebiesupply.com/images/large/2x/apple-logo-transparent.png",
      id: 4
    ),
    .init(
      title: "사교, 모임",
      url: "https://cdn.freebiesupply.com/images/large/2x/apple-logo-transparent.png",
      id: 5
    )
  ]
#endif
}
