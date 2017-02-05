//
//  AddEmployeeViewController.swift
//  Employee Management
//
//  Created by Deepak on 03/02/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import UIKit
import CoreData


public
class AddEmployeeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var selectedHobbies:String = ""{
        didSet{
            let cell:AddEmployeeCell = addEmployeeTableView.cellForRow(at: IndexPath(row: 5, section: 0)) as! AddEmployeeCell
            cell.detailsTextView.text = selectedHobbies
        }
    }
    var genderTextView:UITextView!
    var pickerView:UIPickerView!
    var pickerViewData:Array<String>!

    var datePickerView:UIDatePicker!

    var detailsLabel = ["Designation","DOB","Address","Gender","Hobbies"]
    @IBOutlet weak var addEmployeeTableView: UITableView!

    override public func viewDidLoad() {
        addEmployeeTableView.delegate = self
        addEmployeeTableView.dataSource = self
        pickerView = UIPickerView()
        pickerViewData = ["Male","Female","Others"]
        pickerView.dataSource = self
        pickerView.delegate = self

        datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        datePickerView.addTarget(self, action: #selector(AddEmployeeViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }

    override public func viewWillAppear(_ animated: Bool) {
        
    }

    override public func viewDidAppear(_ animated: Bool) {

    }

    //MARK: UITableViewControllerDataSource Methods
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (detailsLabel.count + 1)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:AddEmployeeCell!
        if  indexPath.row == 0{
            cell = addEmployeeTableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath) as! AddEmployeeCell
        }
        else{
            cell = addEmployeeTableView.dequeueReusableCell(withIdentifier: "otherCells", for: indexPath) as! AddEmployeeCell
            if indexPath.row <= 3 {
                cell.rightArrowButton.isHidden = true
            }
            if indexPath.row == 2{
                cell.detailsTextView.inputView = datePickerView
            }
            if indexPath.row == 4{
                cell.detailsTextView.inputView = pickerView
            }
            cell.detailsLabel.text = detailsLabel[indexPath.row -  1]

        }
        cell.selectionStyle = .none
        return cell
    }

    //MARK: UITableViewControllerDelegate Methods
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 5{
            let multipleSelectionViewController:UIViewController = MultipleSelectionViewController(nibName: "MultipleSelectionViewController", bundle: nil, delegate: self)
            navigationController?.pushViewController(multipleSelectionViewController, animated: true)
//            self.present(multipleSelectionViewController, animated: true, completion: nil)
        }


    }

    //MARK: UIPickerViewDataSource Methods
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewData.count
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewData[row]
    }

    //MARK: UIPickerViewDelegate Methods
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let cell:AddEmployeeCell = (addEmployeeTableView.cellForRow(at: IndexPath(row: 4, section: 0)) as! AddEmployeeCell)
        cell.detailsTextView.text = pickerViewData[row]
        view.endEditing(true)
    }



    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        let cell:AddEmployeeCell = addEmployeeTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! AddEmployeeCell
        cell.profilePicImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    func datePickerValueChanged(sender:UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yyyy"
//        dateFormatter.dateStyle = .medium

        let cell:AddEmployeeCell = addEmployeeTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! AddEmployeeCell
        cell.detailsTextView.text = dateFormatter.string(from: sender.date)
    }

    @IBAction func changePictureButtonTapped(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true

        present(pickerController, animated: true, completion: nil)
    }

    @IBAction func submitButtonPressed(_ sender: Any) {
        save()
    }

    @IBAction func fetchButtonPressed(_ sender: Any) {
        fetch()
    }
    
    func save(){
        let moc = DatabaseController.getContext()
        let employee:Employee = Employee(context: moc)
        for index in 0..<(addEmployeeTableView.numberOfRows(inSection: 0)) {
            let cell:AddEmployeeCell = addEmployeeTableView.cellForRow(at: IndexPath(row: index, section: 0)) as! AddEmployeeCell
            switch index {
            case 0:
                let imageData = UIImagePNGRepresentation(cell.profilePicImageView.image!)
                employee.profilePic = imageData as NSData?
                employee.name = cell.nameLabel.text
            case 1:
                employee.designation = cell.detailsTextView.text
            case 2:
                let dobString:String = cell.detailsTextView.text
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/mm/yy"
                let dob:Date = dateFormatter.date(from: dobString)!
                employee.dob = dob as NSDate?
            case 3:
                employee.address = cell.detailsTextView.text
            case 4:
                employee.gender = cell.detailsTextView.text
            case 5:
                employee.hobbies = cell.detailsTextView.text
            default: break
            }
        }
        DatabaseController.saveContext()
    }

    func fetch(){
        let fetchRequest:NSFetchRequest<Employee> = Employee.fetchRequest()
        do{
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            print("numberOfResults: \(searchResults.count)")
            for result in searchResults as [Employee]{
                print("Name: \(result.name)")
            }
        }
        catch{
            print("Error: \(error)")
        }
    }
}

class AddEmployeeCell: UITableViewCell {
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var rightArrowButton: UIButton!
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var changeProfilePicButton: UIButton!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
