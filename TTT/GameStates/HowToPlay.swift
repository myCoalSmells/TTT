//
//  HowToPlay.swift
//  TTT
//
//  Created by Michael Liu on 7/25/23.
//

import SpriteKit
import GameplayKit

class HowToPlay: GKState {
    unowned let scene: GameScene

    init(scene: GameScene) {
        self.scene = scene
        super.init()
    }

    override func didEnter(from previousState: GKState?) {
        //code to execute when it is X's turn
    }
}
