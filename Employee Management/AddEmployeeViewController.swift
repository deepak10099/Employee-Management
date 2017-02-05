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

    let moc = DatabaseController.getContext()
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
    var employeeToDisplay:Employee? = nil
    var tableViewDataSource:[String]?

    var detailsLabel = ["Designation","DOB","Address","Gender","Hobbies"]
    @IBOutlet weak var addEmployeeTableView: UITableView!
    @IBOutlet weak var submitButton: UIButton!

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
        if submitButton.titleLabel?.text == "Edit" {
            addEmployeeTableView.isUserInteractionEnabled = false
        }
        else{
            addEmployeeTableView.isUserInteractionEnabled = true
        }
        if (employeeToDisplay != nil) {
            viewDidLoadForUpdateRecordOrDisplayRecord()
        }
        else{
            viewDidLoadForAddNewRecord()
        }
    }

    func viewDidLoadForUpdateRecordOrDisplayRecord(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dobString = dateFormatter.string(from: (employeeToDisplay?.dob)! as Date)
        tableViewDataSource = [(employeeToDisplay?.designation)!, dobString, (employeeToDisplay?.address)!, (employeeToDisplay?.gender)!, (employeeToDisplay?.hobbies)!]
    }

    func viewDidLoadForAddNewRecord() {
        tableViewDataSource = ["","","","",""]
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
            cell.nameTextView.text = employeeToDisplay?.name
            if (employeeToDisplay != nil) {
                cell.profilePicImageView.image = UIImage(data: (employeeToDisplay?.profilePic)! as Data)
            }
            else{
                cell.profilePicImageView.image = UIImage(named: "noProfile.jpg")
            }
            cell.profilePicImageView.layer.cornerRadius = cell.profilePicImageView.frame.width/2
            cell.profilePicImageView.clipsToBounds = true
        }
        else{
            cell = addEmployeeTableView.dequeueReusableCell(withIdentifier: "otherCells", for: indexPath) as! AddEmployeeCell
            cell.detailsTextView.text = tableViewDataSource?[indexPath.row - 1]
            if indexPath.row <= 3 {
                cell.rightArrowButton.isHidden = true
            }
            if indexPath.row == 2{
                cell.detailsTextView.inputView = datePickerView
            }
            if indexPath.row == 4{
                cell.detailsTextView.inputView = pickerView
            }
            if indexPath.row == 5{
                cell.detailsTextView.isUserInteractionEnabled = false
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
        dateFormatter.dateFormat = "dd/MM/yyyy"

        let cell:AddEmployeeCell = addEmployeeTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! AddEmployeeCell
        cell.detailsTextView.text = dateFormatter.string(from: sender.date)
    }

    //MARK: IBActions
    @IBAction func changePictureButtonTapped(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true

        present(pickerController, animated: true, completion: nil)
    }

    @IBAction func submitButtonPressed(_ sender: Any) {
        if  submitButton.titleLabel?.text == "Submit"
        {
            let employee:Employee = Employee(context: moc)
            save(employee: employee)
            navigationController?.popViewController(animated: true)
        }
        else if submitButton.titleLabel?.text == "Edit"{
            submitButton.setTitle("Save Changes", for: .normal)
            addEmployeeTableView.isUserInteractionEnabled = true
        }
        else if submitButton.titleLabel?.text == "Save Changes"{
            save(employee: employeeToDisplay!)
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    func save(employee:Employee){
        for index in 0..<((addEmployeeTableView.numberOfRows(inSection: 0)) + 1) {
            var cell:AddEmployeeCell?
            if index < addEmployeeTableView.numberOfRows(inSection: 0) {
                cell = addEmployeeTableView.cellForRow(at: IndexPath(row: index, section: 0)) as! AddEmployeeCell
            }
            switch index {
            case 0:
                let imageData = UIImagePNGRepresentation((cell?.profilePicImageView.image!)!)
                employee.profilePic = imageData as NSData?
                employee.name = cell?.nameTextView.text
            case 1:
                employee.designation = cell?.detailsTextView.text
            case 2:
                let dobString:String = cell!.detailsTextView.text
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/mm/yy"
                let dob:Date = (dobString != "") ? (dateFormatter.date(from: dobString)!) : Date()
                employee.dob = dob as NSDate?
            case 3:
                employee.address = cell?.detailsTextView.text
            case 4:
                employee.gender = cell?.detailsTextView.text
            case 5:
                employee.hobbies = cell?.detailsTextView.text
            case 6:
                employee.dateOfJoining = Date() as NSDate?
            default: break
            }
        }
        DatabaseController.saveContext()
    }
}

class AddEmployeeCell: UITableViewCell {
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var rightArrowButton: UIButton!
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var changeProfilePicButton: UIButton!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
