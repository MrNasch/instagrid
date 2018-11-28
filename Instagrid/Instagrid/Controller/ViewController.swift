//
//  ViewController.swift
//  Instagrid
//
//  Created by Paschal on 27/09/18.
//  Copyright © 2018 nasch. All rights reserved.
//

import UIKit
// main class of the view
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Making generic button for the grid layout
    func makeButton(images: UIImage, index: Int) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.setImage(images, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(self.chooseImage(_:)), for: .touchUpInside)
        button.tag = index
        return button
    }
    // Outlet of the view
    @IBOutlet weak var swipeTextLabel: UILabel!
    @IBOutlet weak var squareStackView: UIStackView!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var bottomStackView: UIStackView!
    let layoutManager = LayoutManager()
    var currentImagesIndex = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        layout2x1(self)
    }
    // choosing image using actionsheet (camera or library)
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
        currentImagesIndex = sender.tag
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    // Remplace generic button image by one selected in the library or taken by the camera
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let imageChoose = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        layoutManager.images[currentImagesIndex] = imageChoose
        makeGridLayout()
        picker.dismiss(animated: true, completion: nil)
    }
    // End of imagePicker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    // making layout into the view
    func makeGridLayout() {
        resetLayout()
        let firstLine = layoutManager.imagesGrid[0]
        let secondLine = layoutManager.imagesGrid[1]
        
        for images in firstLine.enumerated() {
            topStackView.addArrangedSubview(makeButton(images: images.element, index: images.offset))
        }
        for images in secondLine.enumerated() {
            bottomStackView.addArrangedSubview(makeButton(images: images.element, index: images.offset + firstLine.count))
        }
    }
    // reseting the layout
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
    // Layout choose by the button
    @IBAction func layout1x2(_ sender: Any) {
        
        layoutManager.type = .layout1x2
        makeGridLayout()
    }
    // Layout choose by the button
    @IBAction func layout2x1(_ sender: Any) {
        layoutManager.type = .layout2x1
        makeGridLayout()
    }
    // Layout choose by the button
    @IBAction func layoutLeft1x2(_ sender: Any) {
        layoutManager.type = .layoutLeft1x2
        makeGridLayout()
    }
    // Layout choose by the button
    @IBAction func layout2x2(_ sender: Any) {
        layoutManager.type = .layout2x2
        makeGridLayout()
    }
}

