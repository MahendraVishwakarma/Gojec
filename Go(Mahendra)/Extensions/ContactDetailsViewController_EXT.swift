//
//  ContactDetailsViewController_EXT.swift
//  Go(Mahendra)
//
//  Created by Mahendra Vishwakarma on 26/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

extension ContactDetailsViewController:ServeResponse{
    
    func initialSetup() {
        
        self.navigationController?.isNavigationBarHidden = true
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: gradientView.frame.height)
        gradientView.layer.addSublayer(gradientLayer)
        
        profileImg.layer.cornerRadius = profileImg.frame.height/2
        profileImg.layer.masksToBounds = true
        profileImg.layer.borderColor = UIColor.white.cgColor
        profileImg.layer.borderWidth = 1.5
        
        // initialize
        viewmodel = ContactDetailViewDetail()
        viewmodel?.delegate = self
        
        activity.startAnimating()
        viewmodel?.fetchData(requestURL: (contact?.url ?? ""), httpMethod: .Get, decode: ContactDetailsInfo.self, param: nil)
        
    }
    
    func serverResponse<T>(result: Result<T?, APIError>) where T : Decodable {
        
        switch result {
        case .success(let data):
            DispatchQueue.main.async {
                self.activity.stopAnimating()
                self.contactDetails = data as? ContactDetailsInfo
                self.setInfo(info: self.contactDetails)
            }
            
        case .failure(let err):
            
            DispatchQueue.main.async {
                self.activity.stopAnimating()
                print(err.localizedDescription)
                if(err.localizedDescription == "204"){
                    self.showToast(message: "Contact is deleted")
                    self.navigationController?.popViewController(animated: true)
                }
                
            }
            
        }
    }
    
    func setInfo(info:ContactDetailsInfo) {
        
        userName.text = ((info.firstName ?? "") + "  " + (info.lastName ?? "")).capitalized
        let url = Messages.base_url + (info.profilePic ?? "")
        profileImg.downloadImage(withUrl: url)
        mobileNumber.text = info.phoneNumber
        email.text = info.email
        favouriteImg.image = info.favorite == true ? UIImage(named: "home_favourite") : UIImage(named: "favourite_button")
    }
    
    func makeFavourite() {
        self.activity.startAnimating()
        let param = ["favorite":!contactDetails.favorite]
        viewmodel?.fetchData(requestURL: (contact?.url ?? ""), httpMethod: .Put, decode: ContactDetailsInfo.self, param: param)
    }
    
    func deleteContact() {
        self.activity.startAnimating()
        viewmodel?.fetchData(requestURL: (contact?.url ?? ""), httpMethod: .Delate, decode: ContactDetailsInfo.self, param: nil)
    }
}

extension ContactDetailsViewController : MFMessageComposeViewControllerDelegate {
    func sendMessage() {
        
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Message Body"
            controller.recipients = [contactDetails.phoneNumber ?? ""] 
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }else {
            self.showToast(message: "message can not send")
        }
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
}

extension ContactDetailsViewController: MFMailComposeViewControllerDelegate{
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([contactDetails.email ?? ""])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
             self.showToast(message: "email can not send")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }

}


