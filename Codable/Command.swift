//
//  Command.swift
//  Codable
//
//  Created by Lei Wang on 2017/12/6.
//  Copyright © 2017年 Lei Wang. All rights reserved.
//

import Foundation


enum Command: String {
    init?(rawValue: String) {
        switch rawValue {
        case "makeCodingKeys":
            self = .makeCodingKeys
        case "readme":
            self = .readme
        default:
            return nil
        }
    }
    case makeCodingKeys
    case readme
    
    var displayName: String {
        switch self {
        case .makeCodingKeys:
            return "Make Coding Key"
        case .readme:
            return "README"
        }
    }
}


