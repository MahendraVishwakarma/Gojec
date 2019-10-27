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
        
        characters = CharactersView(frame: CGRect(x: self.view.frame.maxX-30, y: 100, width: 25, height: 0))
        self.view.addSubview(characters)
        // register cell on tableView
        tablwview.register(UINib(nibName: "ContactsCell", bundle: nil), forCellReuseIdentifier: "contactCell")
    }
    func serverResponse<T>(result: Result<T?, APIError>) where T : Decodable {
      
        switch result {
        case .success(let data):
            DispatchQueue.main.async {
                self.activity.stopAnimating()
                self.contacts = data as? Contacts
                self.contacts = self.contacts.sorted { ($0.firstName ?? "").lowercased() < ($1.firstName ?? "").lowercased() }
                self.filterChars()
                self.tablwview.reloadData()
            }
            
        case .failure(_):
            DispatchQueue.main.async {
                self.activity.stopAnimating()
            }
            
        }
    }
    
    func filterChars() {
        var chars = Array<String>()
        for char in self.contacts {
            let str = (char.firstName ?? "")
            let index = str.index(str.startIndex, offsetBy: 0)
            let charObj = String(str[index]).lowercased()
            
            if(!chars.contains(charObj)) {
                chars.append(charObj)
            }
        }
        
        let heightt = 25*chars.count
        characters.frame = CGRect(x: Int(characters.frame.origin.x), y: Int(characters.frame.origin.y), width: 25, height: heightt)
        characters.charactrs = chars
        characters.updateData()
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
    
    func updateIndex(index:Int){
        let name = contacts[index].firstName ?? ""
        
        let index = name.index(name.startIndex, offsetBy: 0)
        let charObj = String(name[index]).lowercased()
        if(charObj != characters.charactrs[characters.selectedChar]) {
            let charIndex = characters.charactrs.lastIndex(of: charObj)
            characters.selectedChar = charIndex ?? 0
            characters.updateData()
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        updateIndex(index: indexPath.row)
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





