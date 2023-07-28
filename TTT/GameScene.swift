//
//  GameScene.swift
//  TTT
//
//  Created by Hyung Lee on 7/11/23.
//

import SpriteKit
import GameplayKit

enum CellState { // the three states a cell can be in
    case null
    case x
    case o
}



class GameScene: SKScene {
    var states: GKStateMachine?
    //board stores actual state of cells to determine game end
    var board: [[CellState]] = Array(repeating: Array(repeating: .null, count: 3), count: 3)
    
    var welcomeLabel: SKLabelNode?
    var playButton: SKSpriteNode?
    
    override func sceneDidLoad() {
        //first entry to the scene. you can add node to the screen to represent visual element
        //more info on nodes below
        //https://developer.apple.com/documentation/spritekit/skspritenode/getting_started_with_sprite_nodes
        scene?.backgroundColor = .white
        
        //you can also configure states that application can get into
        configureGameState()
        
        //this is how you can triger to enter into a state
        states?.enter(GameLoadState.self)
    }
    
    func loadBoard(){
        let screenSize = UIScreen.main.bounds.size
        let boardSize = CGSize(width: 320, height: 320)
        let boardPos = CGPoint(x: screenSize.width / 2.0 - boardSize.width / 2.0,
                               y: screenSize.height / 2.0 - boardSize.height / 2.0)
        let boardNode = SKShapeNode(rect: .init(origin: boardPos,
                                                size: boardSize), cornerRadius: 8.0)
        boardNode.scene?.anchorPoint = .init(x: 0.5, y: 0.5)
        boardNode.fillColor = .clear
        boardNode.strokeColor = .black
        boardNode.lineWidth = 3.0
        addChild(boardNode)
        
        
        // create 2d array to store cells
        var cells:[[SKShapeNode?]] = Array(repeating: Array(repeating: nil, count: 3), count: 3)

        // game board
        let cellSize: CGFloat = boardSize.width / 3.0
        for i in 0..<3 {
            for j in 0..<3 {
                let square = CGRect(x: boardPos.x + (CGFloat(j) * cellSize),
                                    y: boardPos.y + (CGFloat(2-i) * cellSize), //so top left is 0-0
                                    width: cellSize,
                                    height: cellSize)
                let cellNode = SKShapeNode(rect: square)
                // copying attributes from above
                cellNode.strokeColor = .black
                cellNode.fillColor = .clear
                cellNode.lineWidth = 3.0
                cellNode.name = "\(i)-\(j)" //name for later identification
                cells[i][j] = cellNode
                addChild(cellNode)
            }
        }

    }
    
    //touch handling https://developer.apple.com/documentation/uikit/uiresponder/1621142-touchesbegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            let location = touch.location(in: self)
            let touchedNodes = nodes(at: location)
            
            for node in touchedNodes {
                if node == playButton {
                    // Enter the XState and remove the welcome screen
                    states?.enter(PlayState.self)
                    return  // Only process one touch
                }
                if node.name == "restartButton" {
                    print("Restart button touched")
                    resetBoard()
                    states?.enter(GameLoadState.self)
                    return 
                }
                if let nodeName = node.name, nodeName.contains("-") {
                    print("Touched cell \(nodeName)")
                    let components = nodeName.split(separator: "-")
                    let i = Int(components[0])!
                    let j = Int(components[1])!
                    // if the cell is null
                    if board[i][j] != .null {
                        // if cell is not null, ignore the touch
                        print("Cant move here")
                        continue
                    }
                    
                    // draw x/o depending on  current state
                    guard let playState = states?.currentState as? PlayState else { return }
//                    var imageSystemName: String?
                    if playState.isXTurn {
                        print("X turn")
                        board[i][j] = .x
//                        imageSystemName = "xmark"
                    } else {
                        print("O turn")
                        board[i][j] = .o
//                        imageSystemName = "circle"
                    }

                    // Draw the move
                    playState.draw(x: node.frame.midX, y: node.frame.midY)
                    
                    // Switch turns
                    playState.willExit(to: playState)
                    

                    if gameOver().over {
                        states?.enter(GameEndState.self)
                    }
                    // create a node with the appropriate image and add it to the touched cell
                    
                    
                    return  // only allow one cell to be touched at a time
                }
            }
        }
    }

    func gameOver() -> (over: Bool, winner: CellState?, winningLine: [String]?) {
        // row
        for i in 0..<3 {
            if board[i][0] != .null && board[i][0] == board[i][1] && board[i][0] == board[i][2] {
                return (true, board[i][0], ["\(i)-0", "\(i)-1", "\(i)-2"])
            }
        }

        // col
        for i in 0..<3 {
            if board[0][i] != .null && board[0][i] == board[1][i] && board[0][i] == board[2][i] {
                return (true, board[0][i], ["0-\(i)", "1-\(i)", "2-\(i)"])
            }
        }

        // diag
        if board[0][0] != .null && board[0][0] == board[1][1] && board[0][0] == board[2][2] {
            return (true, board[0][0], ["0-0", "1-1", "2-2"])
        }

        if board[2][0] != .null && board[2][0] == board[1][1] && board[2][0] == board[0][2] {
            return (true, board[2][0], ["2-0", "1-1", "0-2"])
        }

        // all cells filled
        for i in 0..<3 {
            for j in 0..<3 {
                if board[i][j] == .null {
                    return (false, nil, nil)
                }
            }
        }

        return (true, nil, nil)
    }




    func resetBoard() {
        // Reset game board data
        self.board = Array(repeating: Array(repeating: .null, count: 3), count: 3)
        
        // Remove all sprite nodes
        self.removeAllChildren()

        // Or remove only relevant sprite nodes like X, O and GameOver label
        // self.enumerateChildNodes(withName: "//*", using: { (node, stop) in
        //     if node.name == "xmark" || node.name == "circle" || node.name == "GameOverLabel" {
        //         node.removeFromParent()
        //     }
        // })
    }
    


    
    func configureGameState() {
        //more information on how state machine works
        //https://developer.apple.com/library/archive/documentation/General/Conceptual/GameplayKit_Guide/StateMachine.html#//apple_ref/doc/uid/TP40015172-CH7
        //setup different states that the game can be in
        
        states = GKStateMachine(states: [
            GameLoadState(scene: self),
            HowToPlay(scene: self),
            PlayState(scene: self),
            GameEndState(scene: self)
        ])
    }
    
}
