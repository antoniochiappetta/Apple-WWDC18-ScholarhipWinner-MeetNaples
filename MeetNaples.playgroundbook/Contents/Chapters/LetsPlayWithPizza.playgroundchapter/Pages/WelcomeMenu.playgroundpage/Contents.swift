//#-hidden-code
//  Contents.swift
//  MeetNaples
//
//  Created by Antonio Chiappetta on 16/03/2017.
//  Copyright © 2017 Antonio Chiappetta. All rights reserved.
//
//#-end-hidden-code
/*:
 # Welcome in Naples!
 
 Learn about this wonderful city starting from its most famous product: [pizza](glossary://Pizza).
 This book will guide you through the process of learning which ingredients are needed to make the most famous types of pizza.
 You will need to learn about at least one particular pizza to get to the next step.
 
 ![Pizza](MiniPizzaMargherita.png)
 - - -
 1. First of all, to enable the animations on each pizza and start the counter, tap on *Run my code*.
 2. Then turn the wheel of the [menu](glossary://Menu) to choose the pizza you want to know about.
 2. Once chosen one, click on it to **learn** how the various [ingredient](glossary://Ingredient)s are placed on it.
 - Important:
 Pay attention to the *correct order* of the ingredients because later you will be prompted to create your own pizza based on such ingredients.
 */
//#-code-completion(everything, hide)
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
        case let .boolean(animated):
            if animated == true {
                var numberOfPizzasAnimated = 0
                if let currentNumber = page.keyValueStore["NumberOfPizzasAnimated"] {
                    switch currentNumber {
                    case let .integer(number):
                        numberOfPizzasAnimated = number + 1
                        page.keyValueStore["NumberOfPizzasAnimated"] = .integer(numberOfPizzasAnimated)
                    default:
                        break
                    }
                    if numberOfPizzasAnimated > 0 {
                        page.assessmentStatus = .pass(message: "### Perfect! \nYou learnt about different pizzas, go ahead and create yours! \n\n[**Next page**](@next)")
                    }
                } else {
                    page.keyValueStore["NumberOfPizzasAnimated"] = .integer(1)
                }
            }
        default:
            break
        }
    }
    
}


let listener = LiveViewListener()
proxy?.delegate = listener

func startLearning() {
    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
        proxy.send(.boolean(true))
    }
}

//#-end-hidden-code
startLearning()
//#-end-editable-code

