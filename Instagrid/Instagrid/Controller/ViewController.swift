//
//  ViewController.swift
//  Instagrid
//
//  Created by Paschal on 27/09/18.
//  Copyright © 2018 nasch. All rights reserved.
//

import UIKit
extension UIView {
    
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
}
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
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var swipeTextLabel: UILabel!
    @IBOutlet weak var squareStackView: UIStackView!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var bottomStackView: UIStackView!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet var layoutButtons: [UIButton]!
    let layoutManager = LayoutManager()
    var currentImagesIndex = -1
    var swipeGestureRecognizer: UISwipeGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        layout2x1(self)
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeToShare(_:)))
        swipeGestureRecognizer.direction = .up
        swipeGestureRecognizer.numberOfTouchesRequired = 1
        view.addGestureRecognizer(swipeGestureRecognizer)
        
    }
    override func willTransition(to: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            self.swipeGestureRecognizer.direction = .left
        } else {
            self.swipeGestureRecognizer.direction = .up
        }
        coordinator.animate(alongsideTransition: { context in
            if UIDevice.current.orientation.isLandscape {
                self.swipeTextLabel.text = "Swipe left to share"
            } else {
                self.swipeTextLabel.text = "Swipe up to share"
            }
        })
    }
    @objc func swipeToShare(_ sender: UISwipeGestureRecognizer) {
        let shareImage = squareStackView.asImage()
        let swipeActivityController = UIActivityViewController(activityItems: [shareImage], applicationActivities: nil)
        present(swipeActivityController, animated: true, completion: nil)
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

