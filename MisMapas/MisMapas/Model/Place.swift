//
//  Place.swift
//  MisMapas
//
//  Created by Haydee Rodriguez on 09/11/19.
//  Copyright © 2019 iosSchool. All rights reserved.
//

import Foundation
import UIKit

class Place {
    var name = ""
    var type = ""
    var location = ""
    var image: UIImage! = #imageLiteral(resourceName: "rating")
    var rating = ""
    var telephone = ""
    var website = ""
    
    init (name: String, type: String, location: String, image: UIImage, telephone: String, website: String){
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.telephone = telephone
        self.website = website
    }
}
