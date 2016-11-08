//
//  BITFeedbackViewController.swift
//  HockeySDK-iOSDemo-Swift
//
//  Created by Kevin Li on 18/10/2016.
//

import UIKit

class BITFeedbackViewController: UITableViewController {

    // MARK: - Private
    func openShareActivity() {
        let feedbackActivity = BITFeedbackActivity.init()
        feedbackActivity.customActivityTitle = "Feedback"
        var activityViewController:UIActivityViewController? = UIActivityViewController.init(activityItems: ["Share this text"],applicationActivities: [feedbackActivity])
        activityViewController?.excludedActivityTypes = [.assignToContact]
        self.present(activityViewController!, animated: true) { 
            activityViewController?.excludedActivityTypes = nil
            activityViewController = nil
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 4
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return NSLocalizedString("View Controllers", comment: "")
        } else {
            return NSLocalizedString("Alerts", comment: "")
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 || section == 2 {
            return NSLocalizedString("Presented UI relevant for localization", comment: "")
        }
        
        return nil
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
                cell!.textLabel?.text = NSLocalizedString("Modal presentation", comment: "")
            } else if indexPath.row == 1 {
                cell!.textLabel?.text = NSLocalizedString("Compose feedback", comment: "")
            } else if indexPath.row == 2 {
                cell!.textLabel?.text = NSLocalizedString("Compose with screenshot", comment: "")
            } else {
                cell!.textLabel?.text = NSLocalizedString("Compose with data", comment: "")
            }
        } else if indexPath.section == 1 {
            cell!.textLabel?.text = NSLocalizedString("Activity/Share", comment: "")
        } else {
            cell!.textLabel?.text = NSLocalizedString("New feedback available", comment: "")
        }


        return cell!
    }

    //MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            let feedbackManager = BITHockeyManager.shared().feedbackManager
            if indexPath.row == 0 {
                feedbackManager.showFeedbackListView()
            } else if indexPath.row == 1 {
                feedbackManager.showFeedbackComposeView()
            } else if indexPath.row == 2 {
                feedbackManager.showFeedbackComposeViewWithGeneratedScreenshot()
            } else {
                let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
                let settingsDir = "\(path)/\(BITHOCKEY_IDENTIFIER)/BITFeedbackManager.plist"
                let binaryData = NSData(contentsOfFile: settingsDir)
                feedbackManager.showFeedbackComposeView(withPreparedItems: [binaryData!])
            }
        } else if indexPath.section == 1 {
            openShareActivity()
        } else {
            let alert = UIAlertController(title: BITHockeyLocalizedString("HockeyFeedbackNewMessageTitle"), message: BITHockeyLocalizedString("HockeyFeedbackNewMessageText"), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: BITHockeyLocalizedString("HockeyFeedbackIgnore"), style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: BITHockeyLocalizedString("HockeyFeedbackShow"), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
