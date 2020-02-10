//#-hidden-code
//  Contents.swift
//  MeetNaples
//
//  Created by Antonio Chiappetta on 28/03/2018.
//  Copyright © 2018 Antonio Chiappetta. All rights reserved.
//
//#-end-hidden-code
/*:
 # Time to eat!
 
 Well done! You created your favourite pizza in the previous page. Now it's stored in your book data.
 - Note:
 That means that even after coming back to this page in a week you will still find it!
 
 Now look at this drawing, here's Naples with all its beautiness. You can see the famous volcano [Vesuvius](glossary://Vesuvius) together with the [Gulf of Naples](glossary://Gulf) and the rest of the city.
 - - -
 When you're done with looking at the drawing, send the correct message among the ones suggested to see your pizza being put on the windowsill.
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
            page.assessmentStatus = .pass(message: "### Perfect! \nYou enjoyed Naples and are finally ready to eat your wonderful **Pizza \(pizzaName)**! THE END")
            break
        case let .boolean(personalPizza):
            if personalPizza {
                page.assessmentStatus = .pass(message: "### Perfect! \nYou enjoyed Naples and are finally ready to eat your wonderful **Personal New Pizza**! THE END")
            } else {
                page.assessmentStatus = .pass(message: "### Perfect! \nYou did not create a personal pizza, but you enjoyed Naples and are finally ready to eat your wonderful.. empy pizza! THE END")
            }
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
