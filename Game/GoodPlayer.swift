//
//  GoodPlayer.swift
//  Game
//
//  Created by Liliya Gateva on 1/17/15.
//  Copyright (c) 2015 Liliya Gateva. All rights reserved.
//

import Foundation

class GoodPlayer {
    
    var obiWan = Player(health:100)
    
    func attackOne() -> (message: String, damage: Int) {
        obiWan.message = "Don't make me kill you"
        obiWan.damage = 56
        obiWan.attack()
        var result = (obiWan.message, obiWan.damage)
        return result
        
    }
    
    func attackTwo() -> (message: String, damage: Int) {
        obiWan.message = "I have higher ground!Give up"
        obiWan.damage = 70
        obiWan.attack()
        var result = (obiWan.message, obiWan.damage)
        return result
        
    }
    
    func randomAttack () {
        var randAttack = rand()
        if randAttack % 2 == 0 {
            attackOne()
        } else {
            attackTwo()
        }
    }
}
