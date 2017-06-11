//
//  GameScene.swift
//  SpriteKitDemo
//
//  Created by Liguo Jiao on 11/06/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var dotOne: SKSpriteNode!
    var dotTwo: SKSpriteNode!
    var lastUpdate = TimeInterval()
    var lastYield = TimeInterval()
    
    var starfield:SKEmitterNode!
    
    var initalPosition: CGPoint!
    
    override func didMove(to view: SKView) {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        addPlayer()
        addRow(type: .threeS)
        
        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x: 550, y: 1920)
        
        starfield.advanceSimulationTime(10)
        self.addChild(starfield)
        
        //starfield.zPosition = -1
        
    }
    
    fileprivate func generateRandomeRow() {
        let randomInt = Int(arc4random_uniform(6))
    
        switch randomInt {
        case 0:
            addRow(type: RowType(rawValue: 0)!)
            break
        case 1:
            addRow(type: RowType(rawValue: 1)!)
            break
        case 2:
            addRow(type: RowType(rawValue: 2)!)
            break
        case 3:
            addRow(type: RowType(rawValue: 3)!)
            break
        case 4:
            addRow(type: RowType(rawValue: 4)!)
            break
        case 5:
            addRow(type: RowType(rawValue: 5)!)
            break
        default:
            break
        }
    }
    
    fileprivate func updateWithTimeSinceLastUpdate (timeSinceLastUpdate: CFTimeInterval) {
        lastYield += timeSinceLastUpdate
        if lastYield > 0.6 {
            lastYield = 0
            generateRandomeRow()
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "Player" {
            print("Gameover")
            showGameOver()
        }
    }
    
    fileprivate func showGameOver() {
        let transition = SKTransition.fade(withDuration: TimeInterval(0.5))
        let gameOverScene = GameoverScene(size: self.size)
        self.view?.presentScene(gameOverScene, transition: transition)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let maxForce = touch.maximumPossibleForce
            let force = touch.force
            let standardPushForce = force/maxForce
            
            dotOne.position.x = self.size.width / 2 - standardPushForce * (self.size.width * 0.5 - 25)
            dotTwo.position.x = self.size.width / 2 + standardPushForce * (self.size.width * 0.5 - 25)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        var timeSinceLastUpdate = currentTime - lastUpdate
        lastUpdate = currentTime
        if timeSinceLastUpdate > 1 {
            timeSinceLastUpdate = 1/60
            lastUpdate = currentTime
        }
        
        updateWithTimeSinceLastUpdate(timeSinceLastUpdate: timeSinceLastUpdate)
    }
}
