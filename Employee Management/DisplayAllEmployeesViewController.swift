

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
    var tableViewDataSource:[Employee] = []

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
        self.totalNumberOfEmployees.text = "\(tableViewDataSource.count)"
        var todaysCount = 0
        for employee in tableViewDataSource {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            var dateOfJoining = dateFormatter.string(from: employee.dateOfJoining as! Date)
            var todaysDate = dateFormatter.string(from: NSDate() as Date)
            if dateOfJoining == todaysDate {
                todaysCount += 1
            }
        }
        todaysReport.text = "\(todaysCount)"
    }

    //MARK: UITableViewControllerDataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DisplayAllEmployeesCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! DisplayAllEmployeesCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        cell.profilePicImageView.image = UIImage(data: tableViewDataSource[indexPath.row].profilePic as! Data)
        cell.dob.text = dateFormatter.string(from: tableViewDataSource[indexPath.row].dob as! Date)
        cell.gender.text = tableViewDataSource[indexPath.row].gender
        cell.name.text = tableViewDataSource[indexPath.row].name
        cell.dateOfRegistration.text = dateFormatter.string(from: Date())
        cell.profilePicImageView.layer.cornerRadius = cell.profilePicImageView.frame.width/2
        cell.profilePicImageView.clipsToBounds = true
        return cell
    }

    //MARK: UITableViewControllerDelegate Methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let addEmployeeViewController:AddEmployeeViewController = storyBoard.instantiateViewController(withIdentifier: "addVC") as! AddEmployeeViewController
        addEmployeeViewController.submitButton.setTitle("Edit", for: .normal)
        addEmployeeViewController.employeeToDisplay = tableViewDataSource[indexPath.row]
        navigationController?.pushViewController(addEmployeeViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            DatabaseController.getContext().delete(tableViewDataSource[indexPath.row])
            tableViewDataSource.remove(at: indexPath.row)
            DatabaseController.saveContext()
            allEmployeeDetailsTableView.deleteRows(at: [indexPath], with: .fade)
            updateMonitor()
        default:
            return
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as! AddEmployeeViewController).submitButton.setTitle("Submit", for: .normal)
    }
}

class DisplayAllEmployeesCell: UITableViewCell {
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var dateOfRegistration: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

