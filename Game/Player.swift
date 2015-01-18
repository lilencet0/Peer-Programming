//
//  Player.swift
//  Game
//
//  Created by Liliya Gateva on 1/17/15.
//  Copyright (c) 2015 Liliya Gateva. All rights reserved.
//

import Foundation

class Player {
    
    var message = ""
    var damage = 0
    
    func attack() -> (message: String, damage: Int) {
        var result = (message, damage)
        return result
    }
    
    var health: Int
    init(health: Int) {
        self.health = 100
    }
    
    func isAlive() -> Bool {
        var isAlive = true
        if health > 0 {
            isAlive = true
        } else {
            isAlive = false
        }
        return isAlive
    }
}


