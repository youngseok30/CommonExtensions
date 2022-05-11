//
//  NSObject.swift
//  ysCommonExtensions
//
//  Created by Ethan Lee on 2022/05/11.
//

import Foundation

extension NSObject {
    class var className: String {
        return String(describing: self).components(separatedBy: ".").last ?? ""
    }
  
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last ?? ""
    }
}
