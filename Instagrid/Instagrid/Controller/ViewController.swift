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
        button.frame = CGRect(x: self.view.frame.size.width - 60, y: 60, width: 50, height: 50)
        button.backgroundColor = UIColor.red
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(resetLayout), for: .touchUpInside)
        self.view.addSubview(button)
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
        for view in topStackView.subviews {
            view.removeFromSuperview()
        }
        
        for view in bottomStackView.subviews {
            view.removeFromSuperview()
        }
    }
    @IBAction func layout1x2(_ sender: Any) {
        resetLayout()
        topStackView.addArrangedSubview(topStackView)
        bottomStackView.addArrangedSubview(bottomStackView)
        bottomStackView.addArrangedSubview(bottomStackView)
    }
    @IBAction func layout2x1(_ sender: Any) {
        resetLayout()
        topStackView.addArrangedSubview(topStackView)
        topStackView.addArrangedSubview(topStackView)
        bottomStackView.addArrangedSubview(bottomStackView)
    }
    @IBAction func layoutLeft1x2(_ sender: Any) {
        resetLayout()
        topStackView.addArrangedSubview(topStackView)
        bottomStackView.addArrangedSubview(bottomStackView)
        bottomStackView.addArrangedSubview(bottomStackView)
    }
    @IBAction func layout2x2(_ sender: Any) {
        resetLayout()
        topStackView.addArrangedSubview(topStackView)
        topStackView.addArrangedSubview(topStackView)
        bottomStackView.addArrangedSubview(bottomStackView)
        bottomStackView.addArrangedSubview(bottomStackView)
    }
}

