//
//  PizzaMenuCollectionViewCell.swift
//  MeetNaples
//
//  Created by Antonio Chiappetta on 28/03/2018.
//  Copyright © 2018 Antonio Chiappetta. All rights reserved.
//

import UIKit

public class PizzaMenuCollectionViewCell: UICollectionViewCell {
    
    var pizzaImageView: UIImageView!
    var pizzaTitleLabel: UILabel!
    var nameLabel: UILabel!
    
    public func configure(productName: String) {
        self.pizzaImageView = UIImageView()
        self.pizzaImageView.translatesAutoresizingMaskIntoConstraints = false
        self.pizzaImageView.image = UIImage(named: productName)
        
        self.nameLabel = UILabel()
        self.nameLabel.font = UIFont(name: Constants.Font.Bold.Name, size: Constants.Font.Bold.Size)
        self.nameLabel.textColor = UIColor.white
        self.nameLabel.textAlignment = .center
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let nameArray = productName.components(separatedBy: "_")
        var nameArrayWithoutPizza: [String] = []
        for component in nameArray {
            if component != Constants.PizzaString {
                nameArrayWithoutPizza.append(component)
            }
        }
        let nameWithSpaces = nameArrayWithoutPizza.joined(separator: " ")
        self.nameLabel?.text = nameWithSpaces
        
        
        self.pizzaTitleLabel = UILabel()
        self.pizzaTitleLabel.font = UIFont(name: Constants.Font.Black.Name, size: Constants.Font.Black.Size)
        self.pizzaTitleLabel.textColor = UIColor.white
        self.pizzaTitleLabel.textAlignment = .center
        self.pizzaTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.pizzaTitleLabel.text = Constants.PizzaString
    }
    
    // MARK: UICollectionViewCell
    
    override public func layoutSubviews() {
        
        self.backgroundView = UIImageView(image: UIImage(named: Constants.MenuCardImage))
        
        pizzaImageView!.contentMode = .scaleAspectFill
        self.backgroundView?.addSubview(self.pizzaImageView)
        
        let pizzaViewToCellLeading = NSLayoutConstraint(item: pizzaImageView, attribute: .leading, relatedBy: .equal, toItem: self.backgroundView!, attribute: .leading, multiplier: 1.0, constant: 20)
        let pizzaViewToCellTrailing = NSLayoutConstraint(item: self.backgroundView!, attribute: .trailing, relatedBy: .equal, toItem: pizzaImageView, attribute: .trailing, multiplier: 1.0, constant: 20)
        let pizzaViewToCellTop = NSLayoutConstraint(item: pizzaImageView, attribute: .top, relatedBy: .equal, toItem: self.backgroundView!, attribute: .top, multiplier: 1.0, constant: 20)
        let pizzaViewAspectRatio = NSLayoutConstraint(item: pizzaImageView, attribute: .height, relatedBy: .equal, toItem: pizzaImageView, attribute: .width, multiplier: 1.0, constant: 0)
        self.backgroundView?.addConstraints([pizzaViewToCellLeading, pizzaViewToCellTrailing, pizzaViewToCellTop, pizzaViewAspectRatio])
        
        self.backgroundView?.addSubview(self.pizzaTitleLabel)
        self.backgroundView?.addSubview(self.nameLabel)
        
        let pizzaTitleLabelToBackgroundViewWidth = NSLayoutConstraint(item: pizzaTitleLabel, attribute: .width, relatedBy: .equal, toItem: self.backgroundView!, attribute: .width, multiplier: 154/170, constant: 0)
        let pizzaTitleLabelToBackgroundViewHorizontalAlignment = NSLayoutConstraint(item: pizzaTitleLabel, attribute: .centerX, relatedBy: .equal, toItem: self.backgroundView!, attribute: .centerX, multiplier: 1.0, constant: 0)
        let pizzaTitleLabelToBackgroundViewBottom = NSLayoutConstraint(item: pizzaTitleLabel, attribute: .bottom, relatedBy: .equal, toItem: self.backgroundView!, attribute: .bottom, multiplier: 213.5/255, constant: 0)
        let pizzaTitleLabelToBackgroundViewHeight = NSLayoutConstraint(item: pizzaTitleLabel, attribute: .height, relatedBy: .equal, toItem: self.backgroundView!, attribute: .height, multiplier: 33.5/255, constant: 0)
        self.backgroundView?.addConstraints([pizzaTitleLabelToBackgroundViewWidth, pizzaTitleLabelToBackgroundViewHorizontalAlignment, pizzaTitleLabelToBackgroundViewBottom, pizzaTitleLabelToBackgroundViewHeight])
        
        let nameLabelToBackgroundViewWidth = NSLayoutConstraint(item: nameLabel, attribute: .width, relatedBy: .equal, toItem: self.backgroundView!, attribute: .width, multiplier: 154/170, constant: 0)
        let nameLabelToBackgroundViewHorizontalAlignment = NSLayoutConstraint(item: nameLabel, attribute: .centerX, relatedBy: .equal, toItem: self.backgroundView!, attribute: .centerX, multiplier: 1.0, constant: 0)
        let nameLabelToBackgroundViewBottom = NSLayoutConstraint(item: nameLabel, attribute: .bottom, relatedBy: .equal, toItem: self.backgroundView!, attribute: .bottom, multiplier: 247/255, constant: 0)
        let nameLabelToPizzaTitleLabelHeight = NSLayoutConstraint(item: self.nameLabel, attribute: .height, relatedBy: .equal, toItem: pizzaTitleLabel, attribute: .height, multiplier: 1.0, constant: 0)
        self.backgroundView?.addConstraints([nameLabelToBackgroundViewWidth, nameLabelToBackgroundViewHorizontalAlignment, nameLabelToBackgroundViewBottom, nameLabelToPizzaTitleLabelHeight])
        
        self.layer.cornerRadius = 15
    }
    
    // Apply custom layout properties, in this case anchor point
    override public func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let circularLayoutAttributes = layoutAttributes as! PizzaMenuCollectionViewLayoutAttributes
        self.layer.anchorPoint = circularLayoutAttributes.anchorPoint
        self.center.y += (circularLayoutAttributes.anchorPoint.y - 0.5) * self.bounds.height
    }
    
    // MARK: Private implementation
    
    private struct Constants {
        static let PizzaString = "Pizza"
        struct Font {
            struct Bold {
                static let Name = "SnellRoundhand-Bold"
                static let Size: CGFloat = 16
            }
            struct Black {
                static let Name = "SnellRoundhand-Black"
                static let Size: CGFloat = 24
            }
        }
        static let MenuCardImage = "MenuCard"
    }
    
}
