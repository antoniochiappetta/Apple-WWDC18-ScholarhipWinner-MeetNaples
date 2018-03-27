//#-hidden-code
//  Contents.swift
//  MeetNaples
//
//  Created by Antonio Chiappetta on 16/03/2017.
//  Copyright © 2017 Antonio Chiappetta. All rights reserved.
//
//#-end-hidden-code
/*:
 # Time to make your pizza
 
 Last time you learnt about different kind of pizzas. Now it's time to prepare one of your own!
 
 You must be asking yourself...
 * Callout(Monologue):
 "I have such a fantasy, but don't know where to start...😣🤔"

 Perfect. The first ingredient to use is... a good [dough](glossary://Dough)!
 
 ![Dough](MiniDough.png)
 
 - Example:
 This example shows how to use the `add` method with the name of an ingredient to add it on top of your pizza.\
 \
 `add(ingredient: Ingredient.Mozzarella)`
 - - -
 1. Let's start. The first ingredient is already there for you.
 2. Add as many ingredients as you want using the same mechanism.
 3. Tap on *Run My Code* to see the animation start and store the pizza in memory. You will see it again soon.
 4. Change ingredients and run your code again to overwrite your previous edits.
 - Important:
 Do your best to get the title of **Real Neapolitan Pizzaiolo** (see hints for more about this magnificent title).
 */
//#-hidden-code
import PlaygroundSupport
let page = PlaygroundPage.current
page.needsIndefiniteExecution = true
let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy

class LiveViewListener: PlaygroundRemoteLiveViewProxyDelegate {
    
    func remoteLiveViewProxyConnectionClosed(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy) {
        PlaygroundPage.current.finishExecution()
    }
    
    func remoteLiveViewProxy(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy, received value: PlaygroundValue) {
        switch value {
        case let .string(pizzaName):
            page.assessmentStatus = .pass(message: "### Perfect! \nYou created a **Pizza \(pizzaName)**, now you are a **Real Neapolitan Pizzaiolo**! \n\n[**Next page**](@next)")
        default:
            break
        }
    }
    
}

let listener = LiveViewListener()
proxy?.delegate = listener

var ingredients: [PlaygroundValue] = []

func add(ingredient: Ingredient) {
    ingredients.append(.string(ingredient.rawValue))
}

func createRecipe(withIngredients ingredients: [PlaygroundValue]) {
    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
        proxy.send(.array(ingredients))
    }
    page.keyValueStore["Pizza"] = .array(ingredients)
}

//#-end-hidden-code
add(ingredient: Ingredient.Dough)
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, add(ingredient:), Ingredient, (, ), ., Anchovies, Artichokes, ArtichokesOneQuarter, Arugula, BakedHam, Basil, Capers, Chips, Corn, Eggplants, Emmenthal, Garlic, Gorgonzola, Grana, Mozzarella, Mushrooms, MushroomsOneQuarter, OlivesBlackOneQuarter, OlivesGreen, Onion, Origan, Parmeasan, Peppers, RawHam, RawHamOneQuarter, Salame, Sauce, SourCream, Tuna, Wurstel, Zucchini)
//#-editable-code Send the right message

//#-end-editable-code
//#-hidden-code
createRecipe(withIngredients: ingredients)
//#-end-hidden-code
