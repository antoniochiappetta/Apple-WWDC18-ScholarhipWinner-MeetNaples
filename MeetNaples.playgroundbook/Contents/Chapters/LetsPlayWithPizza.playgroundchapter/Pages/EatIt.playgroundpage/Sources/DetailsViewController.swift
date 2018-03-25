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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var firstCollectionView: UICollectionView!
    @IBOutlet weak var secondCollectionView: UICollectionView!
    @IBOutlet weak var thirdCollectionView: UICollectionView!
    @IBOutlet weak var fourthCollectionView: UICollectionView!
    
    var itemToSee: ItemToSee = .Empty
    
    public struct Constants {
        static let StoryboardIdentifier = "Details"
    }
    
    public enum ItemToSee {
        case Vesuvius
        case City
        case Islands
        case Empty
    }
    
    // MARK: ViewController Lifecycle
    
    override public func viewDidLoad() {
        

    }
    
}

extension DetailsViewController {
    public class func initWithStoryboard() -> DetailsViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let detailsViewController = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier) as! NaplesViewController
        return detailsViewController
    }
}
