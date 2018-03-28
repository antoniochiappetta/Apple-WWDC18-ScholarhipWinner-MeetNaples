//#-hidden-code
//  Contents.swift
//  MeetNaples
//
//  Created by Antonio Chiappetta on 28/03/2018.
//  Copyright © 2018 Antonio Chiappetta. All rights reserved.
//
//#-end-hidden-code
/*:
 # Welcome in Naples!
 
 Learn about this wonderful city starting from its most famous product: [pizza](glossary://Pizza).
 This book will guide you through the process of learning which ingredients are needed to make the most famous types of pizza.
 
 ![Pizza](MiniPizzaMargherita.png)
 - - -
 1. First of all, to enable the animations on each pizza and start learning, tap on *Run my code*.
 2. Then turn the wheel of the menu to choose the pizza you want to know about.
 3. Once chosen one, click on it to **learn** which ingredients are needed to make it.
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
                page.assessmentStatus = .pass(message: "### Perfect! \nYou learnt which ingredients are needed for a good pizza, go ahead and create yours! \n\n[**Next page**](@next)")
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

