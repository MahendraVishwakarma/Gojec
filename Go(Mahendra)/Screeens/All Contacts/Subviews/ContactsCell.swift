//
//  ContactsCell.swift
//  Go(Mahendra)
//
//  Created by Mahendra Vishwakarma on 26/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import UIKit

class ContactsCell: UITableViewCell {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var faviouriteImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        profilePic.layer.cornerRadius = profilePic.frame.height/2
        profilePic.layer.masksToBounds = true
        
        let color = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 0.6)
        
        profilePic.layer.borderColor = color.cgColor
        profilePic.backgroundColor = color
        profilePic.layer.borderWidth = 0.5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(info:Contact)  {
        userName.text = ((info.firstName ?? "") + "  " + (info.lastName ?? "")).capitalized
        faviouriteImg.image = info.favorite == true ? UIImage(named: "home_favourite") : UIImage(named: "")
        let url = Messages.base_url + (info.profilePic ?? "")
        profilePic.downloadImage(withUrl: url)
        
    }
    
}
