//
//  DetailViewController.swift
//  Mis Lugares
//
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
        
        let image = UIImage(named: self.place.rating) ?? #imageLiteral(resourceName: "rating")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            let destinationController = segue.destination as! MapViewController
            destinationController.place = self.place
        }
    }
}



extension DetailViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! PlaceDetailViewCell
        
        cell.backgroundColor = UIColor.clear
        
        switch indexPath.row {
            case 0:
                cell.keyLabel.text = "Nombre:"
                cell.valueLabel.text = self.place.name
            case 1:
                cell.keyLabel.text = "Tipo:"
                cell.valueLabel.text = self.place.type
            case 2:
                cell.keyLabel.text = "Localizacion:"
                cell.valueLabel.text = self.place.location
            case 3:
                cell.keyLabel.text = "Telefono:"
                cell.valueLabel.text = self.place.telephone
            case 4:
                cell.keyLabel.text = "WebSite:"
                cell.valueLabel.text = self.place.website
            default:
            break
        }
        
        return cell
        
    }
    
    
}



extension DetailViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 2:
            self.performSegue(withIdentifier: "showMap", sender: nil)
        default:
            break
        }
    }
}
