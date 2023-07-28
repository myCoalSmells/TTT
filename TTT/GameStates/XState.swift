//
//  XState.swift
//  TTT
//
//  Created by Michael Liu on 7/15/23.
//

import SpriteKit
import GameplayKit

class XState: GKState {
    unowned let scene: GameScene
    
    init(scene: GameScene) {
        self.scene = scene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        // Load the board when entering the XState
    }
}


