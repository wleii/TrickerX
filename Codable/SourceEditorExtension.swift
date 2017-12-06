//
//  SourceEditorExtension.swift
//  Codable
//
//  Created by Lei Wang on 2017/11/24.
//  Copyright © 2017年 Lei Wang. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorExtension: NSObject, XCSourceEditorExtension {
    
    /*
    func extensionDidFinishLaunching() {
        // If your extension needs to do any work at launch, implement this optional method.
    }
    */
    
    var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: Any]] {
        // If your extension needs to return a collection of command definitions that differs from those in its Info.plist, implement this optional property getter.
        let className = SourceEditorCommand.className()
        let commaneds: [Command] = [.makeCodingKeys , .readme]
        
        return commaneds.map({ (command) -> [XCSourceEditorCommandDefinitionKey: Any] in
            return  [
                .nameKey: command.displayName,
                .classNameKey: className,
                .identifierKey: command.rawValue,
            ]
        })
    }
 
    
}
