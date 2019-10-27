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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //initial setup called
        initialSetup()
    }
    
    deinit {
        viewmodel?.delegate = nil
        viewmodel = nil
    }


}

