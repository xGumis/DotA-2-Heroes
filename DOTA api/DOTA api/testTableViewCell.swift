//
//  testTableViewCell.swift
//  DOTA api
//
//  Created by RMS2018 on 22/03/2019.
//  Copyright © 2019 RMS2018. All rights reserved.
//

import UIKit

class testTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroImg: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
