//
//  ViewController.swift
//  drag&DropEditor
//
//  Created by Haydee Rodriguez on 28/09/19.
//  Copyright © 2019 iosSchool. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
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
}

