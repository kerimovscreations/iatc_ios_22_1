//
//  ViewController.swift
//  Session 1
//
//  Created by Karim Karimov on 05.04.22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let tracker = DiceGameTracker()
//        let game = SnakesAndLadders()
//        game.delegate = tracker
//        game.play()
        
        let d4 = Dice(sides: 4, generator: LinearCongruentialGenerator())
        let d8 = Dice(sides: 8, generator: LinearCongruentialGenerator())
        let d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
        
        let dices: [Dice] = [
            d4,
            d8,
            d6
        ]
        print(dices.textualDescription)
        
        print(d4 == d6)
        
        var dict = Dictionary<Dice, Int>()
        dict[d4] = 4
        dict[d4] = 7
        dict[d6] = 6
        print(dict)
        
        print(d6 > d4)
        
        var levels = [SkillLevel.intermediate, SkillLevel.beginner,
                      SkillLevel.expert(stars: 5), SkillLevel.expert(stars: 3)]
        for level in levels.sorted() {
            print(level)
        }
        
        let arr: [Dice] = []
        
        let allPositive = arr.allSatisfy { item in
            return item.sides > 0
        }
    }
}

protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { elementItem in
            elementItem.textualDescription
        }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c)
            .truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

extension Dice: Equatable {
    static func == (lhs: Dice, rhs: Dice) -> Bool {
        return lhs.sides == rhs.sides
    }
}

extension Dice: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(sides)
    }
}

extension Dice: Comparable {
    static func < (lhs: Dice, rhs: Dice) -> Bool {
        return lhs.sides < rhs.sides
    }
}

protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate: AnyObject {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    weak var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

enum SkillLevel: Comparable {
    case beginner
    case intermediate
    case expert(stars: Int)
}
