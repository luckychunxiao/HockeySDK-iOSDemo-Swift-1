//
//  BITCrashReportsViewController.swift
//  HockeySDK-iOSDemo-Swift
//
//  Created by Kevin Li on 18/10/2016.
//

import UIKit

class BITCrashReportsViewController: UITableViewController {
    
    //MARK: - Private

    func triggerSignalCrash() {
        /* Trigger a crash */
        abort()
    }
    
    func triggerExceptionCrash() {
        /* Trigger a crash */
        let array = NSArray.init()
        array.object(at: 23)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 2
        } else {
            return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return NSLocalizedString("Test Crashes", comment: "")
        } else {
            return NSLocalizedString("Alerts", comment: "")
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 1 {
            return NSLocalizedString("Presented UI relevant for localization", comment: "")
        }
        
        return nil;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        // Configure the cell...
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell!.textLabel?.text = NSLocalizedString("Signal", comment: "");
            } else {
                cell!.textLabel?.text = NSLocalizedString("Exception", comment: "");
            }
        } else {
            if (indexPath.row == 0) {
                cell!.textLabel?.text = NSLocalizedString("Anonymous", comment: "");
            } else if (indexPath.row == 1) {
                cell!.textLabel?.text = NSLocalizedString("Anonymous 3 buttons", comment: "");
            } else {
                cell!.textLabel?.text = NSLocalizedString("Non-anonymous", comment: "");
            }
        }

        return cell!
    }
    
    //MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                triggerSignalCrash()
            } else {
                triggerExceptionCrash()
            }
        } else {
            let appName = "DemoApp"
            var alertDescription = String(format: BITHockeyLocalizedString("CrashDataFoundAnonymousDescription"), appName)
            if indexPath.row == 2 {
                alertDescription = String(format: BITHockeyLocalizedString("CrashDataFoundDescription"), appName)
            }
            
            let alert = UIAlertController(title:String(format:BITHockeyLocalizedString("CrashDataFoundTitle"), appName), message: alertDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: BITHockeyLocalizedString("CrashDontSendReport"), style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: BITHockeyLocalizedString("CrashSendReport"), style: .default, handler: nil))
            if indexPath.row == 1 {
                alert.addAction(UIAlertAction(title: BITHockeyLocalizedString("CrashSendReportAlways"), style: .default, handler: nil))
            }
            self.present(alert, animated: true, completion: nil)
        }

    }

}
