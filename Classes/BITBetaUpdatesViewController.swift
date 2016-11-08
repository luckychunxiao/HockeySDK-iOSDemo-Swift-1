//
//  BITBetaUpdatesViewController.swift
//  HockeySDK-iOSDemo-Swift
//
//  Created by Kevin Li on 18/10/2016.
//

import UIKit

class BITBetaUpdatesViewController: UITableViewController {
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        } else {
            return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return NSLocalizedString("View Controllers", comment: "")
        } else {
            return NSLocalizedString("Alerts", comment: "")
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return NSLocalizedString("Presented UI relevant for localization", comment: "")
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        // Configure the cell...
        if indexPath.section == 0 {
            cell!.textLabel?.text = NSLocalizedString("Beta Updates", comment: "")
        } else {
            if (indexPath.row == 0) {
                cell!.textLabel?.text = NSLocalizedString("Update available", comment: "")
            } else if (indexPath.row == 1) {
                cell!.textLabel?.text = NSLocalizedString("Update available (3 buttons)", comment: "")
            } else {
                cell!.textLabel?.text = NSLocalizedString("Mandatory update available", comment: "")
            }
        }
        
        return cell!
    }
    
    //MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            BITHockeyManager.shared().updateManager.showUpdateView()
        } else {
            if indexPath.row == 2 {
                let alert = UIAlertController(title: BITHockeyLocalizedString("UpdateAvailable"), message:String(format: BITHockeyLocalizedString("UpdateAlertMandatoryTextWithAppVersion"), "DemoApp 5.0 (284)"), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: BITHockeyLocalizedString("UpdateInstall"), style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: BITHockeyLocalizedString("UpdateAvailable"), message: String(format: BITHockeyLocalizedString("UpdateAlertTextWithAppVersion"), "DemoApp 5.0 (284)"), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: BITHockeyLocalizedString("UpdateIgnore"), style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: BITHockeyLocalizedString("UpdateShow"), style: .default, handler: nil))
                if indexPath.row == 1 {
                    alert.addAction(UIAlertAction(title: BITHockeyLocalizedString("UpdateInstall"), style: .default, handler: nil))
                }
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

}
