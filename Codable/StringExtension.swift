//
//  StringExtension.swift
//  Codable
//
//  Created by Lei Wang on 2017/12/6.
//  Copyright © 2017年 Lei Wang. All rights reserved.
//

import Foundation

extension String {
    
    func match(regex: Regex) -> String?  {
        return self.match(regex: regex.rawValue)
    }
    
    func match(regex: String) -> String? {
        let matchList: [String] = match(regex: regex)
        return matchList.first
    }
    
    func match(regex: String) -> [String] {
        if isEmpty {
            return []
        }
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let results = regex.matches(in: self, options: [], range: NSRange.init(startIndex..., in: self))
            return results.map({ (result) -> String in
                let range = Range.init(result.range, in: self)
                return String(self[range!])
            })
        }
        catch {
            return []
        }
    }
    
    func snakeCased() -> String? {
        let pattern = "([a-z0-9])([A-Z])"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: count)
        return regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1_$2").lowercased()
    }
}
