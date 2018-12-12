//
//  LayoutManager.swift
//  Instagrid
//
//  Created by Paschal on 13/11/18.
//  Copyright © 2018 nasch. All rights reserved.
//

import Foundation
import UIKit
// class LayoutManager
class LayoutManager {
    var type = Grid.layout2x1
    var images = [UIImage]()
    
    init()  {
        images = [UIImage(named: "blue cross")!,
                   UIImage(named: "blue cross")!,
                   UIImage(named: "blue cross")!,
                   UIImage(named: "blue cross")!]
        
        
    }
    
    // 2D array of images
    var imagesGrid : [[UIImage]] {
        switch type {
            case .layout1x2, .layoutLeft1x2:
                let firstLine = [images[0]]
                let secondLine = [images[1],images[2]]
                let imagesGrid = [firstLine, secondLine]
                return imagesGrid
            case .layout2x1:
                let firstLine = [images[0],images[1]]
                let secondLine = [images[2]]
                let imagesGrid = [firstLine, secondLine]
                return imagesGrid
            case .layout2x2:
                let firstLine = [images[0],images[1]]
                let secondLine = [images[2],images[3]]
                let imagesGrid = [firstLine, secondLine]
                return imagesGrid
        }
    }
}

// extension of LayoutManager
extension LayoutManager {
    enum Grid {
        case layout1x2
        case layoutLeft1x2
        case layout2x1
        case layout2x2
    }
}
