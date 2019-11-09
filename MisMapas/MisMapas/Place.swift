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
    var image: UIImage!
    var rating = ""
    
    init (name: String, type:String, location:String, image:UIImage, rating: String){
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.rating = rating
    }
}
