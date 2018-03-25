//
//  NaplesViewController.swift
//  MeetNaples
//
//  Created by Antonio Chiappetta on 16/03/2017.
//  Copyright © 2017 Antonio Chiappetta. All rights reserved.
//

import UIKit

@objc(DetailsViewController)
public class DetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: Public API
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var firstCollectionView: UICollectionView!
    @IBOutlet weak var secondCollectionView: UICollectionView!
    @IBOutlet weak var thirdCollectionView: UICollectionView!
    @IBOutlet weak var fourthCollectionView: UICollectionView!
    @IBOutlet weak var backgroundView: UIImageView!
    
    var itemToSee: ItemToSee = .Empty
    
    let vesuviusPictures: [String] = Constants.VesuviusPictures
    let cityPictures: [String] = Constants.CityPictures
    let seaPictures: [String] = Constants.SeaPictures
    
    // Used to let each collection views start from another indexPath
    var moveIndexPath = 1
    
    public enum ItemToSee {
        case Vesuvius
        case City
        case Sea
        case Empty
    }
    
    public struct Constants {
        static let DetailsCellIdentifier = "detailsCollectionViewCell"
        static let VesuviusPictures = ["Vesuvius1", "Vesuvius2", "Vesuvius3", "Vesuvius4", "Vesuvius5", "Vesuvius6", "Vesuvius7", "Vesuvius8", "Vesuvius9", "Vesuvius10", "Vesuvius11", "Vesuvius12", "Vesuvius13", "Vesuvius14", "Vesuvius15", "Vesuvius16"]
        static let CityPictures = ["City1", "City2", "City3", "City4", "City5", "City6", "City7", "City8", "City9", "City10", "City11", "City12", "City13", "City14", "City15", "City16"]
        static let SeaPictures = ["Sea1", "Sea2", "Sea3", "Sea4", "Sea5", "Sea6", "Sea7", "Sea8", "Sea9", "Sea10", "Sea11", "Sea12", "Sea13", "Sea14", "Sea15", "Sea16"]
        static let StoryboardIdentifier = "Details"
    }
    
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: ViewController Lifecycle
    
    override public func viewDidLoad() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(close))
        self.backgroundView.addGestureRecognizer(tap)
        
        super.viewDidLoad()
        firstCollectionView.dataSource = self
        firstCollectionView.delegate = self
        firstCollectionView.register(DetailsCollectionViewCell.self, forCellWithReuseIdentifier: Constants.DetailsCellIdentifier)
        secondCollectionView.dataSource = self
        secondCollectionView.delegate = self
        secondCollectionView.register(DetailsCollectionViewCell.self, forCellWithReuseIdentifier: Constants.DetailsCellIdentifier)
        thirdCollectionView.dataSource = self
        thirdCollectionView.delegate = self
        thirdCollectionView.register(DetailsCollectionViewCell.self, forCellWithReuseIdentifier: Constants.DetailsCellIdentifier)
        fourthCollectionView.dataSource = self
        fourthCollectionView.delegate = self
        fourthCollectionView.register(DetailsCollectionViewCell.self, forCellWithReuseIdentifier: Constants.DetailsCellIdentifier)
        
        switch itemToSee {
        case .Vesuvius:
            titleLabel.text = "Vesuvius"
            descriptionLabel.text = "Mount Vesuvius is best known for its eruption in AD 79 that led to the burying and destruction of the Roman cities of Pompeii and Herculaneum, as well as several other settlements. The eruption ejected a cloud of stones, ashes and volcanic gases to a height of 33 km (21 mi), spewing molten rock and pulverized pumice at the rate of 6×105 cubic metres (7.8×105 cu yd) per second, ultimately releasing a hundred thousand times the thermal energy released by the Hiroshima-Nagasaki bombings. More than 1,000 people died in the eruption, but exact numbers are unknown. The only surviving eyewitness account of the event consists of two letters by Pliny the Younger to the historian Tacitus."
            self.backgroundView.image = UIImage(named: "BackgroundGreen")
        case .City:
            titleLabel.text = "City"
            descriptionLabel.text = "Naples is one of the oldest continuously inhabited cities in the world. Bronze Age Greek settlements were established in the Naples area in the second millennium BC. A larger colony – initially known as Parthenope, Παρθενόπη – developed on the Island of Megaride around the ninth century BC, at the end of the Greek Dark Ages. The city was refounded[by whom?] as Neápolis in the sixth century BC and became a lynchpin of Magna Graecia, playing a key role in the merging of Greek culture into Roman society and eventually becoming a cultural centre of the Roman Republic. Naples remained influential after the fall of the Western Roman Empire, serving as the capital city of the Kingdom of Naples between 1282 and 1816. Thereafter, in union with Sicily, it became the capital of the Two Sicilies until the unification of Italy in 1861."
            self.backgroundView.image = UIImage(named: "BackgroundOrange")
        case .Sea:
            titleLabel.text = "Sea"
            descriptionLabel.text = "The Gulf of Naples (Italian: Golfo di Napoli; Neapolitan: Gurfo 'e Napule; Latin: Crater), also called the Bay of Naples, is a roughly 15-kilometer-wide (9.3 mi) gulf located along the south-western coast of Italy (province of Naples, Campania region). It opens to the west into the Mediterranean Sea. It is bordered on the north by the cities of Naples and Pozzuoli, on the east by Mount Vesuvius, and on the south by the Sorrentine Peninsula and the main town of the peninsula, Sorrento. The Peninsula separates the Gulf of Naples from the Gulf of Salerno, which includes the Amalfi coast."
            self.backgroundView.image = UIImage(named: "BackgroundBlue")
        default:
            break
        }
    }
    
    // MARK: UICollectionView DataSource
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch itemToSee {
        case .Vesuvius:
            return Int(floor(Double(Constants.VesuviusPictures.count)/4.0))
        case .City:
            return Int(floor(Double(Constants.CityPictures.count)/4.0))
        case .Sea:
            return Int(floor(Double(Constants.SeaPictures.count)/4.0))
        default:
            break
        }
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let aCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.DetailsCellIdentifier, for: indexPath) as! DetailsCollectionViewCell
        
        var newRowIndex = 0
        let numberOfRows = firstCollectionView.numberOfItems(inSection: 0)
        
        switch collectionView {
        case firstCollectionView:
            newRowIndex = indexPath.row
        case secondCollectionView:
            newRowIndex = indexPath.row + numberOfRows
        case thirdCollectionView:
            newRowIndex = indexPath.row + (numberOfRows * 2)
        case fourthCollectionView:
            newRowIndex = indexPath.row + (numberOfRows * 3)
        default:
            break
        }
        
        
        switch itemToSee {
        case .Vesuvius:
            aCell.configure(itemName: vesuviusPictures[newRowIndex], backgroundColor: UIColor.yellow)
        case .City:
            aCell.configure(itemName: cityPictures[newRowIndex], backgroundColor: UIColor.blue)
        case .Sea:
            aCell.configure(itemName: seaPictures[newRowIndex], backgroundColor: UIColor.green)
        default:
            break
        }
        return aCell
    }
    
}

extension DetailsViewController {
    public class func initWithStoryboard() -> DetailsViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let detailsViewController = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier) as! DetailsViewController
        return detailsViewController
    }
}
