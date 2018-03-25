//
//  NaplesViewController.swift
//  MeetNaples
//
//  Created by Antonio Chiappetta on 16/03/2017.
//  Copyright © 2017 Antonio Chiappetta. All rights reserved.
//

import UIKit
import PlaygroundSupport
import AVFoundation

@objc(NaplesViewController)
public class NaplesViewController: UIViewController {
    
    // MARK: Public API
    
    lazy var pizzaView: PizzaAnimationView? = {
        for subview in self.view.subviews {
            if let pizzaView = subview as? PizzaAnimationView {
                return pizzaView
            }
        }
        return nil
    }()
    
    lazy var statusViewController: StatusViewController = {
        return self.childViewControllers.first! as! StatusViewController
    }()

    let context = CIContext()

    var audioPlayer = AVAudioPlayer()
    var timer = Timer()

    var pizzaNotAnimated = true
    
    func putPizzaOnTheWindowsill() {
        let pizza = self.pizzaView.viewsByName["Pizza"]!
        var perspectiveTransform = CATransform3DIdentity
        perspectiveTransform.m34 = 1.0 / -500
        let translationPerspectiveTransform = CATransform3DTranslate(perspectiveTransform, 0, 335, 0)
        let rotationPerspectiveTransform = CATransform3DRotate(translationPerspectiveTransform, 24.2578 * .pi / 180.0, 1.0, 0.0, 0.0)
        let scalePerspectiveTransform = CATransform3DScale(rotationPerspectiveTransform, 1, 0.25336, 1)
        UIView.animate(withDuration: 2.0, animations: {
            pizza.layer.transform = scalePerspectiveTransform
        }) { (completed) in
            self.pizzaView.isUserInteractionEnabled = true
        }
    }

    func timerAction() {
        timer.invalidate()
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        timer = Timer.scheduledTimer(timeInterval: 164, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }

    func didTouchPizzaView() {
        if pizzaNotAnimated {
            pizzaView.isUserInteractionEnabled = false
            pizzaNotAnimated = false
            animatePizzaFromKeyValueStore()
        } else {
            self.restart()
        }
    }
    
    func restart() {
        UIView.animate(withDuration: 2.0, animations: {
            self.pizzaView.alpha = 0.0
        }) { (completed) in
            self.pizzaView.removeAllAnimations()
            let pizza = self.pizzaView.viewsByName["Pizza"]!
            pizza.layer.transform = CATransform3DIdentity
            self.pizzaNotAnimated = true
        }
    }

    public struct Constants {
        static let StoryboardIdentifier = "Naples"
        static let VesuviusDetailsSegueIdentifier = "VesuviusDetails"
        static let CityDetailsFirstSegueIdentifier = "CityDetailsFirst"
        static let CityDetailsSecondSegueIdentifier = "CityDetailsSecond"
        static let SeaDetailsFirstSegueIdentifier = "SeaDetailsFirst"
        static let SeaDetailsSecondSegueIdentifier = "SeaDetailsSecond"
        static let SeaDetailsThirdSegueIdentifier = "SeaDetailsThird"
    }
    
    // MARK: ViewController Lifecycle
    
    override public func viewDidLoad() {

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTouchPizzaView))
        pizzaView.addGestureRecognizer(tap)

        let audioPath = Bundle.main.path(forResource: "TarantellaNapoletana", ofType: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        }
        catch {
            print("Something bad happened. Try catching specific errors to narrow things down")
        }
        audioPlayer.prepareToPlay()
        audioPlayer.volume = 0.5
        audioPlayer.play()
        timer = Timer.scheduledTimer(timeInterval: 164, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)

        self.pizzaView.alpha = 0.0
    }
    
    // MARK: Navigation
    
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = (segue.identifier)!
        let dest = segue.destination as! DetailsViewController
        switch identifier {
        case Constants.VesuviusDetailsSegueIdentifier:
            dest.itemToSee = .Vesuvius
        case Constants.CityDetailsFirstSegueIdentifier,
             Constants.CityDetailsSecondSegueIdentifier:
            dest.itemToSee = .City
        case Constants.SeaDetailsFirstSegueIdentifier,
             Constants.SeaDetailsSecondSegueIdentifier,
             Constants.SeaDetailsThirdSegueIdentifier:
            dest.itemToSee = .Sea
        default:
            break
        }
    }
    
}

extension NaplesViewController {
    public class func initWithStoryboard() -> NaplesViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let naplesViewController = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier) as! NaplesViewController
        return naplesViewController
    }
}

extension NaplesViewController: PlaygroundLiveViewMessageHandler {
    
    func animatePizzaFromKeyValueStore() {
        UIView.animate(withDuration: 2.0, animations: {
            self.pizzaView.alpha = 1.0
        }) { (completed) in
            let page = PlaygroundPage.current
            if let savedPizza = page.keyValueStore["Pizza"] {
                switch savedPizza {
                case let .array(array):
                    var ingredientsReceived: [Ingredient] = []
                    for ingredientName in array {
                        guard case let .string(ingredientString) = ingredientName else { break }
                        ingredientsReceived.append(Ingredient(rawValue: ingredientString)!)
                    }
                    PizzaAnimationManager.createPizza(pizzaView: self.pizzaView, ingredients: ingredientsReceived, withCompletion: {
                        self.putPizzaOnTheWindowsill()
                        if let message = DefaultPizzas.compare(withPizza: array) {
                            self.send(message)
                        }
                    })
                default:
                    break
                }
            } else {
                PizzaAnimationManager.createPizza(pizzaView: self.pizzaView, ingredients: [Ingredient(rawValue: "Dough")!], withCompletion: {
                    self.putPizzaOnTheWindowsill()
                })
            }
        }
    }

    public func receive(_ message: PlaygroundValue) {

        switch message {
        case let .boolean(animate):
            if animate == true {
                self.pizzaNotAnimated = true
                self.didTouchPizzaView()
            }
        default:
            break
        }
    }
}
