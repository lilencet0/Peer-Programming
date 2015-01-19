// Playground - noun: a place where people can play

import UIKit

/*
Hey Lilly,

I threw everything into a playground so that it would be a little easier to see.
I structured the attack stuff differently than you did (not a wrong vs. right
thing, just differently), so I added in some other functions that do the same
kind of thing you were doing.

The main thing to remember when creating super/subclasses is that you want to be
doing as little as possible in the subclasses.

Definitely let me know if you have any questions!

-Adam

*/

class Player {
    var health = 100
    // The main difference here is that I'm implementing the attacks as an array
    // Each array element is a tuple containing a String and an Int
    // The idea is that I just randomly return a value from this array for each attack
    // The nice thing about using an array rather than hardcoded functions (i.e.
    //  attackOne() and attackTwo()) is that it scales really nicely if you want to
    //  have lots of attacks.  Of course if you only want two attacks, it doesn't
    //  really matter.
    var attackTypes: Array<(String,Int)>
    var name = ""
    
    init(name: String) {
        self.name = name
        self.attackTypes = [("Default", 0)]
    }
    
    func isAlive() -> Bool {
        return self.health > 0
    }
    
    // This function is just picking a random index of the array attackTypes
    // and returning the tuple at that index
    func attack() -> (attackName: String, dmg: Int) {
        // This is a nasty line of code.  All it's really saying is
        //  to set attackNum to a random index of the array.  The function
        //  call arc4random_uniform returns a random integer between 0 and
        //  whatever value you throw into the function.  In this case, we
        //  want a number between 0 and 1 less than the length of the array
        //  since we're using 0-up numbering
        let attackNum = Int(arc4random_uniform(UInt32(attackTypes.count-1)))
        return attackTypes[attackNum]
    }
    
    // START - Extra functions here implementing the attacks like you were doing
    
    // I'm implementing a default attackOne.
    // It's here for two reasons
    // 1) I need to use it in otherAttack()
    // 2) I can override it in subclasses
    // It should make more sense when you look at the subclasses
    func attackOne() -> (message: String, damage: Int) {
        return ("Default attack 1", 10)
    }
    
    func attackTwo() -> (message: String, damage: Int) {
        return ("Default attack 2", 10)
    }
    
    // attackOne() and attackTwo() both return tuples (String, Int)
    // since otherAttack() is returning the same thing, I can automatically
    // return the results of attackOne() or attackTwo()
    func otherAttack() -> (message: String, damage: Int) {
        if rand() % 2 == 0 {
            return attackOne()
        }
        else {
            return attackTwo()
        }
    }
    // END - Extra functions here implementing the attacks like you were doing
}

// When you create a subclass, make sure you specify the superclass in the
// declaration line
class GoodPlayer: Player {
    // This is where I'm putting values into the attackTypes array I created in
    // the Player class.  I'm also calling super.init(name: name) so I can
    // use the initializer I already declared in the Player class
    override init(name: String) {
        super.init(name: name)
        self.attackTypes = []
        self.attackTypes += [("Epic Light Storm", 70)]
        self.attackTypes += [("Magic missile", 30)]
        self.attackTypes += [("Punch of light", 25)]
        self.attackTypes += [("Poke", 5)]
    }
    
    // START - Extra functions here implementing the attacks like you were doing
    
    // This is where using classes really gets powerful.  Since we already declared
    // the otherAttack() function in the Player class, we don't need to touch it.
    // We just need to chance the attackOne() and attackTwo() functions to have the
    // messages and damage we want.  Note that even though we're overriding these
    // functions, the otherAttack() method for any instance of GoodPlayer still works.
    // It just calls these instead of the default ones in the Player class
    override func attackOne() -> (message: String, damage: Int) {
        return ("This is going to hurt", 20)
    }
    override func attackTwo() -> (message: String, damage: Int) {
        return ("CHARGE!", 40)
    }
    // END - Extra functions here implementing the attacks like you were doing
}

// This class does the same basic thing as the GoodPlayer class
class BadPlayer: Player {
    override init(name: String) {
        super.init(name: name)
        self.attackTypes = []
        self.attackTypes += [("Evil Storm of Evil", 70)]
        self.attackTypes += [("Dark missile", 30)]
        self.attackTypes += [("Punch of Darkness", 25)]
        self.attackTypes += [("Lame Poke", 5)]
    }
    
    // START - Extra functions here implementing the attacks like you were doing
    override func attackOne() -> (message: String, damage: Int) {
        return ("Stop it!", 15)
    }
    override func attackTwo() -> (message: String, damage: Int) {
        return ("ATTACK!", 55)
    }
    // END - Extra functions here implementing the attacks like you were doing
}


// Here's my Match class stuff.  Feel free to look at it or ignore it.
class Match {
    var player1: Player
    var player2: Player
    
    init (player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
    }
    
    func playGame() {
        var round = 0
        
        while self.player1.isAlive() && self.player2.isAlive() {
            println("Round \(round)!")
            println("\t\(self.player1.name): \(self.player1.health), \(self.player2.name): \(self.player2.health)")
            
            // Player 1 attacks on even rounds
            if round % 2 == 0 {
                let attack = self.player1.attack()
                println("\t\(self.player1.name) attacks with \(attack.attackName), does \(attack.dmg) points of damage\n")
                self.player2.health -= attack.dmg
            }
            // Player 2 attacjs on odd rounds
            else {
                let attack = self.player2.attack()
                println("\t\(self.player2.name) attacks with \(attack.attackName), does \(attack.dmg) points of damage\n")
                self.player1.health -= attack.dmg
            }
            
            round++
        }
        
        println("\n\nFIGHT OVER!")
        
        if self.player1.isAlive() {
            println("\(self.player1.name) wins!")
        }
        else {
            println("\(self.player2.name) wins!")
        }
    }
}

var match = Match(player1: GoodPlayer(name: "Mr. Blue"), player2: BadPlayer(name: "Mr. Pink"))

match.playGame()
