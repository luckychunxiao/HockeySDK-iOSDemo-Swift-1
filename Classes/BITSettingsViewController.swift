//
//  BITSettingsViewController.swift
//  HockeySDK-iOSDemo-Swift
//
//  Created by Kevin Li on 18/10/2016.
//

import UIKit

class BITSettingsViewController: UITableViewController {

    func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(dismissSelf))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }

        // Configure the cell...
        if indexPath.row == 0 {
            cell!.textLabel?.text = NSLocalizedString("Beta Updates", comment: "")
        } else {
            cell!.textLabel?.text = NSLocalizedString("Feedback", comment: "")
        }
        cell!.accessoryType = UITableViewCellAccessoryType.disclosureIndicator

        return cell!
        
    }
    
    //MARK:  - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row==0 {
            let updateViewController = BITHockeyManager.shared().updateManager.hockeyViewController(false) as BITUpdateViewController
            self.navigationController?.pushViewController(updateViewController, animated: true)
        } else {
            let feedbackViewController = BITHockeyManager.shared().feedbackManager.feedbackListViewController(false) as BITFeedbackListViewController
            self.navigationController?.pushViewController(feedbackViewController, animated: true)
        }
    }

}
