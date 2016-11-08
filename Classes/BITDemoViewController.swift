//
//  BITDemoViewController.swift
//  HockeySDK-iOSDemo-Swift
//
//  Created by Kevin Li on 18/10/2016.
//

import UIKit

class BITDemoViewController: UITableViewController,UIAlertViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Settings", style: UIBarButtonItemStyle.plain, target: self, action: #selector(showSettings))
        self.title = NSLocalizedString("App", comment: "")
    }

    func showSettings() {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let settingsViewController = storyboard.instantiateViewController(withIdentifier: "BITSettingsViewController") as! BITSettingsViewController
        let navController = UINavigationController.init(rootViewController: settingsViewController)
        navController.modalTransitionStyle = .coverVertical
        self.present(navController, animated: true, completion: nil)
    }
    
    // MARK: - view controller
    override var shouldAutorotate: Bool{

        if UIDevice.current.userInterfaceIdiom == .pad  {
            return true
        } else {
            return UIDevice.current.orientation != .portraitUpsideDown
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        switch indexPath.row {
        case 0:
            cell!.textLabel?.text = NSLocalizedString("Authorize", comment: "")
        case 1:
            cell!.textLabel?.text = NSLocalizedString("Beta Updates", comment: "")
        case 2:
            cell!.textLabel?.text = NSLocalizedString("Store Updates", comment: "")
        case 3:
            cell!.textLabel?.text = NSLocalizedString("Feedback", comment: "")
        case 4:
            cell!.textLabel?.text = NSLocalizedString("Crash Reports", comment: "")
        default:
            break
        }
        
        
        return cell!
    }
    
    //MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        switch indexPath.row {
        case 0:
            let authenticatorDemoViewController = storyboard.instantiateViewController(withIdentifier: "BITAuthenticatorDemoViewController") as! BITAuthenticatorDemoViewController
            self.navigationController?.pushViewController(authenticatorDemoViewController, animated: true)
            
        case 1:
            let betaUpdatesViewController = storyboard.instantiateViewController(withIdentifier: "BITBetaUpdatesViewController") as! BITBetaUpdatesViewController
            self.navigationController?.pushViewController(betaUpdatesViewController, animated: true)
            
        case 2:
            let storeUpdatesViewController = storyboard.instantiateViewController(withIdentifier: "BITStoreUpdatesViewController") as! BITStoreUpdatesViewController
            self.navigationController?.pushViewController(storeUpdatesViewController, animated: true)

        case 3:
            let feedbackViewController = storyboard.instantiateViewController(withIdentifier: "BITFeedbackViewController") as! BITFeedbackViewController
            self.navigationController?.pushViewController(feedbackViewController, animated: true)
            
        case 4:
            let crashReportsViewController = storyboard.instantiateViewController(withIdentifier: "BITCrashReportsViewController") as! BITCrashReportsViewController
            self.navigationController?.pushViewController(crashReportsViewController, animated: true)
            
        default:
            break
        }
    }
    
}
