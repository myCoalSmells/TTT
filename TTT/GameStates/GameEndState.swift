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
                if let winningLine = result.winningLine {
                    drawWinningLine(winningLine: winningLine)
                }
            } else {
                gameOverText += " Draw."
            }
        let labelNode = SKLabelNode(text: gameOverText)
        labelNode.position = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2 + 200)
        labelNode.fontSize = 48
        labelNode.fontColor = UIColor.red
        scene.addChild(labelNode)
        
        // Restart button
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

    func drawWinningLine(winningLine: [String]) {
        guard let startPointNode = scene.childNode(withName: winningLine[0]),
              let endPointNode = scene.childNode(withName: winningLine[2]) else {
            return
        }
        
        let startPoint = CGPoint(x: startPointNode.frame.midX, y: startPointNode.frame.midY)
        let endPoint = CGPoint(x: endPointNode.frame.midX, y: endPointNode.frame.midY)
        
        let line = SKShapeNode()
        let pathToDraw = CGMutablePath()
        pathToDraw.move(to: startPoint)
        pathToDraw.addLine(to: endPoint)
        line.path = pathToDraw
        line.strokeColor = SKColor.red
        scene.addChild(line)
    }


}



