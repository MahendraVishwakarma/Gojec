//
//  ViewController.swift
//  Go(Mahendra)
//
//  Created by Mahendra Vishwakarma on 26/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {

    var viewmodel:ContactViewModel?
    var contacts:Contacts!
    @IBOutlet weak var tablwview: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //initial setup called
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
        activity.startAnimating()
        viewmodel?.fetchData(requestURL: HttpURL.Contact.url, httpMethod: .Get, decode: Contacts.self, param: nil)
    }
    
    deinit {
        viewmodel?.delegate = nil
        viewmodel = nil
    }

    @IBAction func addContact(_ sender: Any) {
        guard let editContact = self.storyboard?.instantiateViewController(withIdentifier: "EditAddViewController") as? EditAddViewController else {
            return
        }
        editContact.actionType = .add
        self.navigationController?.pushViewController(editContact, animated: true)
    }
    
}

