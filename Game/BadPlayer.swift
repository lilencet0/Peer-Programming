//
//  BadPlayer.swift
//  Game
//
//  Created by Liliya Gateva on 1/17/15.
//  Copyright (c) 2015 Liliya Gateva. All rights reserved.
//

import Foundation

class BadPlayer {

    var darthVader = Player(health:100)
    
    func attackOne() -> (message: String, damage: Int) {
        darthVader.message = "I will do what I must"
        darthVader.damage = 45
        darthVader.attack()
        var result = (darthVader.message, darthVader.damage)
        return result
        
    }
    
    func attackTwo() -> (message: String, damage: Int) {
        darthVader.message = "Prepare to die"
        darthVader.damage = 80
        darthVader.attack()
        var result = (darthVader.message, darthVader.damage)
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