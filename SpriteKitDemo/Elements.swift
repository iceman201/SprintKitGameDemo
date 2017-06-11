//
//  Elements.swift
//  SpriteKitDemo
//
//  Created by Liguo Jiao on 11/06/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import SpriteKit

struct CollisionBitMask {
    static let Dot: UInt32 = 0x00
    static let Obstacle: UInt32 = 0x01
}

enum ObstacleType: Int {
    case Small = 0
    case Medium = 1
    case Large = 2
}

enum RowType: Int {
    case oneS = 0
    case oneM = 1
    case oneL = 2
    case twoS = 3
    case twoM = 4
    case threeS = 5
}

extension GameScene {
    func addPlayer() {
        let dotSize = CGSize(width: 50, height: 50)
        let rocketTexture = SKTexture(image: UIImage(named: "rocket.png")!)
        dotOne = SKSpriteNode(texture: rocketTexture, size: dotSize)//(color: .red, size: dotSize)
        dotOne.position = CGPoint(x: self.size.width * 0.5 , y: 350)
        dotOne.name = "Player"
        dotOne.physicsBody?.isDynamic = false
        dotOne.physicsBody = SKPhysicsBody(rectangleOf: dotOne.size)
        dotOne.physicsBody?.categoryBitMask = CollisionBitMask.Dot
        dotOne.physicsBody?.collisionBitMask = 0
        dotOne.physicsBody?.contactTestBitMask = CollisionBitMask.Obstacle
        
        dotTwo = SKSpriteNode(texture: rocketTexture, size: dotSize)
        dotTwo.position = CGPoint(x: self.size.width * 0.5 , y: 350)
        dotTwo.name = "Player"
        dotTwo.physicsBody?.isDynamic = false
        dotTwo.physicsBody = SKPhysicsBody(rectangleOf: dotTwo.size)
        dotTwo.physicsBody?.categoryBitMask = CollisionBitMask.Dot
        dotTwo.physicsBody?.collisionBitMask = 0
        dotTwo.physicsBody?.contactTestBitMask = CollisionBitMask.Obstacle
        
        addChild(dotOne)
        addChild(dotTwo)
        
        initalPosition = dotOne.position
    }
    
    func addObstacle(type: ObstacleType) -> SKSpriteNode {
        let obstacle = SKSpriteNode(color: .white, size: CGSize(width: 0, height: 30))
        obstacle.name = "Obstacle"
        obstacle.physicsBody?.isDynamic = true
        
        switch type {
        case .Small:
            obstacle.size.width = self.size.width * 0.2
            break
        case .Medium:
            obstacle.size.width = self.size.width * 0.35
            break
        case .Large:
            obstacle.size.width = self.size.width * 0.75
            break
        }
        
        obstacle.position = CGPoint(x: 0, y: self.size.height + obstacle.size.height)
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
        obstacle.physicsBody?.categoryBitMask = CollisionBitMask.Obstacle
        obstacle.physicsBody?.collisionBitMask = 0
        return obstacle
    }
    
    func addMovement(obstacle: SKSpriteNode) {
        var actionArray = [SKAction]()
        let movePoint = CGPoint(x: obstacle.position.x, y: -obstacle.size.height)
      
        actionArray.append(SKAction.move(to: movePoint, duration: TimeInterval(3)))
        actionArray.append(SKAction.removeFromParent())
        obstacle.run(SKAction.sequence(actionArray))
    }
    
    func addRow(type: RowType) {
        switch type {
        case .oneS:
            let obstacle = addObstacle(type: .Small)
            obstacle.position = CGPoint(x: self.size.width/2, y: obstacle.position.y)
            addMovement(obstacle: obstacle)
            addChild(obstacle)
            break
        case .oneM:
            let obstacle = addObstacle(type: .Medium)
            obstacle.position = CGPoint(x: self.size.width/2, y: obstacle.position.y)
            addMovement(obstacle: obstacle)
            addChild(obstacle)
            break
        case .oneL:
            let obstacle = addObstacle(type: .Large)
            obstacle.position = CGPoint(x: self.size.width/2, y: obstacle.position.y)
            addMovement(obstacle: obstacle)
            addChild(obstacle)
            break
        case .twoS:
            let obstacleOne = addObstacle(type: .Small)
            let obstacleTwo = addObstacle(type: .Small)
            obstacleOne.position = CGPoint(x: obstacleOne.size.width + 50, y: obstacleOne.position.y)
            obstacleTwo.position = CGPoint(x: self.size.width - obstacleTwo.size.width - 50, y: obstacleTwo.position.y)
            addMovement(obstacle: obstacleOne)
            addMovement(obstacle: obstacleTwo)
            addChild(obstacleOne)
            addChild(obstacleTwo)
            break
        case .twoM:
            let obstacleOne = addObstacle(type: .Medium)
            let obstacleTwo = addObstacle(type: .Medium)
            obstacleOne.position = CGPoint(x: obstacleOne.size.width * 0.5 + 50, y: obstacleOne.position.y)
            obstacleTwo.position = CGPoint(x: self.size.width - obstacleTwo.size.width/2 - 50, y: obstacleTwo.position.y)
            addMovement(obstacle: obstacleOne)
            addMovement(obstacle: obstacleTwo)
            addChild(obstacleOne)
            addChild(obstacleTwo)
            break
        case .threeS:
            let obstacleOne = addObstacle(type: .Small)
            let obstacleTwo = addObstacle(type: .Small)
            let obstacleThree = addObstacle(type: .Small)
            obstacleOne.position = CGPoint(x: obstacleOne.size.width * 0.5 + 50, y: obstacleOne.position.y)
            obstacleTwo.position = CGPoint(x: self.size.width - obstacleTwo.size.width * 0.5 - 50, y: obstacleOne.position.y)
            obstacleThree.position = CGPoint(x: self.size.width * 0.5, y: obstacleOne.position.y)
            
            addMovement(obstacle: obstacleOne)
            addMovement(obstacle: obstacleTwo)
            addMovement(obstacle: obstacleThree)
            
            addChild(obstacleOne)
            addChild(obstacleTwo)
            addChild(obstacleThree)

            break
        }
    }
    
}
