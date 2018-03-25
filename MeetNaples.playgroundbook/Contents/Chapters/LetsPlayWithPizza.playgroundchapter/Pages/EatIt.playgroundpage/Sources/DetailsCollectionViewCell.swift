//
//  DetailsCollectionViewCell.swift
//  TestForWWDC
//
//  Created by Antonio Chiappetta on 01/04/2017.
//  Copyright © 2017 Antonio Chiappetta. All rights reserved.
//

import UIKit

public class DetailsCollectionViewCell: UICollectionViewCell {
    
    var itemImageView: UIImageView!
    
    public func configure(itemName: String, backgroundColor: UIColor) {
        self.itemImageView = UIImageView()
        self.itemImageView.translatesAutoresizingMaskIntoConstraints = false
        self.itemImageView.image = UIImage(named: itemName)
        
        self.backgroundColor = backgroundColor
    }
    
    // MARK: UICollectionViewCell
    
    override public func layoutSubviews() {
        
        self.backgroundView = UIImageView()
        self.backgroundView!.backgroundColor = UIColor.clear
        
        self.backgroundView?.addSubview(self.itemImageView)
        
        let itemImageViewToBackgroundViewWidth = NSLayoutConstraint(item: self.itemImageView, attribute: .width, relatedBy: .equal, toItem: self.backgroundView!, attribute: .width, multiplier: 8/9, constant: 0)
        let itemImageViewToBackgroundViewHorizontalAlignment = NSLayoutConstraint(item: self.itemImageView, attribute: .centerX, relatedBy: .equal, toItem: self.backgroundView!, attribute: .centerX, multiplier: 1.0, constant: 0)
        let itemImageViewToBackgroundViewHeight = NSLayoutConstraint(item: self.itemImageView, attribute: .height, relatedBy: .equal, toItem: self.backgroundView!, attribute: .height, multiplier: 8/9, constant: 0)
        let itemImageViewToBackgroundViewVerticalAlignment = NSLayoutConstraint(item: self.itemImageView, attribute: .centerY, relatedBy: .equal, toItem: self.backgroundView!, attribute: .centerY, multiplier: 1.0, constant: 0)
        self.backgroundView?.addConstraints([itemImageViewToBackgroundViewWidth, itemImageViewToBackgroundViewHorizontalAlignment, itemImageViewToBackgroundViewHeight, itemImageViewToBackgroundViewVerticalAlignment])
        
    }
    
    // Apply custom layout properties, in this case anchor point
    override public func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let detailsLayoutAttributes = layoutAttributes as! DetailsCollectionViewLayoutAttributes
        self.layer.anchorPoint = detailsLayoutAttributes.anchorPoint
        self.center.y += (detailsLayoutAttributes.anchorPoint.y - 0.5) * self.bounds.height
    }
    
}
