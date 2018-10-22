//
//  ViewController.swift
//  Instagrid
//
//  Created by Paschal on 27/09/18.
//  Copyright © 2018 nasch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var squareStackView: UIStackView!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var bottomStackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func resetLayout() {
        for view in topStackView.subviews {
            view.removeFromSuperview()
        }
        
        for view in bottomStackView.subviews {
            view.removeFromSuperview()
        }
    }
    
    @IBAction func layout1x2(_ sender: Any) {
        resetLayout()
        self.topStackView.addArrangedSubview(topStackView)
        self.bottomStackView.addArrangedSubview(bottomStackView)
        self.bottomStackView.addArrangedSubview(bottomStackView)
    }
    @IBAction func layout2x1(_ sender: Any) {
        resetLayout()
        self.topStackView.addArrangedSubview(topStackView)
        self.topStackView.addArrangedSubview(topStackView)
        self.bottomStackView.addArrangedSubview(bottomStackView)
    }
    @IBAction func layoutLeft1x2(_ sender: Any) {
        resetLayout()
        self.topStackView.addArrangedSubview(topStackView)
        self.bottomStackView.addArrangedSubview(bottomStackView)
        self.bottomStackView.addArrangedSubview(bottomStackView)
    }
    @IBAction func layout2x2(_ sender: Any) {
        resetLayout()
        self.topStackView.addArrangedSubview(topStackView)
        self.topStackView.addArrangedSubview(topStackView)
        self.bottomStackView.addArrangedSubview(bottomStackView)
        self.bottomStackView.addArrangedSubview(bottomStackView)
    }
}

