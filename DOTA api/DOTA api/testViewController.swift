//
//  testViewController.swift
//  DOTA api
//
//  Created by RMS2018 on 26/04/2019.
//  Copyright © 2019 RMS2018. All rights reserved.
//

import UIKit
//import CoreMotion

class testViewController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var roles: UILabel!
    @IBOutlet weak var hpValue: UILabel!
    @IBOutlet weak var manaValue: UILabel!
    @IBOutlet weak var arValue: UILabel!
    @IBOutlet weak var strValue: UILabel!
    @IBOutlet weak var intValue: UILabel!
    @IBOutlet weak var intGain: UILabel!
    @IBOutlet weak var strGain: UILabel!
    @IBOutlet weak var agiValue: UILabel!
    @IBOutlet weak var agiGain: UILabel!
    
    public var hero: Hero? = Hero(name: "",img: nil,data: [:])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = hero?.name
        img.image = hero?.img
        roles.text = (hero?.data["roles"] as? NSArray)?.componentsJoined(by: ", ")
        hpValue.text = (hero?.data["base_health"] as? Float)?.description
        manaValue.text = (hero?.data["base_mana"] as? Float)?.description
        arValue.text = (hero?.data["attack_rate"] as? NSNumber)?.description
        strValue.text = (hero?.data["base_str"] as? Float)?.description
        agiValue.text = (hero?.data["base_agi"] as? Float)?.description
        intValue.text = (hero?.data["base_int"] as? Float)?.description
        strGain.text = "+"+(hero?.data["str_gain"] as! NSNumber).description
        agiGain.text = "+"+(hero?.data["agi_gain"] as! NSNumber).description
        intGain.text = "+"+(hero?.data["int_gain"] as! NSNumber).description
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if(event?.subtype == UIEvent.EventSubtype.motionShake){
            self.performSegue(withIdentifier: "exstats", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? legViewController{
            vc.hero = hero
        }
    }
}
