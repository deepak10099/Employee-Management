//
//  MultipleSelectionViewController.swift
//  Employee Management
//
//  Created by Deepak on 04/02/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import UIKit

public class MultipleSelectionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    public var addEmployeeDelegate:AddEmployeeViewController?
    var allHobbies = ["Cricket","Football","Coding","Reading","Listing Music","Watching Movies","Swimming"]
    @IBOutlet weak var multipleSelectionTableView: UITableView!

    public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, delegate:AddEmployeeViewController) {
        addEmployeeDelegate = delegate
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override public func viewDidLoad() {
        multipleSelectionTableView.register(UITableViewCell.self, forCellReuseIdentifier: "multipleSelectionCell")
        multipleSelectionTableView.delegate = self
        multipleSelectionTableView.dataSource = self
    }

    //MARK: UITableViewControllerDataSource Methods
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allHobbies.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = multipleSelectionTableView.dequeueReusableCell(withIdentifier: "multipleSelectionCell")!
        cell.selectionStyle = .none

        let checkBoxImageView = UIImageView(frame: CGRect(x: 20.0, y: 5.0, width: cell.bounds.height - 10.0 , height: cell.bounds.height - 10.0))
        checkBoxImageView.image = UIImage(named: "unchecked.png")
        cell.addSubview(checkBoxImageView)


        let hobbyTextLabel = UILabel(frame: CGRect(x: cell.bounds.height + 50, y: 5.0, width: 400.0, height: cell.bounds.height - 10.0))
        hobbyTextLabel.font = hobbyTextLabel.font.withSize(30.0)
        hobbyTextLabel.text = allHobbies[indexPath.row]
        cell.addSubview(hobbyTextLabel)
        return cell
    }

    //MARK: UITableViewControllerDelegate Methods
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:UITableViewCell = multipleSelectionTableView.cellForRow(at: indexPath)!
        (cell.subviews[1] as! UIImageView).image = UIImage(named: "checked.png")

    }

    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell:UITableViewCell = multipleSelectionTableView.cellForRow(at: indexPath)!
        (cell.subviews[1] as! UIImageView).image = UIImage(named: "unchecked.png")
    }

    @IBAction func submitButtonTapped(_ sender: Any) {
        var selectedHobbies:Array<String> = []
        let selectedIndexPaths:[IndexPath] = multipleSelectionTableView.indexPathsForSelectedRows ?? []
        for indexPath in selectedIndexPaths {
            selectedHobbies.append(allHobbies[indexPath.row])
        }
        addEmployeeDelegate?.selectedHobbies = selectedHobbies.joined(separator: ",")
        navigationController?.popViewController(animated: true)
    }
}
