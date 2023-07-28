//
//  PlayState.swift
//  TTT
//
//  Created by Michael Liu on 7/27/23.
//

import SpriteKit
import GameplayKit

class PlayState: GKState {
    unowned let scene: GameScene
    var isXTurn: Bool = true  // true for X's turn, false for O's turn

    init(scene: GameScene) {
        self.scene = scene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        if previousState is GameLoadState {
            scene.loadBoard()
        }
    }

    override func willExit(to nextState: GKState) {
        // Switch turns
        isXTurn = !isXTurn
    }
    
    func draw(x: CGFloat, y: CGFloat) {
        var imageSystemName: String?
        if isXTurn {
            imageSystemName = "xmark"
        } else {
            imageSystemName = "circle"
        }
        if let imageSystemName = imageSystemName, let image = UIImage(systemName: imageSystemName) {
            print("Created image with systemName \(imageSystemName)")
            let texture = SKTexture(image: image)
            let spriteNode = SKSpriteNode(texture: texture)
            spriteNode.size = .init(width: 30, height: 30)
            spriteNode.position = CGPoint(x: x, y: y)
            spriteNode.color = .white
            scene.addChild(spriteNode)
        }
    }

    
}

