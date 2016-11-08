//
//  BITAuthenticatorDemoViewController.swift
//  HockeyApp-iOSDemo-Swift
//
//  Created by Kevin Li on 16/10/23.
//

import UIKit

class BITAuthenticatorDemoViewController: UITableViewController {

    var restrictAppUsageSwitch = UISwitch.init(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.restrictAppUsageSwitch.setOn(true, animated: false)
    }
    
    //MARK: - Private
    func authenticateAnonymous() {
        let authenticator = BITHockeyManager.shared().authenticator
        authenticator.cleanupInternalStorage()
        authenticator.identificationType = .anonymous
        authenticator.restrictApplicationUsage = self.restrictAppUsageSwitch.isOn
        authenticator.authenticateInstallation()
    }
    
    func authenticateDevice() {
        let authenticator = BITHockeyManager.shared().authenticator
        authenticator.cleanupInternalStorage()
        authenticator.identificationType = .device
        authenticator.restrictApplicationUsage = self.restrictAppUsageSwitch.isOn
        authenticator.authenticateInstallation()
    }
    
    func authenticateEmail() {
        let authenticator = BITHockeyManager.shared().authenticator
        authenticator.cleanupInternalStorage()
        authenticator.identificationType = .hockeyAppEmail
        authenticator.restrictApplicationUsage = self.restrictAppUsageSwitch.isOn
        authenticator.authenticateInstallation()
    }
    
    func authenticateAccount() {
        let authenticator = BITHockeyManager.shared().authenticator
        authenticator.cleanupInternalStorage()
        authenticator.identificationType = .hockeyAppUser
        authenticator.restrictApplicationUsage = self.restrictAppUsageSwitch.isOn
        authenticator.authenticateInstallation()
    }
    
    func authenticateWebAuth() {
        let authenticator = BITHockeyManager.shared().authenticator
        authenticator.cleanupInternalStorage()
        authenticator.identificationType = .webAuth
        authenticator.restrictApplicationUsage = false
        authenticator.identify(completion: nil)
    }
    
    func authenticateInstallation() {
        let authenticator = BITHockeyManager.shared().authenticator
        authenticator.identify { (identified, error) in
            print("Identified: \(identified)")
            print("Error: \(error)")
        }
    }
    
    func validateInstallation() {
        let authenticator = BITHockeyManager.shared().authenticator
        authenticator.validate { (validated, error) in
            print("Validated: \(validated)")
            print("Error: \(error)")
        }
    }
    
    func resetAuthenticator() {
        let authenticator = BITHockeyManager.shared().authenticator
        authenticator.cleanupInternalStorage()
    }
    
    func askForIdentification() {
        let authenticator = BITHockeyManager.shared().authenticator
        authenticator.cleanupInternalStorage()
        //this should've been set on initial app launch
        authenticator.identificationType = .anonymous
        
        //present an alertView and kindly ask the user to identify to allow an easier
        //AdHoc handling
        
        let alert = UIAlertController(title: nil, message: "Would you like to help the developers during the Beta by identifying yourself via your device ID?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Never", style: .cancel, handler: { (action) in
            //user doesn't want to be identified.
            //you could store a flag to user-defaults and never ask him again
        }))
        
        alert.addAction(UIAlertAction(title: "Sure!", style: .default, handler: { (action) in
            //cool, lets configure the authenticator and let it show the login view
            let authenticator = BITHockeyManager.shared().authenticator
            authenticator.identificationType = .device
            //you could either switch back authenticator to automatic mode on app launch,
            //or do it all for yourself. For now, just to it ourselves
            //authenticator.automaticMode = YES;
            authenticator.identify(completion: { (identified, error) in
                if identified {
                    let alert = UIAlertController.init(title: nil, message: "Thanks", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkAndBlock() {
        let authenticator = BITHockeyManager.shared().authenticator
        if !authenticator.isIdentified {
            let alert = UIAlertController(title: "Error", message: "Make sure to identify the user first", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let blockingAlert = UIAlertController(title: nil, message: "Please stand by...", preferredStyle: .alert)
        blockingAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        authenticator.validate { (validated, error) in
            if validated {
                blockingAlert.dismiss(animated: true, completion: nil)
            } else {
                //if he's not allowed to test the app anymore, show another alert,
                //exit the app, etc.
                let errorAlert = UIAlertController(title: nil, message: error?.localizedDescription, preferredStyle: .alert)
                self.present(errorAlert, animated: true, completion: nil)
            }
        }
        self.present(blockingAlert, animated: true, completion: nil)
        
    }
    
    // MARK: -
    func handleAlerts(index:Int) {
        let alert = UIAlertController(title: nil, message: authenticatorAlertMessages()[index], preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func authenticatorAlertMessages() -> Array<String> {
        
        var messages = Array<String>.init()
        let once:() = {
            messages = [BITHockeyLocalizedString("HockeyAuthenticationViewControllerNetworkError"),
                        BITHockeyLocalizedString("HockeyAuthenticationFailedAuthenticate"),
                        BITHockeyLocalizedString("HockeyAuthenticationNotMember"),
                        BITHockeyLocalizedString("HockeyAuthenticationContactDeveloper"),
                        BITHockeyLocalizedString("HockeyAuthenticationWrongEmailPassword")]
        }()
        _ = once
        
        return messages
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 6
        } else if section == 1 {
            return 5
        } else if section == 2 {
            return 3
        } else {
            return 2
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return NSLocalizedString("Authenticate",comment: "")
        } else if section == 1 {
            return NSLocalizedString("Alerts",comment: "")
        } else if section == 2 {
            return NSLocalizedString("Tests",comment: "")
        } else {
            return NSLocalizedString("Internal Tests",comment: "")
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 || section == 1 {
            return NSLocalizedString("Presented UI relevant for localization",comment: "")
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }

        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell!.textLabel?.text = NSLocalizedString("Anonymous", comment: "")
            } else if indexPath.row == 1 {
                cell!.textLabel?.text = NSLocalizedString("Device", comment: "")
            } else if indexPath.row == 2 {
                cell!.textLabel?.text = NSLocalizedString("Email", comment: "")
            } else if indexPath.row == 3 {
                cell!.textLabel?.text = NSLocalizedString("Account", comment: "")
            } else if indexPath.row == 4 {
                cell!.textLabel?.text = NSLocalizedString("WebAuth", comment: "")
            } else {
                cell!.textLabel?.text = NSLocalizedString("Restrict application usage", comment: "")
                cell!.accessoryView = self.restrictAppUsageSwitch;
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell!.textLabel?.text = NSLocalizedString("Network Error", comment: "")
            } else if indexPath.row == 1 {
                cell!.textLabel?.text = NSLocalizedString("Failed Authenticate", comment: "")
            } else if indexPath.row == 2 {
                cell!.textLabel?.text = NSLocalizedString("Not Member", comment: "")
            } else if indexPath.row == 3 {
                cell!.textLabel?.text = NSLocalizedString("Contact Developer", comment: "")
            } else {
                cell!.textLabel?.text = NSLocalizedString("Wrong Email/Password", comment: "")
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                cell!.textLabel?.text = NSLocalizedString("Identify", comment: "")
            } else if indexPath.row == 1 {
                cell!.textLabel?.text = NSLocalizedString("Validate", comment: "")
            } else {
                cell!.textLabel?.text = NSLocalizedString("Reset", comment: "")
            }
        } else {
            if indexPath.row == 0 {
                cell!.textLabel?.text = NSLocalizedString("Ask for ident", comment: "")
            } else {
                cell!.textLabel?.text = NSLocalizedString("Validate and potentially block", comment: "")
            }
        }

        return cell!
    }
    
    //MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        if indexPath.section == 0 && indexPath.row == 5 {
            return nil
        }
        
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                authenticateAnonymous()
            } else if indexPath.row == 1 {
                authenticateDevice()
            } else if indexPath.row == 2 {
                authenticateEmail()
            } else if indexPath.row == 3 {
                authenticateAccount()
            } else if indexPath.row == 4 {
                authenticateWebAuth()
            }
        } else if indexPath.section == 1 {
            handleAlerts(index: indexPath.row)
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                authenticateInstallation()
            } else if indexPath.row == 1 {
                validateInstallation()
            } else {
                resetAuthenticator()
            }
        } else {
            if indexPath.row == 0 {
                askForIdentification()
            } else {
                checkAndBlock()
            }
        }
    }

}
