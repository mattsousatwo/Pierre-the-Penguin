//
//  GameSprite.swift
//  Pablo the Penguin
//
//  Created by Matthew Sousa on 11/10/18.
//  Copyright © 2018 Matthew Sousa. All rights reserved.
//

import SpriteKit

protocol GameSprite {
    var textureAtlas: SKTextureAtlas { get set }
    var initialSize: CGSize { get set }
    func onTap()
}
