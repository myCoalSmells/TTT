////
////  GameLogic.swift
////  TTT
////
////  Created by Michael Liu on 7/27/23.
////
//
//import SpriteKit
//import GameplayKit
//
//enum CellState {
//    case null
//    case x
//    case o
//}
//
//class GameLogic {
//    var board: [[CellState]] = Array(repeating: Array(repeating: .null, count: 3), count: 3)
//    
//    // Initialize the game board and configure the scene
//    func setupGameBoard(on scene: SKScene) {
//        scene.backgroundColor = .white
//        let screenSize = UIScreen.main.bounds.size
//        let boardSize = CGSize(width: 320, height: 320)
//        let boardPos = CGPoint(x: screenSize.width / 2.0 - boardSize.width / 2.0,
//                               y: screenSize.height / 2.0 - boardSize.height / 2.0)
//        let boardNode = SKShapeNode(rect: CGRect(origin: boardPos, size: boardSize), cornerRadius: 8.0)
//        boardNode.scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        boardNode.fillColor = .clear
//        boardNode.strokeColor = .black
//        boardNode.lineWidth = 3.0
//        scene.addChild(boardNode)
//        
//        // Create 2D array to store cells
//        var cells: [[SKShapeNode?]] = Array(repeating: Array(repeating: nil, count: 3), count: 3)
//        let cellSize: CGFloat = boardSize.width / 3.0
//        for i in 0..<3 {
//            for j in 0..<3 {
//                let square = CGRect(x: boardPos.x + (CGFloat(j) * cellSize),
//                                    y: boardPos.y + (CGFloat(2-i) * cellSize),
//                                    width: cellSize,
//                                    height: cellSize)
//                let cellNode = SKShapeNode(rect: square)
//                cellNode.strokeColor = .black
//                cellNode.fillColor = .clear
//                cellNode.lineWidth = 3.0
//                cellNode.name = "\(i)-\(j)"
//                cells[i][j] = cellNode
//                scene.addChild(cellNode)
//            }
//        }
//    }
//    
//    // Check if the game is over
//    func gameOver() -> Bool {
//        // row
//        for i in 0..<3 {
//            if board[i][0] != .null && board[i][0] == board[i][1] && board[i][0] == board[i][2] {
//                return true
//            }
//        }
//
//        // col
//        for i in 0..<3 {
//            if board[0][i] != .null && board[0][i] == board[1][i] && board[0][i] == board[2][i] {
//                return true
//            }
//        }
//
//        // diag
//        if board[0][0] != .null && board[0][0] == board[1][1] && board[0][0] == board[2][2] {
//            return true
//        }
//
//        if board[2][0] != .null && board[2][0] == board[1][1] && board[2][0] == board[0][2] {
//            return true
//        }
//
//        // all cells filled
//        for i in 0..<3 {
//            for j in 0..<3 {
//                if board[i][j] == .null {
//                    return false
//                }
//            }
//        }
//
//        return true
//    }
//    
//    // Perform the necessary actions when a cell is touched
//    func handleCellTouched(at location: CGPoint, on scene: SKScene, with states: GKStateMachine?) {
//        let touchedNodes = scene.nodes(at: location)
//        
//        for node in touchedNodes {
//            if let nodeName = node.name, nodeName.contains("-") {
//                print("Touched cell \(nodeName)")
//                let components = nodeName.split(separator: "-")
//                let i = Int(components[0])!
//                let j = Int(components[1])!
//                
//                if board[i][j] != .null {
//                    print("Can't move here")
//                    continue
//                }
//                
//                var imageSystemName: String?
//                if states?.currentState is XState {
//                    print("X turn")
//                    board[i][j] = .x
//                    imageSystemName = "xmark"
//                } else if states?.currentState is OState {
//                    print("O turn")
//                    board[i][j] = .o
//                    imageSystemName = "circle"
//                }
//                
//                if isGameOver() {
//                    states?.enter(GameEndState.self)
//                }
//                
//                if let imageSystemName = imageSystemName, let image = UIImage(systemName: imageSystemName) {
//                    print("Created image with systemName \(imageSystemName)")
//                    let texture = SKTexture(image: image)
//                    let spriteNode = SKSpriteNode(texture: texture)
//                    spriteNode.size = CGSize(width: 30, height: 30)
//                    spriteNode.position = CGPoint(x: node.frame.midX, y: node.frame.midY)
//                    spriteNode.color = .white
//                    scene.addChild(spriteNode)
//                }
//                
//                return
//            }
//        }
//    }
//}
//
