//
//  GameLogic.swift
//  TTT
//
//  Created by Michael Liu on 7/27/23.
//

import SpriteKit
import GameplayKit

enum CellState {
    case null
    case x
    case o
}

class GameLogic {
    // Add your game logic methods here

    static func gameOver(board: [[CellState]]) -> Bool {
        // Your existing gameOver() method implementation
    }
}

extension GameScene {
    // Move the relevant parts of GameScene to this extension
    // ...

    // Update the `touchesBegan` method to use `GameLogic`
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Your existing touchesBegan() implementation
        // Replace calls to methods in the GameLogic class
    }
}

