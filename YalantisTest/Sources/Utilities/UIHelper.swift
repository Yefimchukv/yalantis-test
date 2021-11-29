//
//  UIHelper.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 24.11.2021.
//

import UIKit

struct UIHelper {
    static func createSingleColumnCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { _, environment in
            
            let width = environment.container.contentSize.width
            
            let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .absolute(280))
            
            let item = NSCollectionLayoutItem(layoutSize: size)
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: width/7, bottom: 8, trailing: width/7)
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
        
        return layout
    }
}
