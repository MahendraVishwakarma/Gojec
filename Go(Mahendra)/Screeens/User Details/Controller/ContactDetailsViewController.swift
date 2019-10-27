//
//  ContactDetailsViewController.swift
//  Go(Mahendra)
//
//  Created by Mahendra Vishwakarma on 26/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {

    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    let gradientLayer = CAGradientLayer(point: .bottomTop)
    var viewmodel:ContactDetailViewDetail?
    var contactDetails:ContactDetailsInfo!
    var contact:Contact?
    @IBOutlet weak var mobileNumber: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var favouriteImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

       //initial setup called
        initialSetup()
        
    }
    
    deinit {
        viewmodel?.delegate = nil
        viewmodel = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
     
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnedit(_ sender: Any) {
        
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        sendMessage()
    }
    
    @IBAction func makeCall(_ sender: Any) {
       
        if let url = URL(string: "tel://\((contactDetails.phoneNumber ?? ""))"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            self.showToast(message: "calling is not possible")
        }
        
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        sendEmail()
    }
    
    @IBAction func makeFavourite(_ sender: Any) {
        makeFavourite()
    }
    
    @IBAction func deleteContact(_ sender: Any) {
     deleteContact()
    }
}
