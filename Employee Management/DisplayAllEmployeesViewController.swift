//
//  DisplayAllEmployeesViewController.swift
//  Employee Management
//
//  Created by Deepak on 02/02/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import UIKit
import CoreData

class DisplayAllEmployeesViewController: UIViewController,NSFetchedResultsControllerDelegate,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var todaysReport: UILabel!
    @IBOutlet weak var totalNumberOfEmployees: UILabel!
    @IBOutlet weak var allEmployeeDetailsTableView: UITableView!
    var tableViewDataSource:[Employee]?

    override func viewDidLoad() {
        super.viewDidLoad()
        allEmployeeDetailsTableView.delegate = self
        allEmployeeDetailsTableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetch()
        updateMonitor()
    }

    func fetch(){
        let fetchRequest:NSFetchRequest<Employee> = Employee.fetchRequest()
        do{
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "dateOfJoining", ascending: true)]
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            self.tableViewDataSource = searchResults as [Employee]
            self.allEmployeeDetailsTableView.reloadData()
        }
        catch{
            print("Error: \(error)")
        }
    }

    func updateMonitor() {
        self.totalNumberOfEmployees.text = "\(tableViewDataSource?.count)"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DisplayAllEmployeesCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! DisplayAllEmployeesCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        cell.profilePicImageView.image = UIImage(data: tableViewDataSource?[indexPath.row].profilePic as! Data)
        cell.dob.text = dateFormatter.string(from: tableViewDataSource?[indexPath.row].dob as! Date)
        cell.gender.text = tableViewDataSource?[indexPath.row].gender
        cell.name.text = tableViewDataSource?[indexPath.row].name
        cell.dateOfRegistration.text = dateFormatter.string(from: Date())
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

}

class DisplayAllEmployeesCell: UITableViewCell {
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var dateOfRegistration: UILabel!
}

