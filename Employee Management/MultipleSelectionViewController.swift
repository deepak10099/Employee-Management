//
//  MultipleSelectionViewController.swift
//  Employee Management
//
//  Created by Deepak on 04/02/17.
//  Copyright © 2017 Deepak. All rights reserved.
//

import UIKit

public class MultipleSelectionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var multipleSelectionTableView: UITableView!

    override public func viewDidLoad() {


        multipleSelectionTableView.register(UITableViewCell.self, forCellReuseIdentifier: "multipleSelectionCell")
        multipleSelectionTableView.delegate = self
        multipleSelectionTableView.dataSource = self
    }


    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = multipleSelectionTableView.dequeueReusableCell(withIdentifier: "multipleSelectionCell")!
        cell.selectionStyle = .none
        cell.textLabel?.text = "deepak"
        cell.imageView?.image = UIImage(named: "unchecked.png")
        cell.imageView?.frame = CGRect(x: 10.0, y: 10.0, width: (cell.imageView?.frame.width)! - 20.0, height: (cell.imageView?.frame.height)! - 20.0)

        cell.contentView.backgroundColor = UIColor.clear
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 0.0, y: 10.0, width: view.frame.size.width, height: 70.0))

        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 3.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.5
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:UITableViewCell = multipleSelectionTableView.cellForRow(at: indexPath)!
        cell.imageView?.image = UIImage(named: "checked.png")

    }

    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell:UITableViewCell = multipleSelectionTableView.cellForRow(at: indexPath)!
        cell.imageView?.image = UIImage(named: "unchecked.png")
    }
}
