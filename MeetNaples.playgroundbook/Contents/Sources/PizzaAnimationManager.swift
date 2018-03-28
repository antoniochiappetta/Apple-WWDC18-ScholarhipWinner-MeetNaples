//
//  PizzaAnimationManager.swift
//  MeetNaples
//
//  Created by Antonio Chiappetta on 28/03/2018.
//  Copyright © 2018 Antonio Chiappetta. All rights reserved.
//

import UIKit

public class PizzaAnimationManager : NSObject {
    
    // Takes an ingredient with quantities to return the corresponding selector among the methods to animate ingredients in pizzaView
    public static func animationForIngredient(ingredient: Ingredient) ->  Selector {
        let ingredientString = ingredient.rawValue
        let selectorString = "add" + ingredientString + "AnimationWithCompletion:"
        let selector = NSSelectorFromString(selectorString)
        return selector
    }
    
    // Takes the name of the pizza to return the corresponding selector among the methods in this class
    public static func animationForPizza(withName name: String) -> Selector {
        let nameString = name.components(separatedBy: " ")
        let nameWithSpaces = nameString.joined()
        let pizzaString = nameWithSpaces
        let selectorString = "createPizza" + pizzaString + "WithAnimationInfo:"
        let selector = NSSelectorFromString(selectorString)
        return selector
    }
    
    // Animates a pizzaView with a list of ingredients and quantities
    public static func createPizza(pizzaView: PizzaAnimationView, ingredients: [Ingredient], withCompletion completion: (() -> Void)?) {
        
        var selectors: [Selector] = []
        for ingredient in ingredients {
            selectors.append(animationForIngredient(ingredient: ingredient))
        }
        
        // perform all the chain of selectors where each of them is completion handler of the previous one
        // the last completion has to be { () -> Void in (if let completion = completion { completion() }) }
        let endBlock: @convention(block) () -> Void = {
            if let completion = completion {
                completion()
            }
        }
        
        let callable = selectors.reversed().reduce(endBlock) {
            (partial: @escaping @convention(block) () -> Void, nextFunc) in
            let retCall: @convention(block) () -> Void = {
                pizzaView.perform(nextFunc, with: partial)
            }
            return retCall
        }
        callable()
        
    }
    
    public static func createPizza(pizzaView: PizzaAnimationView, pizzaName: String, withCompletion completion: (() -> Void)?) {
        let pizzaSelector = animationForPizza(withName: pizzaName)
        if completion != nil {
            let animationInfo = AnimationInfo(pizzaView: pizzaView, completion: completion!)
            PizzaAnimationManager.perform(pizzaSelector, with: animationInfo)
        } else {
            let animationInfo = AnimationInfo(pizzaView: pizzaView)
            PizzaAnimationManager.perform(pizzaSelector, with: animationInfo)
        }
    }
    
    @objc public static func createPizzaMargherita(animationInfo: AnimationInfo) {
        let pizzaView = animationInfo.pizzaView
        let completion = animationInfo.completion
        pizzaView.addDoughAnimation { (completed) in
            pizzaView.addSauceAnimation(completion: { (completed) in
                pizzaView.addMozzarellaAnimation(completion: { (completed) in
                    pizzaView.addBasilAnimation(completion: { (completed) in
                        if let completion = completion {
                            completion()
                        }
                    })
                })
            })
        }
    }
    
    @objc public static func createPizzaMarinara(animationInfo: AnimationInfo) {
        let pizzaView = animationInfo.pizzaView
        let completion = animationInfo.completion
        pizzaView.addDoughAnimation { (completed) in
            pizzaView.addSauceAnimation(completion: { (completed) in
                pizzaView.addOriganAnimation(completion: { (completed) in
                    pizzaView.addGarlicAnimation(completion: { (completed) in
                        pizzaView.addBasilAnimation(completion: { (completed) in
                            if let completion = completion {
                                completion()
                            }
                        })
                    })
                })
            })
        }
    }
    
    @objc public static func createPizzaNapoletana(animationInfo: AnimationInfo) {
        let pizzaView = animationInfo.pizzaView
        let completion = animationInfo.completion
        pizzaView.addDoughAnimation { (completed) in
            pizzaView.addSauceAnimation(completion: { (completed) in
                pizzaView.addOriganAnimation(completion: { (completed) in
                    pizzaView.addAnchoviesAnimation(completion: { (completed) in
                        if let completion = completion {
                            completion()
                        }
                    })
                })
            })
        }
    }
    
    @objc public static func createPizzaRomana(animationInfo: AnimationInfo) {
        let pizzaView = animationInfo.pizzaView
        let completion = animationInfo.completion
        pizzaView.addDoughAnimation { (completed) in
            pizzaView.addSauceAnimation(completion: { (completed) in
                pizzaView.addOriganAnimation(completion: { (completed) in
                    pizzaView.addAnchoviesAnimation(completion: { (completed) in
                        pizzaView.addCapersAnimation(completion: { (completed) in
                            if let completion = completion {
                                completion()
                            }
                        })
                    })
                })
            })
        }
    }
    
    @objc public static func createPizzaSiciliana(animationInfo: AnimationInfo) {
        let pizzaView = animationInfo.pizzaView
        let completion = animationInfo.completion
        pizzaView.addDoughAnimation { (completed) in
            pizzaView.addSauceAnimation(completion: { (completed) in
                pizzaView.addOriganAnimation(completion: { (completed) in
                    pizzaView.addAnchoviesAnimation(completion: { (completed) in
                        pizzaView.addCapersAnimation(completion: { (completed) in
                            pizzaView.addOlivesGreenAnimation(completion: { (completed) in
                                if let completion = completion {
                                    completion()
                                }
                            })
                        })
                    })
                })
            })
        }
    }
    
    @objc public static func createPizzaDiavola(animationInfo: AnimationInfo) {
        let pizzaView = animationInfo.pizzaView
        let completion = animationInfo.completion
        pizzaView.addDoughAnimation { (completed) in
            pizzaView.addSauceAnimation(completion: { (completed) in
                pizzaView.addMozzarellaAnimation(completion: { (completed) in
                    pizzaView.addSalameAnimation(completion: { (completed) in
                        if let completion = completion {
                            completion()
                        }
                    })
                })
            })
        }
    }
    
    @objc public static func createPizzaQuattroStagioni(animationInfo: AnimationInfo) {
        let pizzaView = animationInfo.pizzaView
        let completion = animationInfo.completion
        pizzaView.addDoughAnimation { (completed) in
            pizzaView.addSauceAnimation(completion: { (completed) in
                pizzaView.addMozzarellaAnimation(completion: { (completed) in
                    pizzaView.addBakedHamOneQuarterAnimation(completion: { (completed) in
                        pizzaView.addArtichokesOneQuarterAnimation(completion: { (completed) in
                            pizzaView.addMushroomsOneQuarterAnimation(completion: { (completed) in
                                pizzaView.addOlivesBlackOneQuarterAnimation(completion: { (completed) in
                                    if let completion = completion {
                                        completion()
                                    }
                                })
                            })
                        })
                    })
                })
            })
        }
    }
    
    @objc public static func createPizzaCapricciosa(animationInfo: AnimationInfo) {
        let pizzaView = animationInfo.pizzaView
        let completion = animationInfo.completion
        pizzaView.addDoughAnimation { (completed) in
            pizzaView.addSauceAnimation(completion: { (completed) in
                pizzaView.addMozzarellaAnimation(completion: { (completed) in
                    pizzaView.addBakedHamAnimation(completion: { (completed) in
                        pizzaView.addArtichokesAnimation(completion: { (completed) in
                            pizzaView.addMushroomsAnimation(completion: { (completed) in
                                if let completion = completion {
                                    completion()
                                }
                            })
                        })
                    })
                })
            })
        }
    }
    
    @objc public static func createPizzaWurstelEPatatine(animationInfo: AnimationInfo) {
        let pizzaView = animationInfo.pizzaView
        let completion = animationInfo.completion
        pizzaView.addDoughAnimation { (completed) in
            pizzaView.addMozzarellaAnimation(completion: { (completed) in
                pizzaView.addWurstelAnimation(completion: { (completed) in
                    pizzaView.addChipsAnimation(completion: { (completed) in
                        if let completion = completion {
                            completion()
                        }
                    })
                })
            })
        }
    }
    
    @objc public static func createPizzaTonnoECipolla(animationInfo: AnimationInfo) {
        let pizzaView = animationInfo.pizzaView
        let completion = animationInfo.completion
        pizzaView.addDoughAnimation { (completed) in
            pizzaView.addSauceAnimation(completion: { (completed) in
                pizzaView.addMozzarellaAnimation(completion: { (completed) in
                    pizzaView.addTunaAnimation(completion: { (completed) in
                        pizzaView.addOnionAnimation(completion: { (completed) in
                            if let completion = completion {
                                completion()
                            }
                        })
                    })
                })
            })
        }
    }
    
    @objc public static func createPizzaMimosa(animationInfo: AnimationInfo) {
        let pizzaView = animationInfo.pizzaView
        let completion = animationInfo.completion
        pizzaView.addDoughAnimation { (completed) in
            pizzaView.addSourCreamAnimation(completion: { (completed) in
                pizzaView.addMozzarellaAnimation(completion: { (completed) in
                    pizzaView.addBakedHamAnimation(completion: { (completed) in
                        pizzaView.addCornAnimation(completion: { (completed) in
                            if let completion = completion {
                                completion()
                            }
                        })
                    })
                })
            })
        }
    }
    
    @objc public static func createPizzaQuattroFormaggi(animationInfo: AnimationInfo) {
        let pizzaView = animationInfo.pizzaView
        let completion = animationInfo.completion
        pizzaView.addDoughAnimation { (completed) in
            pizzaView.addSauceAnimation(completion: { (completed) in
                pizzaView.addMozzarellaAnimation(completion: { (completed) in
                    pizzaView.addGorgonzolaAnimation(completion: { (completed) in
                        pizzaView.addEmmenthalAnimation(completion: { (completed) in
                            pizzaView.addParmeasanAnimation(completion: { (completed) in
                                if let completion = completion {
                                    completion()
                                }
                            })
                        })
                    })
                })
            })
        }
    }
    
    @objc public static func createPizzaPrimavera(animationInfo: AnimationInfo) {
        let pizzaView = animationInfo.pizzaView
        let completion = animationInfo.completion
        pizzaView.addDoughAnimation { (completed) in
            pizzaView.addSauceAnimation(completion: { (completed) in
                pizzaView.addMozzarellaAnimation(completion: { (completed) in
                    pizzaView.addRawHamAnimation(completion: { (completed) in
                        pizzaView.addGranaAnimation(completion: { (completed) in
                            pizzaView.addArugulaAnimation(completion: { (completed) in
                                if let completion = completion {
                                    completion()
                                }
                            })
                        })
                    })
                })
            })
        }
    }
    
    @objc public static func createPizzaOrtolana(animationInfo: AnimationInfo) {
        let pizzaView = animationInfo.pizzaView
        let completion = animationInfo.completion
        pizzaView.addDoughAnimation { (completed) in
            pizzaView.addSauceAnimation(completion: { (completed) in
                pizzaView.addMozzarellaAnimation(completion: { (completed) in
                    pizzaView.addEggplantsAnimation(completion: { (completed) in
                        pizzaView.addZucchiniAnimation(completion: { (completed) in
                            pizzaView.addPeppersAnimation(completion: { (completed) in
                                if let completion = completion {
                                    completion()
                                }
                            })
                        })
                    })
                })
            })
        }
    }
    
}
