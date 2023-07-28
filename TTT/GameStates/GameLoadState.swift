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
        self.scene = scene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        createWelcomeScreen()
    }

    func createWelcomeScreen() {
        // welcome msg
        scene.welcomeLabel = SKLabelNode(fontNamed: "Chalkduster")
        scene.welcomeLabel?.text = "Tic Tac Toe"
        scene.welcomeLabel?.fontColor = UIColor.black
        scene.welcomeLabel?.fontSize = 40
        scene.welcomeLabel?.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        
        // play button
        scene.playButton = SKSpriteNode(color: .green, size: CGSize(width: 100, height: 44))
        scene.playButton?.name = "PlayButton"
        scene.playButton?.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY - (scene.welcomeLabel?.frame.size.height ?? 0))
        
        scene.addChild(scene.welcomeLabel!)
        scene.addChild(scene.playButton!)
    }
    
    override func willExit(to nextState: GKState) {
        // clear screen
        scene.welcomeLabel?.removeFromParent()
        scene.playButton?.removeFromParent()
        scene.welcomeLabel = nil
        scene.playButton = nil
    }
}


