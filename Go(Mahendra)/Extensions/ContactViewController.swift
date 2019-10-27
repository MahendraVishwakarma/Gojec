//
//  ContactViewController.swift
//  Go(Mahendra)
//
//  Created by Mahendra Vishwakarma on 26/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import Foundation
import UIKit

extension ContactsViewController:ServeResponse{
    
    func initialSetup() {
        //initialize view model
        viewmodel = ContactViewModel()
        viewmodel?.delegate = self
        self.navigationController?.isNavigationBarHidden = true
        activity.startAnimating()
        viewmodel?.fetchData(requestURL: HttpURL.Contact.url, httpMethod: .Get, decode: Contacts.self, param: nil)
        
        // register cell on tableView
        tablwview.register(UINib(nibName: "ContactsCell", bundle: nil), forCellReuseIdentifier: "contactCell")
    }
    func serverResponse<T>(result: Result<T?, APIError>) where T : Decodable {
      
        switch result {
        case .success(let data):
            DispatchQueue.main.async {
                self.activity.stopAnimating()
                self.contacts = data as? Contacts
                self.tablwview.reloadData()
            }
            
        case .failure(_):
            DispatchQueue.main.async {
                self.activity.stopAnimating()
            }
            
        }
    }
}
//MARK:tableView Datasource
extension ContactsViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts != nil ?  contacts.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactsCell else {
            return ContactsCell()
        }
        cell.setData(info: contacts[indexPath.row])
        return cell
    }
}

//MARK: tableview delegate
extension ContactsViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      guard let contatDetailObj = self.storyboard?.instantiateViewController(withIdentifier: "ContactDetailsViewController") as? ContactDetailsViewController else {
            return
        }
        contatDetailObj.contact = contacts[indexPath.row]
        self.navigationController?.pushViewController(contatDetailObj, animated: true)
    }
}





