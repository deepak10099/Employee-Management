//
//  AddEmployeeViewController.swift
//  Employee Management
//
//  Created by Deepak on 03/02/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import UIKit

class AddEmployeeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var addEmployeeTableView: UITableView!

    override func viewDidLoad() {
        addEmployeeTableView.delegate = self
        addEmployeeTableView.dataSource = self
        addEmployeeTableView.register(AddEmployeeCell.classForCoder(), forCellReuseIdentifier: "firstCell")
        addEmployeeTableView.register(AddEmployeeCell.classForCoder(), forCellReuseIdentifier: "otherCells")
    }

    override func viewWillAppear(_ animated: Bool) {

    }

    override func viewDidAppear(_ animated: Bool) {

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:AddEmployeeCell!
        if  indexPath.row == 0{
            cell = addEmployeeTableView.dequeueReusableCell(withIdentifier: "firstCell") as! AddEmployeeCell!
            cell.profilePicImageView = UIImageView(image: UIImage(named: "profileImage.jpg"))
            cell.nameLabel.text = "Deepak"
        }
        else{
            cell = addEmployeeTableView.dequeueReusableCell(withIdentifier: "otherCells") as! AddEmployeeCell!
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

class AddEmployeeCell: UITableViewCell {
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var changeProfilePicButton: UIButton!
}
