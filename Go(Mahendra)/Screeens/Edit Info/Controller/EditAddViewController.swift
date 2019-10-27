//
//  EditAddViewController.swift
//  Go(Mahendra)
//
//  Created by Mahendra Vishwakarma on 27/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import UIKit

class EditAddViewController: UIViewController {

    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var email: UITextField!
    var defaultContact:ContactDetailsInfo?
    var viewmodel:AditAddViewModel?
    var actionType:ContactAction!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // for initial setup
        initialSetup()
        
    }
    
    deinit {
        defaultContact = nil
        viewmodel = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    @IBAction func cancelTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneTapped(_ sender: Any)  {
        updateContact()
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        addImage()
    }
}
