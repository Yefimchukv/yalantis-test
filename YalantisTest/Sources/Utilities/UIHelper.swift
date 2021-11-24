//
//  UIHelper.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 24.11.2021.
//

import UIKit

struct UIHelper {
    static func createSingleColumnFlowLayout(in view: UIView) -> UICollectionViewLayout {
        let width = view.bounds.width
        
        let padding: CGFloat = 16
        let minimumItemSpacing: CGFloat = 14
        
        let availableWidth = (width - (padding * 2)) / 1.2
        let availableHeight: CGFloat = (296 - (padding * 2) - (minimumItemSpacing * 2))
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: availableWidth, height: availableHeight)
        
        flowLayout.collectionView?.center = view.center
        
        return flowLayout
    }
}
