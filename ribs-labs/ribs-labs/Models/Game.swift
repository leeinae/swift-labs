//
//  Game.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/17.
//

import RIBs

protocol GameListener: AnyObject {
    func gameDidEnd(with winner: PlayerType?)
}

protocol GameBuildable: Buildable {
    func build(withListener listener: GameListener) -> ViewableRouting
}

protocol Game {
    var id: String { get }
    var name: String { get }
    var builder: GameBuildable { get }
}
