//
//  Utilities.swift
//  MeetNaples
//
//  Created by Antonio Chiappetta on 28/03/2018.
//  Copyright © 2018 Antonio Chiappetta. All rights reserved.
//

import Foundation
import PlaygroundSupport

public enum Ingredient: String {
    case Anchovies
    case Artichokes
    case ArtichokesOneQuarter
    case Arugula
    case BakedHam
    case Basil
    case Capers
    case Chips
    case Corn
    case Dough
    case Eggplants
    case Emmenthal
    case Garlic
    case Gorgonzola
    case Grana
    case Mozzarella
    case Mushrooms
    case MushroomsOneQuarter
    case OlivesBlackOneQuarter
    case OlivesGreen
    case Onion
    case Origan
    case Parmeasan
    case Peppers
    case RawHam
    case RawHamOneQuarter
    case Salame
    case Sauce
    case SourCream
    case Tuna
    case Wurstel
    case Zucchini
}

public class AnimationInfo: NSObject {
    let pizzaView: PizzaAnimationView
    let completion: (() -> Void)?
    
    public init(pizzaView: PizzaAnimationView) {
        self.pizzaView = pizzaView
        self.completion = nil
        super.init()
    }
    
    public init(pizzaView: PizzaAnimationView, completion: @escaping @convention(block) () -> Void) {
        self.pizzaView = pizzaView
        self.completion = completion
        super.init()
    }
    
}

extension PlaygroundValue: Equatable {
    public static func ==(left: PlaygroundValue, right: PlaygroundValue) -> Bool {
        switch left {
        case let .string(leftString):
            guard case let .string(rightString) = right else {
                return false
            }
            if leftString == rightString {
                return true
            } else {
                return false
            }
        case let .integer(leftInteger):
            guard case let .integer(rightInteger) = right else {
                return false
            }
            if leftInteger == rightInteger {
                return true
            } else {
                return false
            }
        default:
            return false
        }
    }
}
