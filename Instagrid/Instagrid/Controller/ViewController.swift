//
//  ViewController.swift
//  Instagrid
//
//  Created by Paschal on 27/09/18.
//  Copyright © 2018 nasch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    func makeButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        return button
    }
    
    @IBOutlet weak var squareStackView: UIStackView!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var bottomStackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @objc func resetLayout() {
        squareStackView.axis = .vertical
        topStackView.axis = .horizontal
        bottomStackView.axis = .horizontal
        
        for view in topStackView.subviews {
            view.removeFromSuperview()
        }
        
        for view in bottomStackView.subviews {
            view.removeFromSuperview()
        }
    }
    @IBAction func layout1x2(_ sender: Any) {
        resetLayout()
        topStackView.addArrangedSubview(makeButton())
        bottomStackView.addArrangedSubview(makeButton())
        bottomStackView.addArrangedSubview(makeButton())
    }
    @IBAction func layout2x1(_ sender: Any) {
        resetLayout()
        topStackView.addArrangedSubview(makeButton())
        topStackView.addArrangedSubview(makeButton())
        bottomStackView.addArrangedSubview(makeButton())
    }
    @IBAction func layoutLeft1x2(_ sender: Any) {
        resetLayout()
        squareStackView.axis = .horizontal
        topStackView.axis = .vertical
        bottomStackView.axis = .vertical
        topStackView.addArrangedSubview(makeButton())
        bottomStackView.addArrangedSubview(makeButton())
        bottomStackView.addArrangedSubview(makeButton())
    }
    @IBAction func layout2x2(_ sender: Any) {
        resetLayout()
        topStackView.addArrangedSubview(makeButton())
        topStackView.addArrangedSubview(makeButton())
        bottomStackView.addArrangedSubview(makeButton())
        bottomStackView.addArrangedSubview(makeButton())
    }
}

