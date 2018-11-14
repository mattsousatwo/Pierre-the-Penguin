//
//  GameScene.swift
//  Pablo the Penguin
//
//  Created by Matthew Sousa on 11/9/18.
//  Copyright © 2018 Matthew Sousa. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    // Creat/Users/mattSousa/Xcode Storage 2018/Pablo the Penguin/Pablo the Penguine a constant cam as a SKCameraNode:
    let cam = SKCameraNode()
    let ground = Ground()
   let player = Player()
    
   
    
    override func didMove(to view: SKView) {
        self.anchorPoint = .zero
        self.backgroundColor = UIColor(red: 0.4, green: 0.6, blue:
            0.95, alpha: 1.0)
        
        // Assign the camera to the scene
        self.camera = cam
        
        // second bee
        let bee2 = Bee()
        bee2.position = CGPoint(x: 325, y: 325)
        self.addChild(bee2)
        // third bee
        let bee3 = Bee()
        bee3.position = CGPoint(x:200, y:325)
        self.addChild(bee3)
        
        
        // Position the ground based on the screen size
        // Position X: Negative one screen width
        // Position Y: 150 above the bottom (remember the top left anchor point)
        ground.position = CGPoint(x: -self.size.width * 2, y: 30)
        
        // set the ground width to 3x the width of the scene
        // The height can be 0, our child nodes will create the height
        ground.size = CGSize(width: self.size.width * 6, height: 0)
        // run the ground's createChildren func to build child texture tiles
        ground.createChildren()
        self.addChild(ground)
        
        
        // Position the player:
        player.position = CGPoint(x: 150, y: 250)
        // add the player node to the scene:
        self.addChild(player)
        
      
    } 
    
    // A new function
    override func didSimulatePhysics() {
        
       self.camera!.position = player.position
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            // Find the location of the touch:
            let location = touch.location(in: self)
            // locate the node at this location:
            let nodeTouched = atPoint(location)
            // Attempt to downcast the node to the GameSprite protocol
            if let gameSprite = nodeTouched as? GameSprite {
                // if this node adheres to GameSprite, call onTap:
                gameSprite.onTap()
            }
        }
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
        player.update()
        

    }
    
}

