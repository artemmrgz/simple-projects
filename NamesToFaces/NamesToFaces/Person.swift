//
//  Person.swift
//  NamesToFaces
//
//  Created by Artem Marhaza on 27/03/2023.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
