//
//  GameEndState.swift
//  TTT
//
//  Created by Michael Liu on 7/15/23.
//

import SpriteKit
import GameplayKit


class GameEndState: GKState {
    unowned let scene: GameScene

    init(scene: SKScene) {
        self.scene = scene as! GameScene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        print("Game Ended")
        
        let screenSize = UIScreen.main.bounds.size
        
        let labelNode = SKLabelNode(text: "Game Over!")
        labelNode.position = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2 + 200)
        labelNode.fontSize = 48
        labelNode.fontColor = UIColor.red
        scene.addChild(labelNode)
    }
}


