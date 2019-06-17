//
//  legViewController.swift
//  DOTA api
//
//  Created by RMS2018 on 24/05/2019.
//  Copyright © 2019 RMS2018. All rights reserved.
//

import UIKit

class legViewController: UIViewController {

    @IBOutlet weak var legs: UIImageView!
    
    public var hero: Hero? = Hero(name: "",img: nil,data: [:])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if ((hero?.data["legs"] as? Float) == 0)  {
            legs.image = UIImage(named: "leg0")
        }
        if ((hero?.data["legs"] as? Float) == 2)  {
            legs.image = UIImage(named: "leg2")
        }
        if ((hero?.data["legs"] as? Float) == 4)  {
            legs.image = UIImage(named: "leg4")
        }
        if ((hero?.data["legs"] as? Float) == 6)  {
            legs.image = UIImage(named: "leg6")
        }
        if ((hero?.data["legs"] as? Float) == 8)  {
            legs.image = UIImage(named: "leg8")
        }
        
    }

}
