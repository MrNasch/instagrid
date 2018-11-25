//
//  ViewController.swift
//  Instagrid
//
//  Created by Paschal on 27/09/18.
//  Copyright © 2018 nasch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    func makeButton(images: UIImage) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.setImage(images, for: .normal)
        return button
    }
    
    @IBOutlet weak var swipeTextLabel: UILabel!
    @IBOutlet weak var squareStackView: UIStackView!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var bottomStackView: UIStackView!
    let layoutManager = LayoutManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        layout2x1(self)
    }
    func makeGridLayout() {
        resetLayout()
        let firstLine = layoutManager.imagesGrid[0]
        let secondLine = layoutManager.imagesGrid[1]
        
        for images in firstLine {
            topStackView.addArrangedSubview(makeButton(images: images))
        }
        for images in secondLine {
            bottomStackView.addArrangedSubview(makeButton(images: images))
        }
    }
    @objc func resetLayout() {
        if layoutManager.type == .layoutLeft1x2 {
            squareStackView.axis = .horizontal
            topStackView.axis = .vertical
            bottomStackView.axis = .vertical
        } else {
            squareStackView.axis = .vertical
            topStackView.axis = .horizontal
            bottomStackView.axis = .horizontal
        }
        for view in topStackView.subviews {
            view.removeFromSuperview() 
        }
        
        for view in bottomStackView.subviews {
            view.removeFromSuperview()
        }
    }
    @IBAction func layout1x2(_ sender: Any) {
        
        layoutManager.type = .layout1x2
        makeGridLayout()
    }
    @IBAction func layout2x1(_ sender: Any) {
        layoutManager.type = .layout2x1
        makeGridLayout()
    }
    @IBAction func layoutLeft1x2(_ sender: Any) {
        layoutManager.type = .layoutLeft1x2
        makeGridLayout()
    }
    @IBAction func layout2x2(_ sender: Any) {
        layoutManager.type = .layout2x2
        makeGridLayout()
    }
}

