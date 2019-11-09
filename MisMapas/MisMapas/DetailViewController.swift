//
//  DetailViewController.swift
//  MisRecetas
//
//  Created by Juan Gabriel Gomila Salas on 8/7/16.
//  Copyright © 2016 Juan Gabriel Gomila Salas. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var placeImageView: UIImageView!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var ratingButton: UIButton!
    
    var place : Place!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = place.name
        
        self.placeImageView.image = self.place.image
        
        self.tableView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.25)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.separatorColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.75)
        
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableView.automaticDimension
        
        let image = UIImage(named: self.place.rating)
        self.ratingButton.setImage(image, for: .normal)

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    @IBAction func close(segue: UIStoryboardSegue){
        
        if let reivewVC = segue.source as? ReviewViewController {
        
            if let rating = reivewVC.ratingSelected {
                self.place.rating = rating
                let image = UIImage(named: self.place.rating)
                self.ratingButton.setImage(image, for: .normal)
            }
        
        }
        
    }
    
}



extension DetailViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 2
        case 1:
            return 22
        case 2:
            return 23
        default:
            return 0
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailViewCell", for: indexPath) as! PlaceDetailViewCell
        
        cell.backgroundColor = UIColor.clear
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.keyLabel.text = "Nombre:"
                cell.valueLabel.text = self.place.name
            case 1:
                cell.keyLabel.text = "Tiempo:"
                cell.valueLabel.text = ""
            default:
                break
            }
            
        case 1:
            if indexPath.row == 0 {
                cell.keyLabel.text = "Ingredientes:"
            } else {
                cell.keyLabel.text = ""
            }
            cell.valueLabel.text = ""
        case 2:
            if indexPath.row == 0 {
                cell.keyLabel.text = "Pasos:"
            } else {
                cell.keyLabel.text = ""
            }
            cell.valueLabel.text = ""
        default:
            break
        }
        
        
        return cell
        
    }
    
    
}



extension DetailViewController : UITableViewDelegate {
    
}
