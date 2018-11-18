//
//  LayoutManager.swift
//  Instagrid
//
//  Created by Paschal on 13/11/18.
//  Copyright © 2018 nasch. All rights reserved.
//

import Foundation
import UIKit

class LayoutManager {
    var type = .layout1x2()
    var images = [UIImage]()
    
    init()  {
        images = [UIImage(named: "blue cross")!,
                   UIImage(named: "blue cross")!,
                   UIImage(named: "blue cross")!,
                   UIImage(named: "blue cross")!]
        
        switch type {
        case .layout1x2, .layoutLeft1x2: break
            
        case .layout2x1: break
            
        case .layout2x2: break
            
        }
    }
    
}

extension LayoutManager {
    enum Grid {
        case layout1x2
        case layoutLeft1x2
        case layout2x1
        case layout2x2
    }
    
    
    func makeGridLayout(_ sender: LayoutManager) {
        var firstline = [images[0],images[1]]
        var secondline = [images[2],images[3]]
        var imagesGrid = [[firstline], [secondline]]
        return imagesGrid
    }
}
