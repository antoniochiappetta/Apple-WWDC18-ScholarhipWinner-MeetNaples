//
//  MakePizzaViewController.swift
//  MeetNaples
//
//  Created by Antonio Chiappetta on 28/03/2018.
//  Copyright © 2018 Antonio Chiappetta. All rights reserved.
//

import UIKit
import PlaygroundSupport
import AVFoundation

@objc(MakePizzaViewController)
public class MakePizzaViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var pizzaView: PizzaAnimationView!
    
    lazy var statusViewController: StatusViewController = {
        return self.childViewControllers.first! as! StatusViewController
    }()
    
    override public func viewDidLoad() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(restart))
        view.addGestureRecognizer(tap)
    }
    
    public struct Constants {
        static let StoryboardIdentifier = "MakePizza"
    }
    
    @objc func restart() {
        pizzaView.removeAllAnimations()
    }
    
}

extension MakePizzaViewController {
    public class func initWithStoryboard() -> MakePizzaViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let makePizzaViewController = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier) as! MakePizzaViewController
        return makePizzaViewController
    }
}

extension MakePizzaViewController: PlaygroundLiveViewMessageHandler {
    
    public func receive(_ message: PlaygroundValue) {
        
        switch message {
        case let .array(array):
            var ingredientsReceived: [Ingredient] = []
            for ingredientName in array {
                guard case let .string(ingredientString) = ingredientName else { break }
                ingredientsReceived.append(Ingredient(rawValue: ingredientString)!)
            }
            self.restart()
            PizzaAnimationManager.createPizza(pizzaView: self.pizzaView, ingredients: ingredientsReceived, withCompletion: {
                if let message = DefaultPizzas.compare(withPizza: array) {
                    self.send(message)
                } else {
                    let newPizza: PlaygroundValue = PlaygroundValue.boolean(true)
                    self.send(newPizza)
                }
            })
        default:
            break
        }
    }
}

