//
//  PlayerType.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/10.
//

import UIKit

enum PlayerType: Int {
    case player1 = 1
    case player2

    var color: UIColor {
        switch self {
        case .player1:
            return .red
        case .player2:
            return .blue
        }
    }
}
