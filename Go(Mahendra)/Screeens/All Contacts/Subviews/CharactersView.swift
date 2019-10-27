//
//  CharactersView.swift
//  Go(Mahendra)
//
//  Created by Mahendra Vishwakarma on 27/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import UIKit

class CharactersView: UIView {

    let xibName = "CharactersView"
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var tableview: UITableView!
    var charactrs:Array<String>!
    var selectedChar:Int = 0
    weak var parentObject:ContactsViewController?
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialization()
    }
    
    func initialization() {
        Bundle.main.loadNibNamed(xibName, owner: self, options: nil)
        containerView.setFrameInView(self)
        tableview.register(UINib(nibName: "CharecterCell", bundle: nil), forCellReuseIdentifier: "charCell")
        
        
    }
    
    func updateData() {
        tableview.reloadData()
    }

}

extension CharactersView:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactrs != nil ? charactrs.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "charCell", for: indexPath) as? CharecterCell else{
            return CharecterCell()
        }
        cell.setChar(char: charactrs[indexPath.row])
        if(indexPath.row == selectedChar) {
           cell.selectedView.backgroundColor = UIColor(red: 0.0, green: 235.0/255.0, blue: 195.0/255.0, alpha: 1)
        }else{
            cell.selectedView.backgroundColor = UIColor.white
        }
        
        return cell
        
    }
}

extension CharactersView:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       parentObject?.scrollToIndex(char: charactrs[indexPath.row])
    }
}
