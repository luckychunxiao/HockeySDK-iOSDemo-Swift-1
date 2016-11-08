//
//  TodayViewController.swift
//  iOSDemo-Today
//
//  Created by Kevin Li on 16/10/26.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    var didSetupHockeySDK:Bool=false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !didSetupHockeySDK {
            BITHockeyManager.shared().configure(withIdentifier: "7af641bbf9b644eb91a48995f084f458")
            // optionally enable logging to get more information about states.
            BITHockeyManager.shared().logLevel = BITLogLevel.verbose
            BITHockeyManager.shared().crashManager.crashManagerStatus = .autoSend
            BITHockeyManager.shared().start()
            didSetupHockeySDK = true
        }
        self.preferredContentSize = CGSize.init(width: self.view.frame.size.width, height: 40.0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func widgetPerformUpdate(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    @IBAction func testCrashTapped(_ sender: AnyObject) {
        /* Trigger a crash */
        let array = NSArray.init()
        array.object(at: 24)
    }
}
