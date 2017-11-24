//
//  AppDelegate.swift
//  TrickerX
//
//  Created by Lei Wang on 2017/11/24.
//  Copyright © 2017年 Lei Wang. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        NSApp.setActivationPolicy(NSApplication.ActivationPolicy.prohibited)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

