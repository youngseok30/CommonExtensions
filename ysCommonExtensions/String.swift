//
//  String.swift
//  ysCommonExtensions
//
//  Created by Ethan Lee on 2022/05/11.
//

import Foundation
import UIKit

extension String {
    
    func trim() -> String {
      return trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    var addedPercentEncoding: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
    }
    
    var toURL: URL? {
        return URL(string: self.addedPercentEncoding)
    }
    
    var intValue: Int? {
        return Int(self)
    }
    
    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else { return self }
        
        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to + 1)
        return String(self[startIndex ..< endIndex])
    }
    
    func isValidURL() -> Bool {
        if let url = URL(string: self) {
            return UIApplication.shared.canOpenURL(url)
        }
        
        return false
    }
    
    func base64Encoded(_ encoding: String.Encoding = .utf8) -> String? {
        return data(using: encoding)?.base64EncodedString()
    }
    
    func base64Decoded(_ encoding: String.Encoding = .utf8) -> String? {
        var localData: Data?
        localData = Data(base64Encoded: self)
        var temp: String = self
        if localData == nil {
            temp = self + "=="
        }
        guard let data = Data(base64Encoded: temp, options: Data.Base64DecodingOptions(rawValue: 0)) else {
            return nil
        }
        return String(data: data, encoding: encoding)
    }

}
