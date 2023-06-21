//
//  CatDTO.swift
//  Networking
//
//  Created by Andrii Sulimenko on 17.05.2023.
//

import Foundation

public struct CatDTO: Codable, Identifiable, Hashable {
    public let id: String?
    public let url: String?
    public let width: Int?
    public let height: Int?
}

public extension CatDTO {
    static let testCat = CatDTO(
        id: "id1TestCat",
        url: "https://static1.squarespace.com/static/5fce505a09a2521ce36ff873/t/60b854f9724a9d3ed793376a/1622693115531/jianjian%2B4.jpg?format=1500w",
        width: 564,
        height: 423
    )
}
