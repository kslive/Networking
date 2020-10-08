//
//  AppDelegate.swift
//  DownloadImage
//
//  Created by Eugene Kiselev on 25.09.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var backgroundSessionCompletionHandler: (() -> ())?

    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        
        backgroundSessionCompletionHandler = completionHandler
    }
}

