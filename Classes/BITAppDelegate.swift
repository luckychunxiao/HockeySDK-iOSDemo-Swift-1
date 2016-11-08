//
//  BITAppDelegate.swift
//  HockeySDK-iOSDemo-Swift
//
//  Created by Kevin Li on 18/10/2016.
//

import UIKit

@UIApplicationMain
class BITAppDelegate: UIResponder, UIApplicationDelegate,BITHockeyManagerDelegate {

    var window: UIWindow?
    var rootViewController: UIViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        #if true //live
            BITHockeyManager.shared().configure(withIdentifier: "7af641bbf9b644eb91a48995f084f458",delegate: self)
            BITHockeyManager.shared().authenticator.authenticationSecret = "d7adc658f7168f3da93a5bd5c1947c00"
        #else //warmup
            BITHockeyManager.shared().configure(withIdentifier: "<#App ID#>",delegate: self)
            BITHockeyManager.shared().authenticator.authenticationSecret = "<#Secret#>"
        #endif
        BITHockeyManager.shared().authenticator.identificationType = BITAuthenticatorIdentificationType.device
        BITHockeyManager.shared().authenticator.restrictApplicationUsage = false
        
        // optionally enable logging to get more information about states.
        BITHockeyManager.shared().logLevel = BITLogLevel.verbose
        
        BITHockeyManager.shared().start()

        if didCrashInLastSessionOnStartup() {
            waitingUI()
        } else {
            setupApplication()
        }
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return BITHockeyManager.shared().authenticator.handleOpen(url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func  waitingUI() {
        // show intermediate UI
        print("Please wait ...")
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let waitingViewController = storyboard.instantiateViewController(withIdentifier: "PleaseWait")
        
        rootViewController = self.window?.rootViewController
        self.window?.rootViewController = waitingViewController
    }
    
    func setupApplication() {
        // setup your app specific code
        if rootViewController != nil {
            self.window?.rootViewController = rootViewController
        }
        BITHockeyManager.shared().authenticator.authenticateInstallation() // This line is obsolete in the crash only builds
    }
    
    func didCrashInLastSessionOnStartup() -> Bool {
        return (BITHockeyManager.shared().crashManager.didCrashInLastSession && BITHockeyManager.shared().crashManager.timeIntervalCrashInLastSessionOccurred < 5)
    }
    
    // MARK: - BITHockeyManagerDelegate
    
    /**
    func userID(for hockeyManager: BITHockeyManager!, componentManager: BITHockeyBaseManager!) -> String! {
        return "userID"
    }
    
    func userName(for hockeyManager: BITHockeyManager!, componentManager: BITHockeyBaseManager!) -> String! {
        return "userName"
    }
    
    func userEmail(for hockeyManager: BITHockeyManager!, componentManager: BITHockeyBaseManager!) -> String! {
        return "userEmail"
    }
     */
    
    
    // MARK: - BITCrashManagerDelegate
    
    func applicationLog(for crashManager: BITCrashManager!) -> String! {
        return "applicationLog"
    }
    
    /**
    func attachment(for crashManager: BITCrashManager!) -> BITHockeyAttachment! {
        let url = Bundle.main.url(forResource: "Default-568h@2x", withExtension: "png")
        let data = NSData.init(contentsOf: url!)
        let attachment = BITCrashAttachment.init(filename: "image.png", crashAttachmentData: data as Data!, contentType: "image/png")
        return attachment!
    }
     */
    
    func crashManagerWillCancelSendingCrashReport(_ crashManager: BITCrashManager!) {
        if didCrashInLastSessionOnStartup() {
            setupApplication()
        }
    }
    
    func crashManager(_ crashManager: BITCrashManager!, didFailWithError error: Error!) {
        if didCrashInLastSessionOnStartup() {
            setupApplication()
        }
    }
    
    func crashManagerDidFinishSendingCrashReport(_ crashManager: BITCrashManager!) {
        if didCrashInLastSessionOnStartup() {
            setupApplication()
        }
    }
    
}

