
//
//  CharecterCell.swift
//  Go(Mahendra)
//
//  Created by Mahendra Vishwakarma on 27/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import UIKit

class CharecterCell: UITableViewCell {

    @IBOutlet weak var charName: UILabel!
    @IBOutlet weak var selectedView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectedView.layer.cornerRadius = selectedView.frame.height/2
        selectedView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setChar(char:String) {
        charName.text = char.capitalized
    }
    
}
