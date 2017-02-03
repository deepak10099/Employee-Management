//
//  AddEmployeeViewController.swift
//  Employee Management
//
//  Created by Deepak on 03/02/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import UIKit

class AddEmployeeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var detailsLabel = ["Designation","DOB","Address","Gender","Hobbies"]
    @IBOutlet weak var addEmployeeTableView: UITableView!

    override func viewDidLoad() {
        addEmployeeTableView.delegate = self
        addEmployeeTableView.dataSource = self
//        addEmployeeTableView.register(UINib(nibName: "", bundle: <#T##Bundle?#>), forCellReuseIdentifier: <#T##String#>)
//        addEmployeeTableView.register(AddEmployeeCell.classForCoder(), forCellReuseIdentifier: "firstCell")
//        addEmployeeTableView.register(AddEmployeeCell.classForCoder(), forCellReuseIdentifier: "otherCells")
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func viewDidAppear(_ animated: Bool) {

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (detailsLabel.count + 1)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:AddEmployeeCell!
        if  indexPath.row == 0{
            cell = addEmployeeTableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath) as! AddEmployeeCell
        }
        else{
            cell = addEmployeeTableView.dequeueReusableCell(withIdentifier: "otherCells", for: indexPath) as! AddEmployeeCell
            if indexPath.row <= 3 {
                cell.rightArrowButton.isHidden = true
            }
            cell.detailsLabel.text = detailsLabel[indexPath.row -  1]
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  indexPath.row == 4{

        }

        if indexPath.row == 5{
            
        }
    }

    @IBAction func submitButtonTapped(_ sender: Any) {

    }

}

class AddEmployeeCell: UITableViewCell {
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var rightArrowButton: UIButton!
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var changeProfilePicButton: UIButton!

    @IBAction func rightArrowButtonTapped(_ sender: Any) {

    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
}
