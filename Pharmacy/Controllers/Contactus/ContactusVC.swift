//
//  ContactusVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/19/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import UIKit

class ContactusVC: UIViewController {
    let cellReuseIdentifier = "cell"
    let contactlist: [String] = ["Contact us", "About us", "Help", "App Info"]
    @IBOutlet weak var contactusTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initltable()
        
    }
    
    
    
    
}


extension ContactusVC : UITableViewDataSource , UITableViewDelegate {
    
    func initltable(){
        contactusTV.delegate = self
        contactusTV.dataSource = self
        contactusTV.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.view.addSubview(contactusTV)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
var cell : UITableViewCell? = contactusTV!.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel!.text = self.contactlist[indexPath.row]

        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "ContactusTVC")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
