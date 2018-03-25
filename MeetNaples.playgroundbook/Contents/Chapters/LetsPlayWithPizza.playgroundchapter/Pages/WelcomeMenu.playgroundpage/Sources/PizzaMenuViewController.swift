//
//  PizzaCatalogueViewController.swift
//  TestForWWDC
//
//  Created by Antonio Chiappetta on 24/03/2017.
//  Copyright © 2017 Antonio Chiappetta. All rights reserved.
//

import UIKit
import PlaygroundSupport

@objc(PizzaMenuViewController)
public class PizzaMenuViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
    // MARK: Public API
    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var pizzaView: PizzaAnimationView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableImageView: UIImageView!
    @IBOutlet weak var pizzaViewToBackgroundViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionViewToBackgroundViewBottom: NSLayoutConstraint!
    
    let pizzas: [String] = Constants.PizzasArray
    
    lazy var statusViewController: StatusViewController = {
        return childViewControllers.lazy.flatMap({$0 as? StatusViewController}).first!
    }()
    
    // MARK: ViewController Lifecycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PizzaMenuCollectionViewCell.self, forCellWithReuseIdentifier: Constants.PizzaCellIdentifier)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(remindUser))
        collectionView.addGestureRecognizer(tap)
    }
    
    override public func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        for cell in self.collectionView.visibleCells {
            let aCell = cell as! PizzaMenuCollectionViewCell
            let currentRatio =  self.view.frame.height / Constants.ConsideredHeight
            aCell.nameLabel.font = self.adaptedSizeFont(label: aCell.nameLabel, initialSize: Constants.Font.Bold.Size, ratio: currentRatio)
            aCell.pizzaTitleLabel.font = self.adaptedSizeFont(label: aCell.pizzaTitleLabel, initialSize: Constants.Font.Black.Size, ratio: currentRatio)
        }
        if self.view.frame.width > self.view.frame.height {
            self.tableImageView.image = UIImage(named: "MenuTableLandscape")
        } else {
            self.tableImageView.image = UIImage(named: "MenuTablePortrait")
        }
    }
    
    // MARK: UICollectionView DataSource
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pizzas.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let aCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.PizzaCellIdentifier, for: indexPath) as! PizzaMenuCollectionViewCell
        aCell.configure(productName: pizzas[indexPath.row])
        return aCell
    }
    
    // MARK: UIScrollView Delegate
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        pizzaView.removeAllAnimations()
    }
    
    // MARK: Private implementation
    
    public struct Constants {
        static let PizzaCellNibName = "PizzaMenuCollectionViewCell"
        static let PizzaCellIdentifier = "pizzaMenuCollectionViewCell"
        static let PizzasArray = ["Pizza_Margherita", "Pizza_Marinara", "Pizza_Napoletana", "Pizza_Romana", "Pizza_Siciliana", "Pizza_Diavola", "Pizza_Wurstel_E_Patatine", "Pizza_Mimosa", "Pizza_Tonno_E_Cipolla", "Pizza_Ortolana", "Pizza_Primavera", "Pizza_Quattro_Stagioni", "Pizza_Capricciosa", "Pizza_Quattro_Formaggi"]
        static let StoryboardIdentifier = "PizzaMenu"
        static let ConsideredHeight: CGFloat = 768.0
        struct Font {
            struct Bold {
                static let Size: CGFloat = 16
            }
            struct Black {
                static let Size: CGFloat = 24
            }
        }
    }
    
    private func adaptedSizeFont(label: UILabel, initialSize: CGFloat, ratio: CGFloat) -> UIFont {
        let newFont = label.font.withSize(initialSize * ratio)
        return newFont
    }
    
}

extension PizzaMenuViewController {
    public class func initWithStoryboard() -> PizzaMenuViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let pizzaMenuViewController = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier) as! PizzaMenuViewController
        return pizzaMenuViewController
    }
}

extension PizzaMenuViewController: PlaygroundLiveViewMessageHandler {
    
    @objc public func animatePizza() {
        self.pizzaView.removeAllAnimations()
        self.collectionView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 2.0, animations: {
            let backgroundViewHeight = self.backgroundView.bounds.height
            self.pizzaViewToBackgroundViewHeight.constant = backgroundViewHeight/5
            self.collectionViewToBackgroundViewBottom.constant = backgroundViewHeight/5
            self.view.layoutIfNeeded()
        }) { (completed) in
            let xOrigin = self.collectionView.bounds.midX - 1
            let dx: CGFloat = 2
            let yOrigin = self.collectionView.bounds.midY - 1
            let dy: CGFloat = 2
            let rect = CGRect(x: xOrigin, y: yOrigin, width: dx, height: dy)
            let cell = self.collectionView.visibleCells.filter { (cell) -> Bool in
                return rect.intersects(cell.frame)
                }.first! as! PizzaMenuCollectionViewCell
            let pizzaName = cell.nameLabel.text!
            PizzaAnimationManager.createPizza(pizzaView: self.pizzaView, pizzaName: pizzaName, withCompletion: {
                UIView.animate(withDuration: 2.0, animations: {
                    self.pizzaViewToBackgroundViewHeight.constant = 0
                    self.collectionViewToBackgroundViewBottom.constant = 0
                    self.view.layoutIfNeeded()
                }, completion: { (completed) in
                    self.collectionView.isUserInteractionEnabled = true
                    let message: PlaygroundValue = .boolean(true)
                    self.send(message)
                    self.statusViewController.show(message: "+1 pizza learned")
                })
            })
        }
        
    }
    
    @objc public func remindUser() {
        self.statusViewController.show(message: "Tap on Run My Code to start learning")
    }
    
    public func receive(_ message: PlaygroundValue) {
        
        switch message {
        default:
            let previousTap = UITapGestureRecognizer(target: self, action: #selector(remindUser))
            collectionView.removeGestureRecognizer(previousTap)
            // Block tap interaction before the user taps on run my code
            let tap = UITapGestureRecognizer(target: self, action: #selector(animatePizza))
            collectionView.addGestureRecognizer(tap)
            break
        }
    }
    
}
