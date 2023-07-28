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
        // Create a label for the welcome message
        scene.welcomeLabel = SKLabelNode(fontNamed: "Chalkduster")
        scene.welcomeLabel?.text = "Tic Tac Toe"
        scene.welcomeLabel?.fontColor = UIColor.black
        scene.welcomeLabel?.fontSize = 40
        scene.welcomeLabel?.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        
        // Create a sprite node for the Play button
        scene.playButton = SKSpriteNode(color: .green, size: CGSize(width: 100, height: 44))
        scene.playButton?.name = "PlayButton"
        scene.playButton?.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY - (scene.welcomeLabel?.frame.size.height ?? 0))
        
        scene.addChild(scene.welcomeLabel!)
        scene.addChild(scene.playButton!)
    }
    
    override func willExit(to nextState: GKState) {
        // Remove the welcome screen and the Play button when exiting this state
        scene.welcomeLabel?.removeFromParent()
        scene.playButton?.removeFromParent()
        scene.welcomeLabel = nil
        scene.playButton = nil
    }
}


