//
//  OptionalExtension.swift
//  Codable
//
//  Created by Lei Wang on 2017/12/6.
//  Copyright © 2017年 Lei Wang. All rights reserved.
//

import Foundation


extension Optional where Wrapped == String {
    var unwrappedOrEmpty: String {
        switch self {
        case let .some(wrapped):
            return wrapped
        default:
            return ""
        }
    }
}
extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        switch self {
        case let .some(wrapped):
            return wrapped.isEmpty
        default:
            return true
        }
    }
}
