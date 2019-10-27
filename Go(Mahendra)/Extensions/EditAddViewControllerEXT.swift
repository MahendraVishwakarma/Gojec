//
//  EditAddViewControllerEXT.swift
//  Go(Mahendra)
//
//  Created by Mahendra Vishwakarma on 27/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import Foundation
import UIKit

extension EditAddViewController:ServeResponse{
    func initialSetup() {
       
        let gradientLayer = CAGradientLayer(point: .bottomTop)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: gradientView.frame.height)
        gradientView.layer.addSublayer(gradientLayer)
        
        profileImg.layer.cornerRadius = profileImg.frame.height/2
        profileImg.layer.masksToBounds = true
        profileImg.layer.borderColor = UIColor.white.cgColor
        profileImg.layer.borderWidth = 1.5
        
        // initialize view model
        viewmodel = AditAddViewModel()
        viewmodel?.delegate = self
        
        setDefaultValues()
    }
    
    func serverResponse<T>(result: Result<T?, APIError>) where T : Decodable {
        
        switch result {
        case .success(let data):
            DispatchQueue.main.async {
                
                self.activity.stopAnimating()
                if(self.actionType == .add) {
                    self.navigationController?.popViewController(animated: true)
                }else{
                    self.defaultContact = data as? ContactDetailsInfo
                    self.setDefaultValues()
                }
                
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
    // asigning default value
    func setDefaultValues(){
        fname.text = defaultContact?.firstName
        lname.text = defaultContact?.lastName
        mobile.text = defaultContact?.phoneNumber
        email.text = defaultContact?.email
        if(actionType == .add) {
            profileImg.image =  UIImage(named: "placeholder_photo")
        }else{
            let url = Messages.base_url + (defaultContact?.profilePic ?? "")
            profileImg.downloadImage(withUrl: url)
        }
       
    }
    
    func updateContact() {
        guard let fname = fname.text , let lname = lname.text , let mobile = mobile.text, let email = email.text  else{
            self.showToast(message: "something went wrong")
            return
        }
        if(fname.count <= 0) {
            self.showToast(message: "Please enter first name")
            return
        }
        
        if(lname.count <= 0) {
            self.showToast(message: "Please enter last name")
            return
        }
        
        if(mobile.count <= 0) {
            self.showToast(message: "Please enter mobile number")
            return
        }
        
        if(!Utils.checkEmail(email) ){
            self.showToast(message: "Please enter valid email")
            return
        }
        let param = ["first_name":fname, "last_name":lname,"phone_number":mobile,"email":email,"favorite":false] as [String : Any]
        self.activity.startAnimating()
        var url = ""
        var method : HttpsMethod = .Put
        if(actionType == .add){
            url = Messages.contact_url
            method = .Post
        }else{
            url = Messages.base_url + "/contacts/\(defaultContact?.id ?? 0).json"
        }
        viewmodel?.fetchData(requestURL: url, httpMethod: method, decode: ContactDetailsInfo.self, param: param)
    }
}

extension EditAddViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func addImage(){
        
        let pickerController = UIImagePickerController()
        let optionMenu = UIAlertController(title: nil, message: "Choose resource to take photo", preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
            {
                pickerController.delegate = self
                pickerController.sourceType = UIImagePickerController.SourceType.camera
                pickerController.allowsEditing = false
                self.present(pickerController, animated: true, completion: nil)
            }
            
        })
        
        
        let gallery = UIAlertAction(title: "Gallery", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(pickerController, animated: true, completion: nil)
            
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        
        
        optionMenu.addAction(camera)
        optionMenu.addAction(gallery)
        optionMenu.addAction(cancel)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            return
        }
        profileImg.image = image
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated:true, completion: nil)
    }
}

