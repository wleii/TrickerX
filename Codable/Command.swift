//
//  Command.swift
//  Codable
//
//  Created by Lei Wang on 2017/12/6.
//  Copyright © 2017年 Lei Wang. All rights reserved.
//

import Foundation


enum Command: RawRepresentable {
    
    var rawValue: String {
        switch self {
        case .makeCodingKeys(let isSorting):
            if isSorting {
                return "makeCodingKeysWithSorting"
            }else {
                return "makeCodingKeys"
            }
        case .readme:
            return "readme"
        }
    }
    
    init?(rawValue: String) {
        switch rawValue {
        case "makeCodingKeys":
            self = .makeCodingKeys(sorting: false)
        case "makeCodingKeysWithSorting":
            self = .makeCodingKeys(sorting: true)
        case "readme":
            self = .readme
        default:
            return nil
        }
    }
    case makeCodingKeys(sorting: Bool)
    case readme
    
    var displayName: String {
        switch self {
        case .makeCodingKeys(let isSorting):
            if isSorting {
                return "Make Coding Key With Sorting"
            }else {
                return "Make Coding Key"
            }
        case .readme:
            return "README"
        }
    }
}


