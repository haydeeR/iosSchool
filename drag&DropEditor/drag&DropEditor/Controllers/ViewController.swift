//
//  ViewController.swift
//  drag&DropEditor
//
//  Created by Haydee Rodriguez on 28/09/19.
//  Copyright © 2019 iosSchool. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDragDelegate, UIDropInteractionDelegate, UIDragInteractionDelegate {
    
    @IBOutlet weak var editorImage: UIImageView!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    
    var colors = [UIColor]()
    var image: UIImage?
    var topFontColor = UIColor.white
    var bottomFontColor = UIColor.white
    var topText = "Welcome to iOS School"
    var bottomText = "Welcome to the magic! "
    var topFontName = "Avenir Next"
    var bottomFontName = "Baskerville"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupColors()
        editorImage.isUserInteractionEnabled = true
        let dropInteraction = UIDropInteraction(delegate: self)
        editorImage.addInteraction(dropInteraction)
        let dragInteraction = UIDragInteraction(delegate: self)
        editorImage.addInteraction(dragInteraction)
        renderEditor()
    }
    
    private func setupColors() {
        colors += [.black, .blue,.orange, .purple, .green, .gray, .red, .magenta]
        
        for hue in 0...9{
            for sat in 1...10{
                let color = UIColor(hue: CGFloat(hue)/10, saturation: CGFloat(sat)/10, brightness: 1, alpha: 1)
                self.colors.append(color)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath)
        let color = colors[indexPath.row]
        cell.backgroundColor = color
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        
        return cell
    }
    
    private func renderEditor(){
        let mainRect = CGRect(x: 0, y: 0, width: 3000, height: 2400)
        let topRect = CGRect(x: 300, y: 200, width: 2400, height: 800)
        let bottomRect = CGRect(x: 300, y: 1800, width: 2400, height: 600)
        
        let topFont = UIFont(name: topFontName, size: 250) ?? UIFont.systemFont(ofSize: 250)
        let bottomFont = UIFont(name: bottomFontName, size: 120) ?? UIFont.systemFont(ofSize: 120)
        
        let centered = NSMutableParagraphStyle()
        centered.alignment = .center
        let topAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: topFontColor,
            .font: topFont,
            .paragraphStyle: centered
        ]
        let bottomAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: bottomFontColor,
            .font: bottomFont,
            .paragraphStyle: centered
        ]
        
        let render = UIGraphicsImageRenderer(size: mainRect.size)
        editorImage.image = render.image(actions: { (context) in
            UIColor.gray.set()
            context.fill(mainRect)
            
            image?.draw(at: CGPoint(x: 0, y: 0))
            self.topText.draw(in: topRect, withAttributes: topAttributes)
            self.bottomText.draw(in: bottomRect, withAttributes: bottomAttributes)
        })
        
    }
    
    //MARK: UICollectionDragDelegate
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        let color = colors[indexPath.row]
        let itemProvider = NSItemProvider(object: color)
        let item = UIDragItem(itemProvider: itemProvider)
        return [item]
    }
    
    //MARK: UIDragInteractionDelegate
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        guard let image = editorImage.image else { return [] }
        let provider = NSItemProvider(object: image)
        let item = UIDragItem(itemProvider: provider)
        return [item]
    }
    
    
    //MARK: UIDropInteractionDelegate
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        let dropLocation = session.location(in: editorImage)
        
        if session.hasItemsConforming(toTypeIdentifiers: [kUTTypePlainText as String]) {
            print("Hemos soltado una fuente")
            session.loadObjects(ofClass: NSString.self) { (items) in
                guard let fontName = items.first as? String else {return}
                if dropLocation.y < self.editorImage.bounds.midY {
                    self.topFontName = fontName
                }else {
                    self.bottomFontName = fontName
                }
                self.renderEditor()
            }
        } else if session.hasItemsConforming(toTypeIdentifiers: [kUTTypeImage as String]){
            print("Hemos soltado una imagen")
            session.loadObjects(ofClass: UIImage.self) { (items) in
                guard let image = items.first as? UIImage else {return}
                self.image = self.resizeImage(image: image, targetSize: CGSize(width: 300, height: 300))
                self.renderEditor()
            }
        } else {
            print("Hemos soltado un color")
            session.loadObjects(ofClass: UIColor.self) { (items) in
                guard let color = items.first as? UIColor else {return}
                if dropLocation.y > self.editorImage.bounds.midY {
                    self.bottomFontColor = color
                } else {
                    self.topFontColor = color
                }
                self.renderEditor()
            }
        }
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let originalSize = image.size
        
        let widthRatio = targetSize.width / originalSize.width // x 2.3
        let heightRatio = targetSize.height / originalSize.height // x1.8
        
        let targetRatio = max(widthRatio, heightRatio)
        
        let newSize = CGSize(width: originalSize.width * targetRatio,
                             height: originalSize.height * targetRatio)
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
        
    }
    // MARK: UITapGesture
    
    @IBAction func changeText(_ sender: UITapGestureRecognizer) {
        
        let tapLocation = sender.location(in: self.editorImage)
        let changeTop = (tapLocation.y < self.editorImage.bounds.midY) ? true : false
        let alertController = UIAlertController(title: "Cambia el texto", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Escribe aquí el texto a cambiar"
            textField.text = changeTop ? self.topText : self.bottomText
        }
        let changeTextAction = UIAlertAction(title: "Cambiar texto", style: .default) { _ in
            guard let newText = alertController.textFields?[0].text else { return }
            if changeTop {
                self.topText = newText
            } else {
                self.bottomText = newText
            }
            self.renderEditor()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(changeTextAction)
        alertController.addAction(cancelAction)
        present(alertController,animated: true)
    }
    
}

