//#-hidden-code
//  Contents.swift
//  MeetNaples
//
//  Created by Antonio Chiappetta on 16/03/2017.
//  Copyright © 2017 Antonio Chiappetta. All rights reserved.
//
//#-end-hidden-code
/*:
 # Time to eat!
 
 Well done! You created your favourite pizza in the previous page. Now it's stored in your book data.
 - Note:
 That means that even after coming back to this page in a week you will still find it!
 
 Now look at this beautiful picture. Here's Naples with all its beautiness.
 
 Interact with the elements in the picture to learn something about them.
 1. Click on the buildings 🏙 to know more about the history of the city.
 2. Click on the sky 🌅 to see some beautiful pictures of sunrises and sunsets in Naples.
 2. Click on the [Vesuvius](glossary://Vesuvius) to know about the most famous volcano in Italy.
 3. Click on the sea to know about Naples' wonderful gulf, including the islands [Ischia](glossary://Ischia), [Capri](glossary://Capri) and [Procida](glossary://Procida) as well as the [Sorrentine Peninsula](glossary://Sorrentine%20Peninsula).
 - - -
 When you're done with this, send the correct message among the ones suggested to see your pizza being put on the windowsill.
 * Callout(And then what?):
 And then... just imagine to be there and eat your pizza!
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
            page.assessmentStatus = .pass(message: "### Perfect! \nYou enjoyed Naples and are finally ready to eat your wonderful **Pizza \(pizzaName)**!")
        default:
            break
        }
    }
    
}

let listener = LiveViewListener()
proxy?.delegate = listener

func eatPizza() {
    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
        proxy.send(.boolean(true))
    }
}

func whatDoIHaveToDo() {
    
}

func backHome() {
    
}

func wrongInstruction() {
    
}
//#-end-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, whatDoIHaveToDo(), backHome(), wrongInstruction(), eatPizza())
//#-editable-code Send the right message

//#-end-editable-code
