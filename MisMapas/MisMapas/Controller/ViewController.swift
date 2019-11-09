//
//  ViewController.swift
//  MisRecetas
//
//  Created by Haydee Rodriguez on 31/8/19.
//

import UIKit

class ViewController: UITableViewController { /*UIViewController, UITableViewDataSource, UITableViewDelegate*/
    
    var places : [Place] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        var place = Place(name: "AlexanderPlatz", type: "plaza", location: "Alexanderplatz 1 10178 Berlin Germany", image: #imageLiteral(resourceName: "cristoredentor") ,telephone: "123123123", website: "https://www.gob.mx/sectur/es/")
        places.append(place)
        place = Place(name: "Atomium", type: "museo", location: "Place de l'Atomium 1 1020 Brussels Belgium", image: #imageLiteral(resourceName: "atomium") ,telephone: "123123123", website: "https://www.gob.mx/sectur/es/")
        places.append(place)
        place = Place(name: "BigBen", type: "monumento", location: "London SW1A 0AA England", image: #imageLiteral(resourceName: "bigben"), telephone: "123123123", website: "https://www.gob.mx/sectur/es/")
        places.append(place)
        place = Place(name: "CristoRedentor", type: "monumento", location: "Parque Nacional da Tijuca Escadaria do Corcovado Humaitá Rio de Janeiro - RJ 21072 Brasil", image: #imageLiteral(resourceName: "cristoredentor"),telephone: "123123123", website: "https://www.gob.mx/sectur/es/" )
        places.append(place)


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    //MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let place = places[indexPath.row]
        let cellID = "PlaceCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PlaceCell
        
        cell.thumbnailImageView.image = place.image
        cell.nameLabel.text = place.name
        cell.timeLabel.text = place.type
        cell.ingredientsLabel.text = place.location
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            self.places.remove(at: indexPath.row)
            
        }
        
        self.tableView.deleteRows(at: [indexPath], with: .fade)
        
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //Compartir
        let shareAction = UITableViewRowAction(style: .default, title: "Compartir") { (action, indexPath) in
            let shareDefaultText = "Estoy visitando  \(self.places[indexPath.row].name)"
            
            let activityController = UIActivityViewController(activityItems: [shareDefaultText, self.places[indexPath.row].image!], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        }
        
        shareAction.backgroundColor = UIColor(red: 30.0/255.0, green: 164.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        
        //Borrar
        let deleteAction = UITableViewRowAction(style: .default, title: "Borrar") { (action, indexPath) in
            self.places.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        
        return [shareAction, deleteAction]
    }
    
    
    
    //MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectPlace = self.places[indexPath.row]
                let destinationViewController = segue.destination as! DetailViewController
                destinationViewController.place = selectPlace
            }
        }
    }
    
    
    
}

