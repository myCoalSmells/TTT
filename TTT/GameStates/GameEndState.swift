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
        
        let result = scene.gameOver()
        var gameOverText = "Game Over!"
        if let winner = result.winner {
            gameOverText += winner == .x ? " X wins!" : " O wins!"
        } else {
            gameOverText += " Draw."
        }
        let gameOverLabel = SKLabelNode(text: gameOverText)
        let labelNode = SKLabelNode(text: gameOverText)
        labelNode.position = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2 + 200)
        labelNode.fontSize = 48
        labelNode.fontColor = UIColor.red
        scene.addChild(labelNode)
        
        // Adding Restart button
        let restartButton = SKLabelNode(text: "Restart")
        restartButton.position = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2 - 200)
        restartButton.fontSize = 36
        restartButton.fontColor = UIColor.blue
        restartButton.name = "restartButton" 
        scene.addChild(restartButton)
    }
    
    override func willExit(to nextState: GKState) {
        scene.childNode(withName: "restartButton")?.removeFromParent()
    }

}



