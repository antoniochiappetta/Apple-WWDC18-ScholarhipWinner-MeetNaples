//
//  MakePizzaViewController.swift
//  MeetNaples
//
//  Created by Antonio Chiappetta on 16/03/2017.
//  Copyright © 2017 Antonio Chiappetta. All rights reserved.
//

import UIKit
import PlaygroundSupport
import AVFoundation

@objc(MakePizzaViewController)
public class MakePizzaViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var pizzaView: PizzaAnimationView!
    
    lazy var statusViewController: StatusViewController = {
        return childViewControllers.lazy.flatMap({$0 as? StatusViewController}).first!
    }()
    
    override public func viewDidLoad() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(restart))
        view.addGestureRecognizer(tap)
        self.statusViewController.show(message: "This is not a pizza in the menu, try a Margherita (sauce, mozzarella, basil)")
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
                }
            })
        default:
            break
        }
    }
}

