//
//  Hero.swift
//  DOTA api
//
//  Created by RMS2018 on 29/03/2019.
//  Copyright © 2019 RMS2018. All rights reserved.
//

import UIKit

class Hero {
    var name: String
    var img: UIImage?
    var data: NSDictionary
    
    init?(name: String, img: UIImage?, data: NSDictionary) {
        if name.isEmpty{
            return nil
        }
        self.data = data
        self.name = name
        self.img = img
    }
}
