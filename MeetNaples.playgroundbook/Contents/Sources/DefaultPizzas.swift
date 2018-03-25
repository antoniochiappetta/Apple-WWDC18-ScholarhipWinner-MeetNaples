//
//  DefaultPizzas.swift
//  MeetNaples
//
//  Created by Antonio Chiappetta on 16/03/2017.
//  Copyright © 2017 Antonio Chiappetta. All rights reserved.
//

import PlaygroundSupport

public struct DefaultPizzas {
    static let Margherita: [PlaygroundValue] = [.string("Dough"), .string("Sauce"), .string("Mozzarella"), .string("Basil")]
    static let Marinara: [PlaygroundValue] = [.string("Dough"), .string("Sauce"), .string("Origan"), .string("Garlic"), .string("Basil")]
    static let Napoletana: [PlaygroundValue] = [.string("Dough"), .string("Sauce"), .string("Origan"), .string("Anchovies")]
    static let Romana: [PlaygroundValue] = [.string("Dough"), .string("Sauce"), .string("Origan"), .string("Anchovies"), .string("Capers")]
    static let Siciliana: [PlaygroundValue] = [.string("Dough"), .string("Sauce"), .string("Origan"), .string("Anchovies"), .string("Capers"), .string("OlivesGreen")]
    static let Diavola: [PlaygroundValue] = [.string("Dough"), .string("Sauce"), .string("Mozzarella"), .string("Salame")]
    static let QuattroStagioni: [PlaygroundValue] = [.string("Dough"), .string("Sauce"), .string("Mozzarella"), .string("BakedHameOneQuarter"), .string("ArtichokesOneQuarter"), .string("MushroomsOneQuarter"), .string("OlivesBlackOneQuarter")]
    static let Capricciosa: [PlaygroundValue] = [.string("Dough"), .string("Sauce"), .string("Mozzarella"), .string("BakedHam"), .string("Artichokes"), .string("Mushrooms")]
    static let WurstelPatatine: [PlaygroundValue] = [.string("Dough"), .string("Mozzarella"), .string("Wurstel"), .string("Chips")]
    static let TonnoCipolla: [PlaygroundValue] = [.string("Dough"), .string("Sauce"), .string("Mozzarella"), .string("Tuna"), .string("Onion")]
    static let Mimosa: [PlaygroundValue] = [.string("Dough"), .string("SourCream"), .string("Mozzarella"), .string("BakedHam"), .string("Corn")]
    static let QuattroFormaggi: [PlaygroundValue] = [.string("Dough"), .string("Sauce"), .string("Mozzarella"), .string("Gorgonzola"), .string("Emmenthal"), .string("Parmeasan")]
    static let Primavera: [PlaygroundValue] = [.string("Dough"), .string("Sauce"), .string("Mozzarella"), .string("RawHam"), .string("Grana"), .string("Arugula")]
    static let Ortolana: [PlaygroundValue] = [.string("Dough"), .string("Sauce"), .string("Mozzarella"), .string("Eggplants"), .string("Zucchini"), .string("Peppers")]
    
    public static func compare(withPizza pizza: [PlaygroundValue]) -> PlaygroundValue? {
        if pizza == DefaultPizzas.Margherita {
            return .string("Margherita")
        }
        if pizza == DefaultPizzas.Marinara {
            return .string("Marinara")
        }
        if pizza == DefaultPizzas.Napoletana {
            return .string("Napoletana")
        }
        if pizza == DefaultPizzas.Romana {
            return .string("Romana")
        }
        if pizza == DefaultPizzas.Siciliana {
            return .string("Siciliana")
        }
        if pizza == DefaultPizzas.Diavola {
            return .string("Diavola")
        }
        if pizza == DefaultPizzas.QuattroStagioni {
            return .string("Quattro Stagioni")
        }
        if pizza == DefaultPizzas.Capricciosa {
            return .string("Capricciosa")
        }
        if pizza == DefaultPizzas.WurstelPatatine {
            return .string("Wurstel e Patatine")
        }
        if pizza == DefaultPizzas.TonnoCipolla {
            return .string("Tonno e Cipolla")
        }
        if pizza == DefaultPizzas.Mimosa {
            return .string("Mimosa")
        }
        if pizza == DefaultPizzas.QuattroFormaggi {
            return .string("Quattro Formaggi")
        }
        if pizza == DefaultPizzas.Primavera {
            return .string("Primavera")
        }
        if pizza == DefaultPizzas.Ortolana {
            return .string("Ortolana")
        }
        return nil
    }
}
























