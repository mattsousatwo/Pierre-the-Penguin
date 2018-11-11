//
//  Ground.swift
//  Pablo the Penguin
//
//  Created by Matthew Sousa on 11/10/18.
//  Copyright © 2018 Matthew Sousa. All rights reserved.
//

import SpriteKit

// A new Class, inheriting from SKSpriteNode and adhering to GameSprite protocol
class Ground: SKSpriteNode, GameSprite { 
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Enviorment")
    // we will not use initialSize for ground, but we will need to declare it to conform to gameSprite protocol:
    var initialSize = CGSize.zero
    
    // This func tile the ground texture across the width of the ground node. we will call it from our GameScene
    func createChildren() {
        // This is one of those unique situations where we use a non-default anchor point. by positioning the ground by its top left corner, we can place it just slightly abobe the bottom of the screen, on any screen size.
        self.anchorPoint = CGPoint(x: 0, y: 1)
        
        // First, load the ground texture from the atlas:
        let texture = textureAtlas.textureNamed("ground")
        
        var tileCount: CGFloat = 0
        // we will size the tiles in thier point size they are 35 points wide and 300 points tall
        let tileSize = CGSize(width: 35, height: 300)
        
        //Build nodes until we cover the entire Ground width
        while tileCount * tileSize.width<self.size.width {
            let tileNode = SKSpriteNode(texture: texture)
            tileNode.size = tileSize
            tileNode.position.x = tileCount * tileSize.width
            // position child nodes by their upper left corner
            tileNode.anchorPoint = CGPoint(x: 0, y: 1)
            // add the child texture to the ground node:
            self.addChild(tileNode)
            
            tileCount += 1
        }
       
    }
    
    // implement onTap
    func onTap() {}
}
