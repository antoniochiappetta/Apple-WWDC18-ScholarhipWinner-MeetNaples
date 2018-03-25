//
//  PizzaMenuCollectionViewLayout.swift
//  TestForWWDC
//
//  Created by Antonio Chiappetta on 25/03/2017.
//  Copyright © 2017 Antonio Chiappetta. All rights reserved.
//

import UIKit

@objc(PizzaMenuCollectionViewLayoutAttributes)
public class PizzaMenuCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    
    // MARK: Public API
    
    // The anchor point will be different from the center
    public var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    
    // The angular position of cells
    public var angle: CGFloat = 0 {
        didSet {
            // zIndex set differently for each cell to let the one on the right overlap the one on the left
            zIndex = Int(angle * 1000000)
            // Transform set to the rotation angle to apply
            transform = CGAffineTransform(rotationAngle: angle)
        }
    }
    
    // MARK: NSCopying Protocol
    
    // Overriden to guarantee that both anchor point and angle are set when internally copying the object because the collection view is performing a layout
    override public func copy(with zone: NSZone? = nil) -> Any {
        let copiedAttributes: PizzaMenuCollectionViewLayoutAttributes = super.copy(with: zone) as! PizzaMenuCollectionViewLayoutAttributes
        copiedAttributes.anchorPoint = self.anchorPoint
        copiedAttributes.angle = self.angle
        return copiedAttributes
    }
    
    
}

@objc(PizzaMenuCollectionViewLayout)
public class PizzaMenuCollectionViewLayout: UICollectionViewLayout {
    
    // MARK: Public API
    
    public var angleAtExtreme: CGFloat {
        return collectionView!.numberOfItems(inSection: 0) > 0 ?
            -CGFloat(collectionView!.numberOfItems(inSection: 0) - 1) * anglePerItem : 0
    }
    
    public var angle: CGFloat {
        return angleAtExtreme * collectionView!.contentOffset.x / (collectionViewContentSize.width - collectionView!.bounds.width)
    }
    
    public var itemSize: CGSize {
        let ratio = collectionView!.bounds.width / collectionView!.bounds.height
        let width = collectionView!.bounds.width/4 * (1.5 / ratio)
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
    
    public var radius: CGFloat {
        get {
            return collectionView!.bounds.width
        }
    }
    
    // The angle between each cell, this formula ensures they aren't spread too far apart
    public var anglePerItem: CGFloat {
        return atan(itemSize.width / radius * 1.5)
    }
    
    public var attributesList = [PizzaMenuCollectionViewLayoutAttributes]()
    
    // MARK: UICollectionViewLayout
    
    // Same height of the collection view, but greater width
    override public var collectionViewContentSize: CGSize {
        return CGSize(width: CGFloat(collectionView!.numberOfItems(inSection: 0)) * itemSize.width, height: collectionView!.bounds.height)
    }
    
    override public class var layoutAttributesClass: AnyClass {
        return PizzaMenuCollectionViewLayoutAttributes.self
    }
    
    override public func prepare() {
        super.prepare()
        // Determine the y value of the anchor point that has to be outside of the item to make them rotate around a circle
        let anchorPointY = (self.radius + self.itemSize.height / 2) / self.itemSize.height
        // Determine the center of the collection view according to the current horizontal offset
        let centerX = collectionView!.contentOffset.x + collectionView!.bounds.width / 2
        // For each item in section 0 determine the list of attributes
        attributesList = (0..<collectionView!.numberOfItems(inSection: 0)).map({ (i) -> PizzaMenuCollectionViewLayoutAttributes in
            // Create an instance of the attributes class for each index path, and then set the item's size, center, anchor point and rotation angle
            let attributes = PizzaMenuCollectionViewLayoutAttributes(forCellWith: IndexPath(item: i, section: 0))
            attributes.size = self.itemSize
            attributes.center = CGPoint(x: centerX, y: collectionView!.bounds.midY)
            attributes.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)
            attributes.angle = self.angle + self.anglePerItem * CGFloat(i)
            return attributes
        })
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // Check whether the frame of the layout attributes intersects with the given rect, this would result in the collection view only drawing those items that should be on-screen, or which are about to come on screen
        return attributesList.filter({ (currentLayoutAttributes) -> Bool in
            return rect.intersects(currentLayoutAttributes.frame)
        })
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesList[indexPath.row]
    }
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        // Re-evaluate the layout as the collection view scrolls
        return true
    }
    
    // Snapping behaviour
    override public func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var finalContentOffset = proposedContentOffset
        let factor = -angleAtExtreme/(collectionViewContentSize.width -
            collectionView!.bounds.width)
        let proposedAngle = proposedContentOffset.x*factor
        let ratio = proposedAngle/anglePerItem
        var multiplier: CGFloat
        if (velocity.x > 0) {
            multiplier = ceil(ratio)
        } else if (velocity.x < 0) {
            multiplier = floor(ratio)
        } else {
            multiplier = round(ratio)
        }
        finalContentOffset.x = multiplier*anglePerItem/factor
        return finalContentOffset
    }
    
}
