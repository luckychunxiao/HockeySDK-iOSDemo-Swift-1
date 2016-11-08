//
//  BITStoreUpdatesViewController.swift
//  HockeySDK-iOSDemo-Swift
//
//  Created by Kevin Li on 18/10/2016.
//

import UIKit

class BITStoreUpdatesViewController: UITableViewController {

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString("Alerts", comment: "");
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
        cell!.textLabel?.text = NSLocalizedString("New Update available", comment: "");

        return cell!
    }
    
    //MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let versionString = String(format: "%@6.0", BITHockeyLocalizedString("UpdateVersion"))
        let alert = UIAlertController(title: BITHockeyLocalizedString("UpdateAvailable"), message: String(format:BITHockeyLocalizedString("UpdateAlertTextWithAppVersion"),versionString), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: BITHockeyLocalizedString("UpdateIgnore"), style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: BITHockeyLocalizedString("UpdateRemindMe"), style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: BITHockeyLocalizedString("UpdateShow"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
