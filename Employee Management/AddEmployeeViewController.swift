//
//  AddEmployeeViewController.swift
//  Employee Management
//
//  Created by Deepak on 03/02/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import UIKit

public
class AddEmployeeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource {

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
        let cell:AddEmployeeCell = addEmployeeTableView.cellForRow(at: indexPath) as! AddEmployeeCell

        if  indexPath.row == 4{

        }
        if indexPath.row == 5{
            var multipleSelectionViewController:UIViewController = MultipleSelectionViewController(nibName: "MultipleSelectionViewController", bundle: nil, delegate: self)
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


    func datePickerValueChanged(sender:UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short

        let cell:AddEmployeeCell = addEmployeeTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! AddEmployeeCell
        cell.detailsTextView.text = dateFormatter.string(from: sender.date)
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

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
}
