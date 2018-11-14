//
//  Person.swift
//  Pablo the Penguin
//
//  Created by Matthew Sousa on 11/11/18.
//  Copyright © 2018 Matthew Sousa. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode, GameSprite {
    
    var initialSize =  CGSize(width: 64, height: 64)
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Pierre")
    // Pierre has multiple animations right now we will create one animation for flying up, and one for going down:
    var flyAnimation = SKAction()
    var soarAnimation = SKAction()
    
    // Store whether we are flapping our wings or in freefall
    var flapping = false
    // set a maximum upward force
    // 57000 feels good
    let maxFlappingForce: CGFloat = 57000
//    Pierre should slow down when he flies too high
    let maxHeight: CGFloat = 1000
    
    
    
    
    init () {
        // call the init function on the base class (SKSpriteNode)
        super.init(texture: nil, color: .clear, size: initialSize)
        
        createAnimations()
        // Setting the default animation to "soarAnimation"
        self.run(soarAnimation, withKey: "soarAnimation")
        
        // Create a physice body based on one frame of pierres animation
        // we will use the third frame when his wings are tucked in
        let bodyTexture = textureAtlas.textureNamed("pierre-flying-3")
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: self.size)
        // pierre will lose momentum quickly with a high linear damping:
        self.physicsBody?.linearDamping = 0.9
        // adult penquins weigh about 30 kg:
        self.physicsBody?.mass = 30
        // prevent pireere from rotating:
        self.physicsBody?.allowsRotation = false 
        
        
    }
    
    func createAnimations() {
        let rotateUpAction = SKAction.rotate(toAngle: 0, duration: 0.475)
        rotateUpAction.timingMode = .easeOut
        let rotateDownAction = SKAction.rotate(toAngle: -1, duration: 0.8)
        rotateDownAction.timingMode = .easeOut
        
        // create flying animation
        let flyFrames: [SKTexture] = [textureAtlas.textureNamed("pierre-flying-1"), textureAtlas.textureNamed("pierre-flying-2"), textureAtlas.textureNamed("pierre-flying-3"),  textureAtlas.textureNamed("pierre-flying-4"),  textureAtlas.textureNamed("pierre-flying-3"), textureAtlas.textureNamed("pierre-flying-2")]
        
        let flyAction = SKAction.animate(with: flyFrames, timePerFrame: 0.03)
        // Group together the flying animation with rotation:
        flyAnimation = SKAction.group([SKAction.repeatForever(flyAction), rotateUpAction])
        // create the soaring animation, just one frame for now:
        let soarFrames: [SKTexture] = [textureAtlas.textureNamed("pierre-flying-1")]
        let soarAction = SKAction.animate(with: soarFrames, timePerFrame: 1)
        // group the soaring animation with rotate down
        soarAnimation = SKAction.group([SKAction.repeatForever(soarAction), rotateDownAction])
    }
    // implement onTap to conform to the GameSPrite Protocol
    func onTap() {
        
        print(" penguin tap")
    }
    
    // satisfy the NSCoder required init:
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func update() {
        // If flapping apply a new force to push pierre higher
        if self.flapping {
            var forceToApply = maxFlappingForce
            
            // apply less force if Pierre is above position 600
            if position.y > 600 {
                // the higher Pierre goes the more force we remove these next three lines determine the force to subtract
                let percentageOfMaxHeight = position.y / maxHeight
                let flappingForceSubtraction = percentageOfMaxHeight * maxFlappingForce
                forceToApply -= flappingForceSubtraction
            }
            // Apply the final force:
            self.physicsBody?.applyForce(CGVector(dx: 0, dy: forceToApply))
        }
        
        // Limit Pierre's top speed as he climbs the y-axis This prevents him from gaining enough momentum to shoot over our max height. we bend the physics for game play
        if self.physicsBody!.velocity.dy > 300 {
            self.physicsBody!.velocity.dy = 300 
        }
        
    }
    
    // Begin the flap annimation, set flapping to true
    func startFlapping() {
        self.removeAction(forKey: "soarAnimation")
        self.run(flyAnimation, withKey: "flapAnimation")
        self.flapping = true
    }
    
    // Stop flapping annimation, set flapping to false
    func stopFlapping() {
        self.removeAction(forKey: "flapAnimation")
        self.run(soarAnimation, withKey: "soarAnimation")
        self.flapping = false 
    }
    
    
    
    
    
}



