//
//  Contact.swift
//  Go(Mahendra)
//
//  Created by Mahendra Vishwakarma on 26/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import Foundation


// MARK: - Contact
struct Contact: Codable {
    let id: Int
    let firstName, lastName: String?
    let profilePic: String?
    let favorite: Bool
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePic = "profile_pic"
        case favorite, url
    }
}

typealias Contacts = [Contact]
