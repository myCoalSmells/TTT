//
//  GameLoadState.swift
//  TTT
//
//  Created by Hyung Lee on 7/11/23.
//

import SpriteKit
import GameplayKit

class GameLoadState: GKState {
    unowned let scene: GameScene
    
    init(scene: GameScene) {
        //now you have access to game scene from state
        self.scene = scene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        //code entrance
        //you can add loading specific setup, logic in this state
        stateMachine?.enter(XState.self)
    }
    
}
