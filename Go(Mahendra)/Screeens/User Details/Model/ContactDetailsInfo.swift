//
//  ContactDetails.swift
//  Go(Mahendra)
//
//  Created by Mahendra Vishwakarma on 26/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//


import Foundation


// MARK: - ContactDetails
struct ContactDetailsInfo: Codable {
    let id: Int
    let firstName, lastName, email, phoneNumber: String?
    let profilePic: String?
    let favorite: Bool
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case phoneNumber = "phone_number"
        case profilePic = "profile_pic"
        case favorite
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
