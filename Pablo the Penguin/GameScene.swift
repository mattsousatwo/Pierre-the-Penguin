//
//  GameScene.swift
//  Pablo the Penguin
//
//  Created by Matthew Sousa on 11/9/18.
//  Copyright © 2018 Matthew Sousa. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    
    // didMove is called evertime the GameScene class is called
    override func didMove(to view: SKView) {
        // Make the scene Position from its lower left corner, regardless of any other settings:
        self.anchorPoint = .zero
        
       // set the scenes background
        // NOTE:  UIColor uses a scale from 0 to 1 for its colors
        self.backgroundColor = UIColor(red: 0.4, green: 0.66, blue: 0.95, alpha: 1.0)
        
        // create our bee sprite node
        // NOTE: Remove all prior arguments from this line
        let bee = SKSpriteNode()
        bee.position = CGPoint(x: 250, y: 250)
        bee.size = CGSize(width: 28, height: 24)
        self.addChild(bee)
        
        // find our new bee texture atlas
        let beeAtlas = SKTextureAtlas(named: "Enimies")
        // Grab the two bee frames from the texture atlas in an array
        // Note: Check out the syntax explicitly declaring bee-Frames
        // as an array of SKTextures/ this is not strictly necessary but it makes the intent of the codde more readable, so I chose to include the explicit type declaration here:
        let beeFrames: [SKTexture] = [
        beeAtlas.textureNamed("bee"),
        beeAtlas.textureNamed("bee-fly")]
        // create a new SKAction to animate between the frames once
        let flyAction = SKAction.animate(with: beeFrames, timePerFrame: 0.14)
        // create an action to repeate the action
        let beeAction = SKAction.repeatForever(flyAction)
        // instruct our bee to use beeAction
        bee.run(beeAction)
        
    }
}
