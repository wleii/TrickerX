//
//  SourceEditorCommand.swift
//  Codable
//
//  Created by Lei Wang on 2017/11/24.
//  Copyright © 2017年 Lei Wang. All rights reserved.
//

import Foundation
import XcodeKit


class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        let textRange = invocation.buffer.selections.firstObject as! XCSourceTextRange
        var startLine = textRange.start.line
        
        let endRegex = """
            .*\\{
            """
        let isPropertyRegex = ".*(let|var)\\s+.\\w+\\s*:(?!(.*(\\(|\\{|\\=)))"
        let propertyRegex = "\\w+\\s*(:)"
        let uppercase = "A"..."Z"
        
        var enumCase: [(key: String, value: String)] = []
        
        while startLine >= 0 {
            guard let lineText = invocation.buffer.lines[startLine] as? String else { startLine -= 1; continue }
            if lineText.isMatch(endRegex) {
                break
            }
            var propertyName: String = lineText.match(regex: isPropertyRegex)
            if propertyRegex.isEmpty {
                startLine -= 1
                continue
            }
            propertyName = propertyName.match(regex: propertyRegex).replacingOccurrences(of: ":", with: "")
            var rawValue = ""
            var previousWordIsUppercase = false
            for character in propertyName {
                let word = String(character)
                if uppercase.contains(word) {
                    if !previousWordIsUppercase {
                        rawValue.append("_")
                    }
                    rawValue.append(word.lowercased())
                    previousWordIsUppercase = true
                }else {
                    rawValue.append(word.lowercased())
                    previousWordIsUppercase = false
                }
                
            }
            if !rawValue.isEmpty {
                enumCase.append((key: propertyName, value: rawValue))
            }
            startLine -= 1
        }
        
        guard !enumCase.isEmpty else {
            completionHandler(nil)
            return
        }
        
        var updateSelectionIndexs: [Int] = []
        var writeLine = textRange.start.line + 1
        updateSelectionIndexs.append(writeLine)
        
        var indentSpaces = ""
        let spaceRegex = "^(\\s|\\t)*"
        indentSpaces = (invocation.buffer.lines[textRange.start.line] as! String).match(regex: spaceRegex).replacingOccurrences(of: "\n", with: "")
        
        var writeText = "\(indentSpaces)enum CodingKeys: String, CodingKey {"
        invocation.buffer.lines.insert(writeText, at: writeLine)
        
        let caseIndentSpaces = repeatElement(" ", count: invocation.buffer.indentationWidth).joined()
        
        for caseTuple in enumCase.reversed() {
            writeLine += 1
            let key = caseTuple.key
            let value = caseTuple.value
            var text = "\(indentSpaces)\(caseIndentSpaces)case \(key)"
            if !value.isEmpty, key != value {
                text += " = \"\(value)\""
            }
            writeText = text
            invocation.buffer.lines.insert(writeText, at: writeLine)
            updateSelectionIndexs.append(writeLine)
        }
        let endText = "\(indentSpaces)}"
        writeLine += 1
        invocation.buffer.lines.insert(endText, at: writeLine)
        
        let textRanges = updateSelectionIndexs.map { (index) -> XCSourceTextRange in
            let sourceTextRange = XCSourceTextRange()
            sourceTextRange.start = XCSourceTextPosition(line: index, column: 0)
            sourceTextRange.end = XCSourceTextPosition(line: index, column: 0)
            return sourceTextRange
        }
        
        
        invocation.buffer.selections.setArray(textRanges)
        
        completionHandler(nil)
    }
    
}


private extension String {
    
    func match(regex: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            if let result = regex.firstMatch(in: self, options: [], range: NSRange.init(startIndex..., in: self)) {
                let range = Range.init(result.range, in: self)
                return String(self[range!])
            }else {
                return ""
            }
        }
        catch {
            return ""
        }
    }
    func isMatch(_ regex: String) -> Bool {
        return !match(regex: regex).isEmpty
    }
}
