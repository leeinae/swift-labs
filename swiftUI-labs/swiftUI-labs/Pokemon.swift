//
//  Pokemon.swift
//  swiftUI-labs
//
//  Created by Inae Lee on 11/9/23.
//

import Foundation

struct Pokemon: Identifiable, Equatable {
    let id: Int
    let name: String
    let stat: String?
    let imageURL: URL?
    let type: String?
}
