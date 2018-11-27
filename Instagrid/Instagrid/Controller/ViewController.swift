//
//  ViewController.swift
//  Instagrid
//
//  Created by Paschal on 27/09/18.
//  Copyright © 2018 nasch. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func makeButton(images: UIImage) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.setImage(images, for: .normal)
        button.addTarget(self, action: #selector(self.chooseImage(_:)), for: .touchUpInside)
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
    @objc func chooseImage(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Camera not available")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let imageChoose = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        for _ in layoutManager.images {
            var i = 0
            layoutManager.images[i] = imageChoose
            makeButton(images: imageChoose).setBackgroundImage(imageChoose, for: .normal)
            makeButton(images: imageChoose).contentMode = .scaleAspectFit
            i += 1
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
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

